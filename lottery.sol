// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract lottery{

    address public manager;
    address payable[] public participants;

    constructor()
    {
        manager=msg.sender; // store the adress of the manger
    }

    receive() external payable {
        require(msg.value == 1 ether); // same as if else  i.e the ether value send by participants
        //must be greater than 1ether for transfer
        participants.push(payable(msg.sender));
    }

    function getbalance() public view returns(uint)
    {
        require(msg.sender== manager);
        return address(this).balance;
    }
    
    // function for selecting participants randomly
    // return in a form of a hash value

    function random() public view returns(uint)
    {
       return  uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp, participants.length)));
    }

    //select the winner function
    // convert the hash value to int return by the bove function  

    function selectwinner() public
    {
        require(msg.sender==manager);

        require(participants.length>=3);
        uint r= random();
        address payable winner;
        uint index = r % participants.length; // accessing index through this adress and miniising the value of the index
        winner= participants[index];
        winner.transfer(getbalance());
        participants= new address payable[](0);




    }




}