"""Regenerate src/bindings/Expect.res + Expect.resi from Vitest/JestDom blocks.

Usage:
  python3 scripts/gen_expect.py          # regenerate in place
  python3 scripts/gen_expect.py --check  # exit 1 if committed files drifted

`Expect` re-declares every matcher external with identical attributes and
JS payloads (zero-cost). Run this after editing Vitest.res / JestDom.res.
CI runs --check.
"""

import difflib
import re
import sys
from pathlib import Path

SRC = Path(__file__).resolve().parent.parent / "src" / "bindings"


def build() -> "tuple[str, str]":
    v = (SRC / "Vitest.res").read_text()
    j = (SRC / "JestDom.res").read_text()

    # --- Vitest slice: Expect section to end of file ---
    i = v.find("/* Expect")
    start = v.rfind("/* ---", 0, i)
    vslice = v[start:].rstrip() + "\n"

    # Drop Vitest's own type definitions (Expect defines aliases instead).
    alias_block = """/** Opaque assertion handle carrying the asserted value type `'value` and a
    phantom `'mode` (`sync` until `resolves`/`rejects` switches it to `async`).
    Sync matchers require `sync`; `*Async` matchers require `async` and must
    be awaited, so an un-awaited async assertion cannot silently pass. */
type sync

type async

type assertion<'value, 'mode>
"""
    assert alias_block in vslice, "alias block not found"
    vslice = vslice.replace(alias_block, "")
    # Point mock matchers at Vitest's Vi module.
    vslice = vslice.replace("Vi.mock", "Vitest.Vi.mock")

    # --- JestDom slice: everything after the file header comment ---
    end_header = j.find("*/") + len("*/")
    jslice = j[end_header:].strip() + "\n"
    jslice = jslice.replace("Vitest.assertion<'a, Vitest.sync>", "assertion<'a, sync>")

    header_res = """/* Unified assertion entry point: every `expect` matcher in one namespace.
 *
 * Docs: https://vitest.dev/api/expect,
 *   https://github.com/testing-library/jest-dom
 *
 * Re-declares (zero-cost, same attributes and JS payloads):
 * - `Vitest`'s `expect` machinery, asymmetric helpers, core `toX` matchers,
 *   mock matchers, and the `Assert` submodule.
 * - All `JestDom` matchers, same overload convention (`toHaveX`,
 *   `toHaveXRegex`, `toHaveXWith`, `toHaveNoX`).
 *
 * Use this instead of `Vitest.expect` / `JestDom.*` so `Expect.` completes
 * with the full matcher list (including docs) in the editor, e.g.
 *   Expect.expect(el)->Expect.toBeInTheDocument
 *
 * `Vitest` (runner: describe/test/hooks/Vi) and `JestDom` keep working;
 * `App_test.res` uses this module. When adding a matcher upstream, add it
 * here too — see `src/bindings/README.md`. Regenerate with
 * `python3 scripts/gen_expect.py` (never hand-edit the re-declared blocks).
 */

/** Same handle as `Vitest.assertion`: aliases (not new types), so `Expect`
    values interoperate with anything typed as `Vitest.assertion`. */
type sync = Vitest.sync

type async = Vitest.async

type assertion<'value, 'mode> = Vitest.assertion<'value, 'mode>

"""

    header_resi = """/* Interface for Expect bindings — keeps `external`s inlinable.
   Mirrors Expect.res exactly (attributes included). See it for docs.
   Regenerate with `python3 scripts/gen_expect.py` (never hand-edit). */

/** Same handle as `Vitest.assertion`: aliases (not new types), so `Expect`
    values interoperate with anything typed as `Vitest.assertion`. */
type sync = Vitest.sync

type async = Vitest.async

type assertion<'value, 'mode> = Vitest.assertion<'value, 'mode>

"""

    dom_banner = """/* ------------------------------------------------------------------ */
/* jest-dom matchers (re-declared from JestDom, same JS payloads)         */
/* ------------------------------------------------------------------ */

"""

    body = header_res + vslice + "\n" + dom_banner + jslice
    bodyi = header_resi + vslice + "\n" + dom_banner + jslice

    for name, content in (("Expect.res", body), ("Expect.resi", bodyi)):
        exts = re.findall(r"external\s+(\w+)", content)
        assert len(exts) == len(set(exts)), f"DUPLICATE external names in {name}!"
    return body, bodyi


def main() -> int:
    check = "--check" in sys.argv
    body, bodyi = build()
    targets = {"Expect.res": body, "Expect.resi": bodyi}
    if not check:
        for name, content in targets.items():
            (SRC / name).write_text(content)
        print(f"wrote Expect.res + Expect.resi ({len(targets)} files)")
        return 0
    failed = False
    for name, content in targets.items():
        current = (SRC / name).read_text()
        if current != content:
            failed = True
            print(f"DRIFT in {name}:")
            print(
                "".join(
                    difflib.unified_diff(
                        current.splitlines(keepends=True),
                        content.splitlines(keepends=True),
                        fromfile=f"committed {name}",
                        tofile=f"generated {name}",
                    )
                )
            )
    if failed:
        print("Expect facade drifted — run: python3 scripts/gen_expect.py")
        return 1
    print("Expect facade in sync.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
