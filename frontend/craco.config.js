module.exports = {
    webpack: {
      configure: {
        resolve: {
          fallback: {
            stream: require.resolve('stream-browserify'),
            process: require.resolve('process/browser'),
            crypto: false
          }
        }
      }
    }
  }