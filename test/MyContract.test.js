const { expect } = require("chai");

describe("MyContract", () => {

  it("should return its name", async () => {
    console.log("contract 1*");
    const MyContract = await ethers.getContractFactory("MyContract");
    const myContract = await MyContract.deploy("My Contract");

    await myContract.deployed();
    expect(await myContract.getName()).to.equal("My Contract");
  });

  it("should change its name when requested", async () => {
    console.log("contract 1**");
    const MyContract = await ethers.getContractFactory("MyContract");
    const myContract = await MyContract.deploy("My Contract");

    await myContract.changeName("Another Contract");
    expect(await myContract.getName()).to.equal("Another Contract");
  });
});

describe("OwnerToCompany", () => {

  it("should return its name", async () => {
    console.log("contract 2*");
    const MyContract = await ethers.getContractFactory("OwnerToCompany");
    const myContract = await MyContract.deploy("owner to company");

    await myContract.deployed();
    expect(await myContract.getName()).to.equal("owner to company");
  });

  it("should change its name when requested", async () => {
    console.log("contract 2**");
    const MyContract = await ethers.getContractFactory("OwnerToCompany");
    const myContract = await MyContract.deploy("owner to company");

    await myContract.changeName("new owner to company");
    expect(await myContract.getName()).to.equal("new owner to company");
  });
});