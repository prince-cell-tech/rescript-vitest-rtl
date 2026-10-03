/* Interface for Vitest bindings — keeps `external`s inlinable.
   Mirrors Vitest.res exactly (attributes included). See Vitest.res for docs. */

@module("vitest") external describe: (string, unit => unit) => unit = "describe"
@module("vitest") external describeAsync: (string, unit => promise<unit>) => unit = "describe"
@module("vitest") external describeWithTimeout: (string, unit => unit, int) => unit = "describe"
@module("vitest") @scope("describe") external describeSkip: (string, unit => unit) => unit = "skip"
@module("vitest") @scope("describe") external describeTodo: (string, unit => unit) => unit = "todo"
@module("vitest") @scope("describe")
external describeConcurrent: (string, unit => unit) => unit = "concurrent"
@module("vitest") @scope("describe")
external describeConcurrentAsync: (string, unit => promise<unit>) => unit = "concurrent"
@module("vitest") @scope("describe") external describeShuffle: (string, unit => unit) => unit = "shuffle"
@module("vitest") @scope("describe")
external describeSkipIf: bool => ((string, unit => unit) => unit) = "skipIf"
@module("vitest") @scope("describe")
external describeRunIf: bool => ((string, unit => unit) => unit) = "runIf"
@module("vitest") @scope("describe")
external describeEach: array<'a> => ((string, 'a => unit) => unit) = "each"
@module("vitest") @scope("describe")
external describeFor: array<'a> => ((string, 'a => unit) => unit) = "for"
@module("vitest") external suite: (string, unit => unit) => unit = "suite"
@module("vitest") external suiteAsync: (string, unit => promise<unit>) => unit = "suite"

@module("vitest") external test: (string, unit => unit) => unit = "test"
@module("vitest") external it: (string, unit => unit) => unit = "it"
@module("vitest") external testAsync: (string, unit => promise<unit>) => unit = "test"
@module("vitest") external itAsync: (string, unit => promise<unit>) => unit = "it"
@module("vitest") external testWithTimeout: (string, unit => unit, int) => unit = "test"
@module("vitest") external itWithTimeout: (string, unit => unit, int) => unit = "it"
@module("vitest") @scope("test") external testSkip: (string, unit => unit) => unit = "skip"
@module("vitest") @scope("it") external itSkip: (string, unit => unit) => unit = "skip"
@module("vitest") @scope("test") external testTodo: (string, unit => unit) => unit = "todo"
@module("vitest") @scope("it") external itTodo: (string, unit => unit) => unit = "todo"
@module("vitest") @scope("test") external testConcurrent: (string, unit => unit) => unit = "concurrent"
@module("vitest") @scope("it") external itConcurrent: (string, unit => unit) => unit = "concurrent"
@module("vitest") @scope("test")
external testConcurrentAsync: (string, unit => promise<unit>) => unit = "concurrent"
@module("vitest") @scope("it")
external itConcurrentAsync: (string, unit => promise<unit>) => unit = "concurrent"
@module("vitest") @scope("test") external testFails: (string, unit => unit) => unit = "fails"
@module("vitest") @scope("it") external itFails: (string, unit => unit) => unit = "fails"
@module("vitest") @scope("test")
external testSkipIf: bool => ((string, unit => unit) => unit) = "skipIf"
@module("vitest") @scope("it")
external itSkipIf: bool => ((string, unit => unit) => unit) = "skipIf"
@module("vitest") @scope("test")
external testRunIf: bool => ((string, unit => unit) => unit) = "runIf"
@module("vitest") @scope("it")
external itRunIf: bool => ((string, unit => unit) => unit) = "runIf"
@module("vitest") @scope("test")
external testEach: array<'a> => ((string, 'a => unit) => unit) = "each"
@module("vitest") @scope("it")
external itEach: array<'a> => ((string, 'a => unit) => unit) = "each"
@module("vitest") @scope("test")
external testFor: array<'a> => ((string, 'a => unit) => unit) = "for"
@module("vitest") @scope("it")
external itFor: array<'a> => ((string, 'a => unit) => unit) = "for"

