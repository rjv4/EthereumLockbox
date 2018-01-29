# EthereumLockbox

This is a simple smart contract meant to hold Ethereum and ERC20 tokens until a specified unlock time. 
This is meant to be used as a way to keep full control over your holdings, while ensuring that they will go to a trustee in the case of an unexpected death/event.

If the unlock is reached, an address specified at creation of the contract is able to withdraw the funds from the smart contract.
The unlock time can also be updated by the owner address, allowing this contract to be extended indefinitely.

In order to retrive the funds, the owner may also selfdestruct the contract at any time.
