module.exports = {
  testEnvironment: 'node',
  testMatch: ['<rootDir>/tests/**/*.test.js'],
  collectCoverageFrom: ['models/**/*.js', 'routes/**/*.js', 'config/**/*.js', 'server.js'],
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'html', 'lcov', 'json-summary'],
  clearMocks: true,
  restoreMocks: true,
  verbose: true
};
