// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";

/*
    Functionality
    Only contract owner should be able to mint tokens
    Any user can transfer tokens
    Any user can burn tokens
*/
contract JBL is ERC20 {
   address public tokenOwner;

    constructor(uint256 initialSupply) ERC20("JabolCoin", "JBL") {
        _mint(msg.sender, initialSupply);
        tokenOwner = msg.sender;
    }

   function mintTokens(address to, uint256 amount) public {
       require(msg.sender == tokenOwner, "Only the owner of the token can mint tokens");
       _mint(to, amount);
   }

   function burnTokens(uint256 amount) public {
       require(balanceOf(msg.sender) >= amount, "Insufficient balance for burning");
       _burn(msg.sender, amount);
   }

   function checkBalanceOfRecipient(address _recipient) public view returns (uint256) {
        return balanceOf(_recipient); //for easier tracking of balance for recipient
   }
   
   function transferTokens(address to, uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance for transfer");
        transfer(to, amount);
   }
}
