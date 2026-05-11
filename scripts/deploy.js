const { ethers } = require("hardhat");
const { writeFileSync } = require("fs");

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying with:", deployer.address);

    const Registry = await ethers.deployContract("DeviceRegistry");
    await Registry.waitForDeployment();
    console.log("DeviceRegistry:", await Registry.getAddress());

    const Access = await ethers.deployContract("AccessControl", [
        await Registry.getAddress()
    ]);
    await Access.waitForDeployment();
    console.log("AccessControl:", await Access.getAddress());

    const Audit = await ethers.deployContract("AuditLog");
    await Audit.waitForDeployment();
    console.log("AuditLog:", await Audit.getAddress());

    writeFileSync("contract_addresses.json", JSON.stringify({
        registry: await Registry.getAddress(),
        accessControl: await Access.getAddress(),
        auditLog: await Audit.getAddress()
    }, null, 2));

    console.log("Addresses saved to contract_addresses.json ✅");
}

main().catch(console.error);