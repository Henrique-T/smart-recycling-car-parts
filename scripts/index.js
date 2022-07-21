async function main() {

    /** Display available accounts */
    const accounts = await ethers.provider.listAccounts();
    console.log("***accounts****")
    console.log(accounts);

    /**
     *  Access instance of smart contract
     *  The necessary address is gotten after running npm run deploy:local 
     */
    const address = '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512';
    const OwnerToCompany = await ethers.getContractFactory('OwnerToCompany');
    const ownerToCompany = await OwnerToCompany.attach(address);

    /** Acces name of deployed contract */
    const value = await ownerToCompany.getName();
    console.log('ownerToCompany value is', value.toString());

    /** Declare needed structures to add a sale */
    type_of_sale = 'NORMAL';
    let now = new Date();

    const date = {
        day: date.getDate().toString(), 
        month: date.getMonth().toString(), 
        year: date.getFullYear().toString(), 
        hour: date.getHours().toString(), 
        minute: date.GetMinutes().toString()
    }

    const ownerAddress = {
        street: 'defaultStreet',
        number: 'defaultNumber',
        addr_details: 'defaultDetails',
        zip_code: 'defailtZipCode',
        city: 'defaultCity',
        state: 'defaultState'
    };

    const owner_info = {
        name: 'defaultOwnerName',
        address: ownerAddress,
        id: '00000000000'
    }

    const carPartDescription = {
        model: 'defaultModel',
        color: 'defaultColor',
        date
    }

    const carPart_info = {
        uid: 'id_x1',
        name: 'defaultCarPartName',
        description: carPartDescription
    }

    /**
     * Call the main function to add a Sale to the blockchain
     */
    const addedSale = await ownerToCompany.addSale(
        type_of_sale,
        date,
        owner_info,
        carPart_info,
        price=200
    );

    console.log('sale added is', addedSale);
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
  });