require('@nomicfoundation/hardhat-ethers');
require('@openzeppelin/hardhat-upgrades');
require('@nomicfoundation/hardhat-verify'); 
require('dotenv').config();
const{_RPC_URL_,_PRIVATE_KEY_,_ETHERSCAN_API_KEY_} = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.27",
  networks:{
    holesky:{
      url: _RPC_URL_,
      accounts: [`0x${_PRIVATE_KEY_}`],
    },
  },
  sourcify:{
    enabled: true
  },
  etherscan:{
    apiKey:{
      holesky: _ETHERSCAN_API_KEY_
    },
  }
};
