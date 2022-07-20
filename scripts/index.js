async function main() {
    const accounts = await ethers.provider.listAccounts();
    console.log("***accounts****")
    console.log(accounts);

    const address = '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512';
    const OwnerToCompany = await ethers.getContractFactory('OwnerToCompany');
    const ownerToCompany = await OwnerToCompany.attach(address);

    const value = await ownerToCompany.getName();
    console.log('ownerToCompany value is', value.toString());
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
  });