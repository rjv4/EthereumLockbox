pragma solidity ^0.4.19;

contract Lockbox {
  address owner;
  address trustee;
  uint unlockTime;

  function Lockbox(uint _unlockTime, address _trustee) public {
    owner = msg.sender;
    unlockTime = _unlockTime;
    trustee = _trustee;
  }
  
  function() public payable { }
   
  function upDateUnlockTime(uint _updatedUnlockTime) public {
    if (msg.sender == owner)
      unlockTime = _updatedUnlockTime;
  }

  function isUnlocked() internal returns (bool) {
    return now >= unlockTime;
  }

  modifier onlyTrustee() { require(msg.sender == trustee); _; }
  modifier onlyWhenUnlocked() { require(isUnlocked()); _; }

  function withdrawBalance() payable onlyTrustee onlyWhenUnlocked public {
    trustee.transfer(address(this).balance);
  }
  
  function kill() public { 
    if (msg.sender == owner) 
      selfdestruct(owner); 
  }
}
