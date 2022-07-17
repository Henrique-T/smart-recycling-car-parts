// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract OwnerToCompany  {
    struct OwnerInfo {
        string name;
        address owner_address;
        string id; // cpf
    }

    struct CompanyInfo {
        string name;
        address company_address;
        string id; // cnpj
    }

    struct Date {
        uint8 day;
        uint8 month;
        uint16 year;

        uint8 hour;
        uint8 minute;
    }

    struct CarPartDescription {
        string model;
        string color;
        Date creation;
    }

    struct CarPartInfo {
        string uid; // car part uid (provided by initial car company)
        string name;
        CarPartDescription description;
    }

    string[3] typesOfSale = ["NORMAL", "TRADE", "GIFT"];

    struct Sale {
        string type_of_sale;
        Date date;
        OwnerInfo owner_info;
        CompanyInfo company_info;
        CarPartInfo carPart_info;
        uint128 price;
    }

    mapping(uint => Sale) sales;
    mapping(uint => OwnerInfo) owners;
    mapping(uint => CompanyInfo) companies;
    mapping(uint => Date) dates;

    uint salesCount = 0;

    function setOwnerInfo(        
        string memory _name, 
        address _address, 
        string memory _id
    ) public {
        OwnerInfo storage owner = owners[salesCount];
        owner.id = _id;
        owner.name = _name;
        owner.owner_address = _address;
    }

    function setCompanyInfo(        
        string memory _name, 
        address _address, 
        string memory _id
    ) public {
        CompanyInfo storage company = companies[salesCount];
        company.id = _id;
        company.name = _name;
        company.company_address = _address;
    }

    function setDate(uint8 day, uint8 month, uint16 year, uint8 hour, uint8 minute) public {
        Date storage date = dates[salesCount];
        date.day = day;
        date.month = month;
        date.year = year;
        date.hour = hour;
        date.minute = minute;
    }

    function addSale
    (
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