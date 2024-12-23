// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract VotingBeacon is OwnableUpgradeable, UUPSUpgradeable {
    address private _implementation;

    // Event to log implementation changes
    event ImplementationChanged(address indexed newImplementation);

    // Initialize the contract with the first implementation address
    function initialize(address initialImplementation) public initializer {
        __Ownable_init();
        __UUPSUpgradeable_init();
        _implementation = initialImplementation;
        emit ImplementationChanged(initialImplementation);
    }

    // Returns the current implementation address
    function implementation() public view returns (address) {
        return _implementation;
    }

    // Set the new implementation address, only callable by the owner
    function setImplementation(address newImplementation) public onlyOwner {
        require(newImplementation != address(0), "New implementation can't be zero address");
        _implementation = newImplementation;
        emit ImplementationChanged(newImplementation);
    }

    // Authorization function for upgrades
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {
        require(newImplementation != address(0), "New implementation can't be zero address");
        _implementation = newImplementation;
        emit ImplementationChanged(newImplementation);
    }
}
