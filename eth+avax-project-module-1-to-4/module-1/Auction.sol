// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Auction {
    address public original_owner;
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
        original_owner = msg.sender;
        itemOwners[original_owner] = _item;
        isItemOwner[original_owner] = true;
        itemId = _itemId;
        auctionEndTime = block.timestamp + _duration;
    }

    modifier onlyOwner() {
        require(msg.sender == original_owner, "Only the owner of the item can finalize the bidding");
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
        assert(_bid > 100); // assume a case where the bid amount must not be less than 100
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

    event NoBidPlaced(string);

    function finalizeAuction() external onlyOwner {
        require(block.timestamp >= auctionEndTime, "Auction end time not reached");
        require(!auctionEnded, "Auction already ended");

        // Check if no bids have been placed and the auction has ended
        if (highestBid == 0) {
            auctionEnded = true;
            emit NoBidPlaced("No bid placed and bidding has expired");
            // or revert with a custom error message
            // revert("No bid placed and bidding has expired");
        } else {
            require(highestBidder != address(0), "No bids placed");
            auctionEnded = true;
            transferItemToWinner();
        }
}

    function transferItemToWinner() internal {
        require(itemId != 0, "No item to transfer");
        require(isItemOwner[highestBidder] == false, "Bidder already owns an item");

        isItemOwner[highestBidder] = true;
        isItemOwner[original_owner] = false;
        itemOwners[highestBidder] = itemOwners[original_owner];
        delete itemOwners[original_owner];

        emit ItemTransferred(highestBidder);
    }
}
