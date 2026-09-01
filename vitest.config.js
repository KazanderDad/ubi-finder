import { defineConfig } from "vitest/config";
import path from "node:path";
import { fileURLToPath } from "node:url";

const rootDirectory = path.dirname(fileURLToPath(import.meta.url));

export default defineConfig({
  resolve: {
    alias: {
      "@": path.resolve(rootDirectory, "src"),
    },
  },
  test: {
    environment: "node",
    include: ["tests/unit/**/*.test.js"],
    clearMocks: true,
    restoreMocks: true,
    coverage: {
      provider: "v8",
      reporter: ["text", "json-summary", "html"],
      reportsDirectory: "coverage",
      include: [
        "src/lib/matchingEngine.js",
        "src/lib/matchDeltaService.js",
        "src/lib/programStatus.js",
        "src/lib/utils.js",
      ],
      exclude: ["tests/**"],
      thresholds: {
        statements: 80,
        branches: 80,
        functions: 80,
        lines: 80,
      },
    },
  },
});
