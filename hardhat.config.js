/* This import is required to use the Ethers functions in deploy.js */
require("@nomiclabs/hardhat-waffle");

/* This import is required to use npx hardhat verify and verify the address */
require("@nomiclabs/hardhat-etherscan");

const Private_Key = "6fae52efde6e93d354bc915b010738a9db9afc115b569d5d63c44d3d4573a51e"
const Quicknode_URL = "https://snowy-thrilling-glade.ethereum-sepolia.discover.quiknode.pro/e477152fa18bd551832264c0cb5411cfda3e63df/"
const ETHERSCAN_API_KEY = "A35WWH5IFHUT573YHMHCHGIJPGMQG7XK6K"

module.exports = {
  solidity: "0.8.0",
  networks: {
    sepolia: {
      url: Quicknode_URL,
      accounts: [`0x${Private_Key}`]
    }
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  }
};