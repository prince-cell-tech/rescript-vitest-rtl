import { defineConfig } from "vitest/config";
import react from "@vitejs/plugin-react";

const rescriptOutputSuffix = ".res.mjs";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react({
      include: [`**/*${rescriptOutputSuffix}`],
    }),
  ],
  server: {
    watch: {
      // Wait for ReScript's generated JS output before Vite sends HMR updates.
      ignored: ["**/*.res", "**/*.resi", "**/lib/**"],
    },
  },
  test: {
    include: ["src/**/*_test.res.mjs"],
    environment: "jsdom",
    setupFiles: ["./vitest.setup.js"],
  },
});
