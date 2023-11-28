// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import "./DegenToken.sol";

contract ItemManager {
    struct Item {
        string name;
        address owner;
        uint256 price;
        bool forSale;
        address seller;
    }

    mapping(uint256 => Item) public items;
    uint256 public itemCount;

    event ItemCreated(uint256 indexed itemId, string itemName, address owner, uint256 price);
    event ItemTransferred(uint256 indexed itemId, address oldOwner, address newOwner);
    event ItemPutForSale(uint256 indexed itemId, address seller, uint256 price);
    event ItemBought(uint256 indexed itemId, address buyer, uint256 price);
    event ItemPriceChanged(uint256 indexed itemId, uint256 newPrice);

    function createItem(string memory _name) external {
        itemCount++;
        items[itemCount] = Item(_name, msg.sender, 0, false, address(0));
        emit ItemCreated(itemCount, _name, msg.sender, 0);
    }

    function transferItem(uint256 _itemId, address _newOwner) external {
        Item storage item = items[_itemId];
        require(item.owner == msg.sender, "You do not own this item");
        
        item.owner = _newOwner;
        item.forSale = false; // Ownership transfer automatically removes the item from sale
        item.seller = address(0); // Clear seller info
        emit ItemTransferred(_itemId, msg.sender, _newOwner);
    }

    function getItemOwner(uint256 _itemId) external view returns (address) {
        return items[_itemId].owner;
    }

    function getItemPrice(uint256 _itemId) external view returns (uint256) {
        return items[_itemId].price;
    }

    function getItemForSale(uint256 _itemId) external view returns (bool) {
        return items[_itemId].forSale;
    }

    function getItemSeller(uint256 _itemId) external view returns (address) {
        return items[_itemId].seller;
    }

    function putItemForSale(uint256 _itemId, uint256 _price) external {
        Item storage item = items[_itemId];
        require(item.owner == msg.sender, "You do not own this item");
        
        item.forSale = true;
        item.seller = msg.sender;
        item.price = _price;
        emit ItemPutForSale(_itemId, msg.sender, _price);
    }

    function changeItemPrice(uint256 _itemId, uint256 _newPrice) external {
        Item storage item = items[_itemId];
        require(item.owner == msg.sender, "You do not own this item");
        
        item.price = _newPrice;
        emit ItemPriceChanged(_itemId, _newPrice);
    }
    
    function markItemAsSold(uint256 _itemId, address _newOwner) external {
        Item storage item = items[_itemId];
                                        //oldOwner, newOwner
        emit ItemTransferred(_itemId, item.seller, _newOwner);
        item.owner = _newOwner;
        item.forSale = false; // Ownership transfer automatically removes the item from sale
        item.seller = address(0); // Clear seller info
    }

}
