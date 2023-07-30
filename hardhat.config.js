require('dotenv').config({ path: ".env" })

/* This import is required to use the Ethers functions in deploy.js */
require("@nomiclabs/hardhat-waffle");
/* This import is required to use npx hardhat verify and verify the address */
require("@nomiclabs/hardhat-etherscan");

const PRIVATE_KEY = process.env.PRIVATE_KEY
const QUICKNODE_HTTP_URL = process.env.QUICKNODE_HTTP_URL
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY

module.exports = {
  solidity: "^0.8.0",
  networks: {
    sepolia: {
      url: QUICKNODE_HTTP_URL,
      accounts: [`0x${PRIVATE_KEY}`]
    }
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  }
};