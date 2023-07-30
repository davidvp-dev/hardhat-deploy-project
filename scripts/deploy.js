const hre = require("hardhat");
const verify = require("@nomiclabs/hardhat-etherscan");

async function main() {

  const Whitelist = await hre.ethers.getContractFactory("Whitelist");
  const contract = await Whitelist.deploy();

  await contract.deployed();

  console.log('Contract deployed at: ', contract.address);

}

// Call the main function and catch if there is any error
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});