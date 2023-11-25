// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
   address public tokenOwner;

    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
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
   
   function transferTokens(address to, uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance for transfer");
        transfer(to, amount);
   }
}

