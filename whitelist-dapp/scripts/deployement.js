const { ethers,artifacts } = require("hardhat");
async function main() {
    const [Deployer]=await ethers.getSigners();
    console.log("Deployer Contract Address:",Deployer.address);
    const contract = await ethers.getContractFactory("whitelist");
    const Contract=await contract.deploy(11);
    console.log("Whitelist contract deployed to:", Contract.address);
    saveFrontendFiles(Contract,"whitelist");
  }

function saveFrontendFiles(contract, name) {
    const fs = require("fs");
    const contractsDir = `${__dirname}/../contractsData`;
  
    if (!fs.existsSync(contractsDir)) {
      fs.mkdirSync(contractsDir);
    }
  
    const addressFilePath = `${contractsDir}/${name}-address.json`;
    const artifactFilePath = `${contractsDir}/${name}.json`;
  
    fs.writeFileSync(
      addressFilePath,
      JSON.stringify({ address: contract.address }, null, 2)
    );
  
    const contractArtifact = artifacts.readArtifactSync(name);
  
    fs.writeFileSync(
      artifactFilePath,
      JSON.stringify(contractArtifact, null, 2)
    );
  }
main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error)
        process.exit(1)
    })