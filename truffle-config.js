module.exports = {
  networks: {
    development: {
      gas: "6721975",
      gasPrice: "0",
      host: "localhost",
      port: 7545,
      network_id: "5777",
    },
    test: {
      gas: "6721975",
      gasPrice: "0",
      host: "localhost",
      port: 8555,
      network_id: "5777",
    }
  },
  compilers: {
    solc: {
      version: "0.8.14",      // Fetch exact version from solc-bin (default: truffle's version)
    }
  },
};
