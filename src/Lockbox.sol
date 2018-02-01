pragma solidity ^0.4.19;

contract Lockbox {
  mapping(address => uint256) public balances;
  mapping(address => address) public trustees;
  mapping(address => uint) public unlockTimes;

  function deposit() public payable {
	   balances[msg.sender] += msg.value;
  }

  function upDateUnlockTime(uint _updatedUnlockTime) public {
    unlockTimes[msg.sender] = _updatedUnlockTime;
  }

  function isUnlocked(address _depositorAddress) public view returns (bool) {
    return now >= unlockTimes[_depositorAddress];
  }

  function setTrustee(address _trustee) public {
    trustees[msg.sender] = _trustee;
  }

  function isTrustee(address _depositorAddress) public view returns (bool) {
    return msg.sender == trustees[_depositorAddress];
  }

  function withdrawBalance(address _depositorAddress) public {
    if (msg.sender == _depositorAddress) {
        msg.sender.transfer(balances[_depositorAddress]);
        balances[msg.sender] = 0;
    }

    if (isTrustee(_depositorAddress) && isUnlocked(_depositorAddress)) {
      trustees[_depositorAddress].transfer(balances[_depositorAddress]);
      balances[_depositorAddress] = 0;
    }
  }
}
