module.exports = {
  testMatch: [
    "**/e2e/*.test.js?(x)",
  ],
  setupFilesAfterEnv: ['./jest.setup.js'],
  preset: 'jest-playwright-preset',
}