@module("vitest") external beforeEach: (unit => unit) => unit = "beforeEach"
@module("vitest") external beforeEachAsync: (unit => promise<unit>) => unit = "beforeEach"
@module("vitest") external afterEach: (unit => unit) => unit = "afterEach"
@module("vitest") external afterEachAsync: (unit => promise<unit>) => unit = "afterEach"
@module("vitest") external beforeAll: (unit => unit) => unit = "beforeAll"
@module("vitest") external beforeAllAsync: (unit => promise<unit>) => unit = "beforeAll"
@module("vitest") external afterAll: (unit => unit) => unit = "afterAll"
@module("vitest") external afterAllAsync: (unit => promise<unit>) => unit = "afterAll"
@module("vitest")
external aroundEach: ((unit => promise<unit>) => promise<unit>) => unit = "aroundEach"
@module("vitest")
external aroundAll: ((unit => promise<unit>) => promise<unit>) => unit = "aroundAll"
@module("vitest") external onTestFailed: (unit => unit) => unit = "onTestFailed"
@module("vitest") external onTestFailedAsync: (unit => promise<unit>) => unit = "onTestFailed"
@module("vitest") external onTestFinished: (unit => unit) => unit = "onTestFinished"
@module("vitest") external onTestFinishedAsync: (unit => promise<unit>) => unit = "onTestFinished"

