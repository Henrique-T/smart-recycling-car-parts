// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract OwnerToCompany  {
    struct ownerInfo {
        string name;
        address owner_address;
        string id; // cpf
    }

    struct companyInfo {
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

    struct carPartDescription {
        string model;
        string color;
        Date creation;
    }

    struct carPartInfo {
        string uid; // car part uid (provided by initial car company)
        string name;
        carPartDescription description;
    }

    string[3] typesOfSale = ["NORMAL", "TRADE", "GIFT"];

    struct sale {
        string type_of_sale;
        Date date;
        ownerInfo owner_info;
        companyInfo company_info;
        carPartInfo carPart_info;
        uint128 price;
    }
}