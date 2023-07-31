const hre = require("hardhat");

async function main() {

  const EyesNFT = await hre.ethers.getContractFactory("EyesNFT");
  const contract = await EyesNFT.deploy(
    "Eyes of the Departed",
    "EYE",
    "ipfs://Qmd6yr5rFDcMJP1tscp15xzaea7ALEJkJuJLk7h4ax1U4y/"
  );

  await contract.deployed();

  console.log('Contract deployed at: ', contract.address);

}

// Call the main function and catch if there is any error
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});