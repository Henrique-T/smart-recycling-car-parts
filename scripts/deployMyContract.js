async function main() {
    const MyContract = await ethers.getContractFactory("MyContract");
    const myContract = await MyContract.deploy("My Contract");

    const OwnerToCompany = await ethers.getContractFactory("OwnerToCompany");
    const ownerToCompany = await OwnerToCompany.deploy("owner to company");

    console.log("My Contract deployed to address:", myContract.address);
    console.log("Owner-to-company deployed to address:", ownerToCompany.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
  });