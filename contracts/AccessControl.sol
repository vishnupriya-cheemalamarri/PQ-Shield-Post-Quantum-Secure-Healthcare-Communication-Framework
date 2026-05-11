// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./DeviceRegistry.sol";

contract AccessControl {
    DeviceRegistry public registry;
    event AccessGranted(string sender, string receiver, uint256 timestamp);
    event AccessDenied(string sender, string receiver, string reason);

    constructor(address registryAddr) {
        registry = DeviceRegistry(registryAddr);
    }

    function checkAccess(
        string calldata senderId,
        string calldata receiverId
    ) external returns (bool) {
        (, string memory sRole, bool sReg,) = registry.getDevice(senderId);
        (, string memory rRole, bool rReg,) = registry.getDevice(receiverId);

        if (!sReg || !rReg) {
            emit AccessDenied(senderId, receiverId, "Device not registered");
            return false;
        }

        bool allowed = _policyCheck(sRole, rRole);
        if (allowed) emit AccessGranted(senderId, receiverId, block.timestamp);
        else emit AccessDenied(senderId, receiverId, "Role not authorized");
        return allowed;
    }

    function _policyCheck(
        string memory sRole,
        string memory rRole
    ) internal pure returns (bool) {
        bytes32 s = keccak256(bytes(sRole));
        bytes32 r = keccak256(bytes(rRole));
        bytes32 ADMIN  = keccak256("admin");
        bytes32 DOCTOR = keccak256("doctor");
        bytes32 NURSE  = keccak256("nurse");

        if (s == ADMIN) return true;
        if (s == DOCTOR) return (r == DOCTOR || r == NURSE);
        return (s == r);
    }
}