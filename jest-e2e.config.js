module.exports = {
  testMatch: [
    "**/e2e/*.test.js?(x)",
  ],
  setupFileAfterEnv: ['./jest.setup.js'],
  preset: 'jest-playwright-preset',
}
