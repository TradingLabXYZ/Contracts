const HDWalletProvider = require('@truffle/hdwallet-provider');
const privateKeyDev = '99B3C12287537E38C90A9219D4CB074A89A16E9CDB20BF85728EBD97C343E342';
const networkUrlDev = 'http://localhost:9933/';
const networkIdDev = 1281;
const privateKeyMoonbase = 'REAL PRIVATE KEY';
const networkUrlMoonbase = 'REAL NETWORK URL';
const networkIdMoonbase = 1287;

module.exports = {
  networks: {
    dev: {
      provider: () => {
        return new HDWalletProvider(
           privateKeyDev,
           networkUrlDev
        );
      },
      network_id: networkIdDev,
    },
    moonbase: {
      provider: () => {
        return new HDWalletProvider(
          privateKeyMoonbase,
          networkUrlMoonbase
        );
      },
      network_id: networkIdMoonbase,
    },
  },
  compilers: {
    solc: {
      version: '^0.8.7',
    },
  },
  plugins: [
    'moonbeam-truffle-plugin',
    '@chainsafe/truffle-plugin-abigen',
    'truffle-plugin-verify'
  ],
};
