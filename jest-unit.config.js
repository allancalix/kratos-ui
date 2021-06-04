module.exports = {
  testEnvironment: "jsdom",
  testMatch: [
    "**/__tests__/**/*.js?(x)",
  ],
  verbose: true,
  transformIgnorePatterns: [
    "/node_modules/(?!@glennsl/bs-jest|bs-platform).+\\.js$"
  ],
}
