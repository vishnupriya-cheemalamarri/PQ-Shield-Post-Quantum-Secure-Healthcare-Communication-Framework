// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AuditLog {
    struct LogEntry {
        string  senderId;
        string  receiverId;
        bytes32 messageHash;
        bytes32 ipfsCID;
        uint256 sigSize;
        bool    accessGranted;
        uint256 timestamp;
    }

    LogEntry[] public entries;
    event LogAdded(uint256 indexed index, string sender, string receiver, bool granted);

    function addLog(
        string  calldata senderId,
        string  calldata receiverId,
        bytes32          messageHash,
        bytes32          ipfsCID,
        uint256          sigSize,
        bool             accessGranted
    ) external {
        entries.push(LogEntry(
            senderId, receiverId,
            messageHash, ipfsCID, sigSize,
            accessGranted, block.timestamp
        ));
        emit LogAdded(entries.length - 1, senderId, receiverId, accessGranted);
    }

    function getLog(uint256 i) external view returns (LogEntry memory) {
        return entries[i];
    }

    function totalLogs() external view returns (uint256) {
        return entries.length;
    }
}