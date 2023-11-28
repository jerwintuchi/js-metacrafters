// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ItemManager.sol";

contract DegenToken is ERC20, Ownable {
    address public itemManagerAddress; // Address of the ItemManager contract
    mapping(address => uint256) public tokenBalances;

    event TokensRedeemed(address indexed redeemer, uint256 amount);
    event TokensBurned(address indexed burner, uint256 amount);

    constructor(address _itemManagerAddress) ERC20("Degen", "DGN") {
        itemManagerAddress = _itemManagerAddress;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
        tokenBalances[to] += amount;
    }

    function setItemManagerAddress(address _itemManagerAddress) external onlyOwner {
        itemManagerAddress = _itemManagerAddress;
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        super.transfer(recipient, amount);
        tokenBalances[msg.sender] -= amount;
        tokenBalances[recipient] += amount;
        return true;
    }
    event DebugLog(string, uint256);

        function redeemForItems(uint256 itemId) public payable {
        // Interact with ItemManager contract for item redeeming/buying items
        ItemManager itemManager = ItemManager(itemManagerAddress);
        uint256 itemPrice = itemManager.getItemPrice(itemId);
        bool isItemForSale = itemManager.getItemForSale(itemId);
        address itemOwner = itemManager.getItemOwner(itemId);
        
        require(msg.sender != itemOwner, "You already own this item.");
        require(isItemForSale, "Item is not for sale");
        require(balanceOf(msg.sender) >= itemPrice, "Insufficient Degen Tokens");

        // Approve the caller of the contract to spend tokens equal to the item price from their balance
        approve(msg.sender, itemPrice);

        // Transfer tokens to the item seller using transferFrom
        transferFrom(msg.sender, itemManager.getItemSeller(itemId), itemPrice);
        // Log item price and sent value for debugging
        emit DebugLog("Item Price", itemPrice);
        emit DebugLog("Sent Value", itemPrice);
        // Call the ItemManager to mark the item as sold
        ItemManager(itemManagerAddress).markItemAsSold(itemId, msg.sender);

        emit TokensRedeemed(msg.sender, itemPrice);
    }


    function checkBalance(address _account) public view returns (uint256) {
        return balanceOf(_account);
    }

    function burn(uint256 amount) public {
        require(tokenBalances[msg.sender] >= amount, "Insufficient token balance");
        tokenBalances[msg.sender] -= amount;
        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount);
    }
}
