// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

//BuyMeACoffee deployed to: 0x738095015Aa483067D2b98b77df9e47C20d0BE66 on goerli network

contract BuyMeACoffee {
    // Event to emit when a Memo is created.
    event NewMemo(
        address from ,
        uint256 timestamp ,
        string name ,
        string message
    );

    //Memo Struct
    struct Memo{
        address from ;
        uint256 timestamp ;
        string name ;
        string message;
    }

    // List of all Memos received from all
    Memo[] memos;

    // Address of contract deployer
    address payable owner;

    constructor(){
        owner = payable(msg.sender);
    }

    function buyCoffee(string memory _name, string memory _message) payable public {
        require(msg.value > 0 ,"Can't buy coffee with 0 ETH");
        // Add the memo to storage 
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a log evevnt when a new mwmo is created!
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    // Send the entire balance present in the contract to owner
    function withdrawTips() public {
        address(this).balance;
        require(owner.send(address(this).balance));
    }

    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
}