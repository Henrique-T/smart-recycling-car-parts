// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract OwnerToCompany  {

    /**
     * OwnerInfo structure
     * Stores information about the owner (seller) of the car part being sold. 
     */
    struct OwnerInfo {
        string name;
        address owner_address;
        string id; // cpf
    }

    /**
     * CompanyInfo structure
     * Stores information about the company (buyer) buying the car part.
     */
    struct CompanyInfo {
        string name;
        address company_address;
        string id; // cnpj
    }

    /**
     * Date structure
     * Date format.
     */
    struct Date {
        uint8 day;
        uint8 month;
        uint16 year;

        uint8 hour;
        uint8 minute;
    }

    /**
     * CarPartDescription structure
     * Stores the description for the car part.
     */
    struct CarPartDescription {
        string model;
        string color;
        Date creation;
    }

    /**
     * CarPartInfo structure
     * Stores information about the car part.
     * The uid property holds a unique number to uniquely identify each car part. This unique number is set by the car part creator.
     */
    struct CarPartInfo {
        string uid; // car part uid (provided by initial car company)
        string name;
        CarPartDescription description;
    }

    /**
     * typesOfSale array
     * Stores the three possible sale types.
     * NORMAL: seller sets prices and company buys it.
     * TRADE: seller and buyer trading products (ignored by the current implementation).
     * GIFT: seller sets price to zero.
     */
    string[3] typesOfSale = ["NORMAL", "TRADE", "GIFT"];

    /**
     * Sale structure
     * Stores information about the sale.
     * Main structure.
     */
    struct Sale {
        string type_of_sale;
        Date date;
        OwnerInfo owner_info;
        CompanyInfo company_info;
        CarPartInfo carPart_info;
        uint128 price;
    }

    /* Mapping properties */
    mapping(uint => Sale) sales;
    mapping(uint => OwnerInfo) owners;
    mapping(uint => CompanyInfo) companies;
    mapping(uint => Date) dates;

    /* Sales counter. Incremented for each added sale. */
    uint salesCount = 0;

    /**
     * setOwnerInfo function
     * Setter for owner information.
     */
    function setOwnerInfo(string memory _name, address _address, string memory _id) public 
    {
        OwnerInfo storage owner = owners[salesCount];
        owner.id = _id;
        owner.name = _name;
        owner.owner_address = _address;
    }

    /**
     * setCompanyInfo function
     * Setter for company information.
     */
    function setCompanyInfo(string memory _name, address _address, string memory _id) public 
    {
        CompanyInfo storage company = companies[salesCount];
        company.id = _id;
        company.name = _name;
        company.company_address = _address;
    }

    /**
     * setDate function
     * Setter for date information.
     */
    function setDate(uint8 day, uint8 month, uint16 year, uint8 hour, uint8 minute) public 
    {
        Date storage date = dates[salesCount];
        date.day = day;
        date.month = month;
        date.year = year;
        date.hour = hour;
        date.minute = minute;
    }

    /**
     * addSale function
     * Adds a Sale to the blockchain.
     * Assisted by the salesCount variable as index.
     * Returns the inserted Sale index. 
     */
    function addSale (
        string memory type_of_sale,
        Date memory date,
        address payable owner_info,
        CarPartInfo memory carPart_info,
        uint128 price
    ) 
    public 
    payable 
    returns (bool, string memory, int) 
    {
        if (msg.value != price) {
            owner_info.transfer(msg.value);
            return (false, "Informed price does not correspond to sent in the message", -1);
        }

        Sale storage sale = sales[salesCount];
        sale.type_of_sale = type_of_sale;
        sale.date = date;
        sale.owner_info = owners[salesCount];
        sale.company_info = companies[salesCount];
        sale.carPart_info = carPart_info;
        sale.price = price;

        salesCount++;

        return (true, "Success!", int(salesCount - 1));
    }

}