// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract Voting is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    string public electionName;
    mapping(address => bool) public voters;  // Correct the mapping to use address as the key
    
    // Initialize function
    function initialize(string memory _electionName) public initializer {
        __Ownable_init();
        electionName = _electionName;
    }

    // Function to Vote
    function vote() external {
        require(!voters[msg.sender], "You have already voted");
        voters[msg.sender] = true;
    }

    // Function to get Voter details
    function getVoterDetails(address voter) external view returns(bool voterStatus) {
        voterStatus = voters[voter];
    }

    // Authorization function to authorize upgrades
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