module Vi: {
  type mock<'fn>
  @module("vitest") @scope("vi") external fn: unit => mock<'fn> = "fn"
  @module("vitest") @scope("vi") external fnWithImpl: 'fn => mock<'fn> = "fn"
  @module("vitest") @scope("vi") external spyOn: ({..}, string) => mock<'fn> = "spyOn"
  @module("vitest") @scope("vi") external isMockFunction: 'a => bool = "isMockFunction"
  external asFn: mock<'fn> => 'fn = "%identity"
  @send external mockReturnValue: (mock<'args => 'r>, 'r) => mock<'args => 'r> = "mockReturnValue"
  @send external mockReturnValueOnce: (mock<'args => 'r>, 'r) => mock<'args => 'r> = "mockReturnValueOnce"
  @send
  external mockResolvedValue: (mock<'args => promise<'r>>, 'r) => mock<'args => promise<'r>> =
    "mockResolvedValue"
  @send
  external mockResolvedValueOnce: (mock<'args => promise<'r>>, 'r) => mock<'args => promise<'r>> =
    "mockResolvedValueOnce"
  @send external mockImplementation: (mock<'fn>, 'fn) => mock<'fn> = "mockImplementation"
  @send external mockImplementationOnce: (mock<'fn>, 'fn) => mock<'fn> = "mockImplementationOnce"
  @send external mockClear: mock<'fn> => mock<'fn> = "mockClear"
  @send external mockReset: mock<'fn> => mock<'fn> = "mockReset"
  @send external mockRestore: mock<'fn> => mock<'fn> = "mockRestore"
  @send external mockName: (mock<'fn>, string) => mock<'fn> = "mockName"
  @module("vitest") @scope("vi") external useFakeTimers: unit => unit = "useFakeTimers"
  @module("vitest") @scope("vi") external useRealTimers: unit => unit = "useRealTimers"
  @module("vitest") @scope("vi") external runAllTimers: unit => unit = "runAllTimers"
  @module("vitest") @scope("vi") external runAllTimersAsync: unit => promise<unit> = "runAllTimersAsync"
  @module("vitest") @scope("vi") external runOnlyPendingTimers: unit => unit = "runOnlyPendingTimers"
  @module("vitest") @scope("vi") external advanceTimersByTime: int => unit = "advanceTimersByTime"
  @module("vitest") @scope("vi")
  external advanceTimersByTimeAsync: int => promise<unit> = "advanceTimersByTimeAsync"
  @module("vitest") @scope("vi") external advanceTimersToNextTimer: unit => unit = "advanceTimersToNextTimer"
  @module("vitest") @scope("vi") external clearAllTimers: unit => unit = "clearAllTimers"
  @module("vitest") @scope("vi") external getTimerCount: unit => int = "getTimerCount"
  @module("vitest") @scope("vi") external isFakeTimers: unit => bool = "isFakeTimers"
  @module("vitest") @scope("vi") external setSystemTime: int => unit = "setSystemTime"
  @module("vitest") @scope("vi") external getRealSystemTime: unit => float = "getRealSystemTime"
  @module("vitest") @scope("vi") external waitFor: (unit => 'a) => promise<'a> = "waitFor"
  @module("vitest") @scope("vi") external waitUntil: (unit => 'a) => promise<'a> = "waitUntil"
  @module("vitest") @scope("vi") external stubGlobal: (string, 'a) => unit = "stubGlobal"
  @module("vitest") @scope("vi") external unstubAllGlobals: unit => unit = "unstubAllGlobals"
  @module("vitest") @scope("vi") external stubEnv: (string, string) => unit = "stubEnv"
  @module("vitest") @scope("vi") external unstubAllEnvs: unit => unit = "unstubAllEnvs"
  @module("vitest") @scope("vi") external clearAllMocks: unit => unit = "clearAllMocks"
  @module("vitest") @scope("vi") external resetAllMocks: unit => unit = "resetAllMocks"
  @module("vitest") @scope("vi") external restoreAllMocks: unit => unit = "restoreAllMocks"
}

type sync

type async

type assertion<'value, 'mode>

@module("vitest") external expect: 'a => assertion<'a, sync> = "expect"
@module("vitest") @scope("expect") external expectSoft: 'a => assertion<'a, sync> = "soft"
@module("vitest") @scope("expect") external expectAssertions: int => unit = "assertions"
@module("vitest") @scope("expect") external expectHasAssertions: unit => unit = "hasAssertions"
@get external not: assertion<'a, 'mode> => assertion<'a, 'mode> = "not"
@get external resolves: assertion<promise<'a>, sync> => assertion<'a, async> = "resolves"
@get external rejects: assertion<promise<'a>, sync> => assertion<unknown, async> = "rejects"
@module("vitest") @scope("expect") external expectAnything: unit => unknown = "anything"
@module("vitest") @scope("expect") external expectAny: 'a => unknown = "any"
@module("vitest") @scope("expect") external expectObjectContaining: 'a => unknown = "objectContaining"
@module("vitest") @scope("expect") external expectArrayContaining: array<'a> => unknown = "arrayContaining"
@module("vitest") @scope("expect") external expectStringContaining: string => unknown = "stringContaining"
@module("vitest") @scope("expect")
external expectStringMatchingString: string => unknown = "stringMatching"
@module("vitest") @scope("expect") external expectStringMatchingRegex: RegExp.t => unknown = "stringMatching"
@module("vitest") @scope("expect") external expectCloseTo: float => unknown = "closeTo"
@module("vitest") @scope("expect") external expectCloseToPrecise: (float, int) => unknown = "closeTo"

@send external toBe: (assertion<'a, sync>, 'a) => unit = "toBe"
@send external toBeAsync: (assertion<'a, async>, 'a) => promise<unit> = "toBe"
@send external toEqual: (assertion<'a, sync>, 'a) => unit = "toEqual"
@send external toEqualAsync: (assertion<'a, async>, 'a) => promise<unit> = "toEqual"
@send external toEqualUnknown: (assertion<'a, sync>, unknown) => unit = "toEqual"
@send external toStrictEqual: (assertion<'a, sync>, 'a) => unit = "toStrictEqual"
@send external toMatchString: (assertion<string, sync>, string) => unit = "toMatch"
@send external toMatchRegex: (assertion<string, sync>, RegExp.t) => unit = "toMatch"
@send external toMatchObject: (assertion<'a, sync>, 'b) => unit = "toMatchObject"
@send external toContain: (assertion<array<'a>, sync>, 'a) => unit = "toContain"
@send external toContainEqual: (assertion<array<'a>, sync>, 'a) => unit = "toContainEqual"
@send external toBeTruthy: assertion<'a, sync> => unit = "toBeTruthy"
@send external toBeFalsy: assertion<'a, sync> => unit = "toBeFalsy"
@send external toBeGreaterThan: (assertion<'a, sync>, 'a) => unit = "toBeGreaterThan"
@send external toBeGreaterThanOrEqual: (assertion<'a, sync>, 'a) => unit = "toBeGreaterThanOrEqual"
@send external toBeLessThan: (assertion<'a, sync>, 'a) => unit = "toBeLessThan"
@send external toBeLessThanOrEqual: (assertion<'a, sync>, 'a) => unit = "toBeLessThanOrEqual"
@send external toBeNaN: assertion<'a, sync> => unit = "toBeNaN"
@send external toBeUndefined: assertion<'a, sync> => unit = "toBeUndefined"
@send external toBeNull: assertion<'a, sync> => unit = "toBeNull"
@send external toBeNullable: assertion<'a, sync> => unit = "toBeNullable"
@send external toBeDefined: assertion<'a, sync> => unit = "toBeDefined"
@send external toBeInstanceOf: (assertion<'a, sync>, 'b) => unit = "toBeInstanceOf"
@send external toHaveLength: (assertion<'a, sync>, int) => unit = "toHaveLength"
@send external toHaveProperty: (assertion<'a, sync>, string) => unit = "toHaveProperty"
@send external toHavePropertyWith: (assertion<'a, sync>, string, 'b) => unit = "toHaveProperty"
@send external toBeCloseTo: (assertion<float, sync>, float) => unit = "toBeCloseTo"
@send external toBeCloseToWithDigits: (assertion<float, sync>, float, int) => unit = "toBeCloseTo"
@send external toThrow: assertion<unit => 'r, sync> => unit = "toThrow"
@send external toThrowWith: (assertion<unit => 'r, sync>, 'b) => unit = "toThrow"
@send external toThrowWithAsync: (assertion<'a, async>, 'b) => promise<unit> = "toThrow"
@send external toMatchSnapshot: assertion<'a, sync> => unit = "toMatchSnapshot"
@send external toBeTypeOf: (assertion<'a, sync>, [#bigint | #boolean | #function | #number | #object | #string | #symbol | #undefined]) => unit = "toBeTypeOf"
@send external toSatisfy: (assertion<'a, sync>, 'a => bool) => unit = "toSatisfy"
@send external toBeOneOf: (assertion<'a, sync>, array<'a>) => unit = "toBeOneOf"

@send external toHaveBeenCalled: assertion<Vi.mock<'fn>, sync> => unit = "toHaveBeenCalled"
@send external toHaveBeenCalledTimes: (assertion<Vi.mock<'fn>, sync>, int) => unit = "toHaveBeenCalledTimes"
@send external toHaveBeenCalledWith: (assertion<Vi.mock<'a => 'b>, sync>, 'a) => unit = "toHaveBeenCalledWith"
@send external toHaveBeenCalledWith2: (assertion<Vi.mock<('a, 'b) => 'c>, sync>, 'a, 'b) => unit = "toHaveBeenCalledWith"
@send external toHaveBeenNthCalledWith: (assertion<Vi.mock<'a => 'b>, sync>, int, 'a) => unit = "toHaveBeenNthCalledWith"
@send external toHaveBeenLastCalledWith: (assertion<Vi.mock<'a => 'b>, sync>, 'a) => unit = "toHaveBeenLastCalledWith"
@send external toHaveReturned: assertion<Vi.mock<'fn>, sync> => unit = "toHaveReturned"
@send external toHaveReturnedTimes: (assertion<Vi.mock<'fn>, sync>, int) => unit = "toHaveReturnedTimes"
@send external toHaveReturnedWith: (assertion<Vi.mock<'args => 'b>, sync>, 'b) => unit = "toHaveReturnedWith"
@send external toHaveNthReturnedWith: (assertion<Vi.mock<'args => 'b>, sync>, int, 'b) => unit = "toHaveNthReturnedWith"
@send external toHaveLastReturnedWith: (assertion<Vi.mock<'args => 'b>, sync>, 'b) => unit = "toHaveLastReturnedWith"
@send external toHaveBeenCalledOnce: assertion<Vi.mock<'fn>, sync> => unit = "toHaveBeenCalledOnce"
@send external toHaveBeenCalledBefore: (assertion<Vi.mock<'f>, sync>, Vi.mock<'g>) => unit = "toHaveBeenCalledBefore"
@send external toHaveBeenCalledAfter: (assertion<Vi.mock<'f>, sync>, Vi.mock<'g>) => unit = "toHaveBeenCalledAfter"
@send external toHaveResolved: assertion<Vi.mock<'fn>, sync> => promise<unit> = "toHaveResolved"
@send external toHaveResolvedWith: (assertion<Vi.mock<'args => promise<'b>>, sync>, 'b) => promise<unit> = "toHaveResolvedWith"
@send external toHaveResolvedTimes: (assertion<Vi.mock<'fn>, sync>, int) => promise<unit> = "toHaveResolvedTimes"
@send external toHaveLastResolvedWith: (assertion<Vi.mock<'args => promise<'b>>, sync>, 'b) => promise<unit> = "toHaveLastResolvedWith"
@send external toHaveNthResolvedWith: (assertion<Vi.mock<'args => promise<'b>>, sync>, int, 'b) => promise<unit> = "toHaveNthResolvedWith"

module Assert: {
  @module("vitest") @scope("assert") external ok: 'a => unit = "ok"
  @module("vitest") @scope("assert") external equal: ('a, 'b) => unit = "equal"
  @module("vitest") @scope("assert") external strictEqual: ('a, 'b) => unit = "strictEqual"
  @module("vitest") @scope("assert") external deepEqual: ('a, 'b) => unit = "deepEqual"
  @module("vitest") @scope("assert") external isTrue: 'a => unit = "isTrue"
  @module("vitest") @scope("assert") external isFalse: 'a => unit = "isFalse"
  @module("vitest") @scope("assert") external isNull: 'a => unit = "isNull"
  @module("vitest") @scope("assert") external isUndefined: 'a => unit = "isUndefined"
  @module("vitest") @scope("assert") external throws: (unit => 'a) => unit = "throws"
}
