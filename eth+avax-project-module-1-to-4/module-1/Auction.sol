// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Auction {
    address public owner;
    address public highestBidder;
    uint256 public highestBid;
    uint256 public auctionEndTime;
    bool public auctionEnded;
    uint256 public itemId;
    uint256 public previousHighestBid;

    mapping(address => string) public itemOwners;
    mapping(address => uint256) public currentBid;
    mapping(address => bool) public isItemOwner;
    mapping(address => uint256) public userBalances;

    event PreviousBidAmount(uint256 previousBid);
    event RefundStatus(bool success);
    event ItemTransferred(address newOwner);

    constructor(uint256 _duration, string memory _item, uint256 _itemId) {
        owner = msg.sender;
        itemOwners[owner] = _item;
        isItemOwner[owner] = true;
        itemId = _itemId;
        auctionEndTime = block.timestamp + _duration;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the item can finalize the bidding");
        _;
    }

    modifier auctionNotEnded() {
        require(!auctionEnded, "Auction already ended");
        _;
    }

    modifier notItemOwner() {
        require(!isItemOwner[msg.sender], "Item owner cannot bid on their own item");
        _;
    }

    modifier hasBalance(){
        require(msg.sender.balance > 0 , "Account has insufficient balance");
        _;
    }

    function getUserBalance(address _user) external view returns (uint256) {
        return userBalances[_user];
    }

    function updateUserBalance(address _user, uint256 _balance) internal {
        userBalances[_user] = _balance;
    }

    function placeBid(uint256 _bid) external payable auctionNotEnded notItemOwner {
        require(_bid > highestBid, "Bid must be higher than current highest bid");
        address previousHighestBidder = highestBidder;
        uint256 previousHighestBidAmount = highestBid;

        if (msg.sender.balance <= _bid) {
            revert("Insufficient balance to place the bid");
        }

        if (previousHighestBidder != address(0)) {
            updateUserBalance(previousHighestBidder, userBalances[previousHighestBidder] + previousHighestBidAmount);
            emit RefundStatus(true);
        }


        previousHighestBid = highestBid;
        highestBidder = msg.sender;
        highestBid = _bid;
        updateUserBalance(msg.sender, msg.sender.balance - _bid);
        currentBid[msg.sender] = _bid;

        emit PreviousBidAmount(previousHighestBid);
    }

    function finalizeAuction() external onlyOwner {
        require(block.timestamp >= auctionEndTime, "Auction end time not reached");
        require(!auctionEnded, "Auction already ended");
        auctionEnded = true;
        require(highestBidder != address(0), "No bids placed");

        transferItemToWinner();
    }

    function transferItemToWinner() internal {
        require(itemId != 0, "No item to transfer");
        require(isItemOwner[highestBidder] == false, "Bidder already owns an item");

        isItemOwner[highestBidder] = true;
        isItemOwner[owner] = false;
        itemOwners[highestBidder] = itemOwners[owner];
        delete itemOwners[owner];

        emit ItemTransferred(highestBidder);
    }
}