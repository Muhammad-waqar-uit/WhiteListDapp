//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract whitelist{
    //address owner
    address owneraddress;
    //max number of whitelisted address allowed
    uint8 public maxWhitelistedAddresses;

    //mapping for address if allowed or not like true if allowed false if not.abi
    mapping (address=>bool) public whitelistedAddresses;

    //number address whitelist that would need to keep track of how many address have comed in
    uint8 public numAddressesWhitelisted;


    constructor(uint8 _maxwhitelistedAddress){
        maxWhitelistedAddresses=_maxwhitelistedAddress;
        owneraddress=msg.sender;
    }

    function updatemaxwhitelist(uint8 _number)public{
        require(msg.sender==owneraddress);
        maxWhitelistedAddresses=_number;
    }
    /**
        addAddressToWhitelist - This function adds the address of the sender to the
        whitelist
     */
    function addAddressToWhitelist() public {
        // check if the user has already been whitelisted
        require(!whitelistedAddresses[msg.sender], "Sender has already been whitelisted");
        // check if the numAddressesWhitelisted < maxWhitelistedAddresses, if not then throw an error.
        require(numAddressesWhitelisted < maxWhitelistedAddresses, "More addresses cant be added, limit reached");
        // Add the address which called the function to the whitelistedAddress array
        whitelistedAddresses[msg.sender] = true;
        // Increase the number of whitelisted addresses
        numAddressesWhitelisted += 1;
    }


}