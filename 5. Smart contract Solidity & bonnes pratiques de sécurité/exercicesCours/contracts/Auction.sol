pragma solidity 0.8.17;
 
/**
 * Example of DOS attack (Denial of Service). 
 * Here the Auction contract could be blocked if in the bid method we reimburse the bidder and he doesn't implement a receive or fallback function
 */
contract Auction {
    address highestBidder;
    uint highestBid;
    mapping(address => uint) refunds;
 
    function bid() payable external {
        require(msg.value >= highestBid);
 
        if (highestBidder != address(0)) {
            refunds[highestBidder] += highestBid; // Pull over push: record the refund that this user can claim in withdrawRefund method
        }
 
        highestBidder = msg.sender;
        highestBid = msg.value;
    }
 
    function withdrawRefund() external {
        uint refund = refunds[msg.sender];
        refunds[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value:refund}("");
        require(success);
    }
}