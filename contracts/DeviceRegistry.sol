// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DeviceRegistry {
    struct Device {
        bytes32 pkHash;
        string  role;
        bool    registered;
        uint256 registeredAt;
    }

    address public admin;
    mapping(string => Device) public devices;
    event DeviceRegistered(string deviceId, string role, bytes32 pkHash);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    constructor() { admin = msg.sender; }

    function registerDevice(
        string calldata deviceId,
        string calldata role,
        bytes32 pkHash
    ) external onlyAdmin {
        require(!devices[deviceId].registered, "Already registered");
        devices[deviceId] = Device(pkHash, role, true, block.timestamp);
        emit DeviceRegistered(deviceId, role, pkHash);
    }

    function getDevice(string calldata deviceId)
        external view returns (bytes32, string memory, bool, uint256)
    {
        Device memory d = devices[deviceId];
        return (d.pkHash, d.role, d.registered, d.registeredAt);
    }
}