// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract Whitelist is Ownable {

    uint8 public constant WHITELIST_SIZE = 20;

    address[] private whitelistAddresses;
    mapping(address => bool) public isWhitelisted;

    // init the Ownable constructor when we init ours 
    // Only the owner is able to write data in the contract
    constructor() Ownable() {

    }

    function addAddressList(address[] memory _addresses) public onlyOwner {
        require(_addresses.length <= WHITELIST_SIZE - whitelistAddresses.length, "The whitelist is full or the amount of addresses is too big!");
        for (uint8 i = 0; i < _addresses.length; i++) {
            require(isWhitelisted[_addresses[i]] == false, "The addresss is already included in the whitelist");
            whitelistAddresses.push(_addresses[i]);
            isWhitelisted[_addresses[i]] = true;
        }
    }

    function addAddress(address _user) public onlyOwner {
        require(whitelistAddresses.length <= WHITELIST_SIZE, "The whitelist is full");
            require(isWhitelisted[_user] == false, "The addresss is already included in the whitelist");
            whitelistAddresses.push(_user);
            isWhitelisted[_user] = true;
    }

    function clearWhitelist() public onlyOwner {
        for (uint8 i = 0; i < whitelistAddresses.length; i++) {
            isWhitelisted[whitelistAddresses[i]] = false;
        }
        delete whitelistAddresses;
    }

    function whitelistedAddresses() public view onlyOwner returns (address[] memory) {
        return whitelistAddresses;
    }

    function addressesAmount() public view onlyOwner returns (uint256) {
        return whitelistAddresses.length;
    }

    function transferOwnership(address newOwner) public override {
        require(isWhitelisted[newOwner] == false, "The new owner can not be included in the whitelist!");
        transferOwnership(newOwner);
    }
}