// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Subnet is ERC20
{
    address public Gupta;

    modifier onlyGupta
    {
        require(msg.sender == Gupta, "Only the contract Gupta can perform this action");
        _;
    }

    constructor() ERC20("SOYAM", "SYM")
    {
        Gupta = msg.sender;
    }

    function MintForMyself(uint256 amount) external onlyGupta payable 
    {
        uint valueToPay = amount *10;
        require(msg.value >= valueToPay,"You didn't payed enough");
        (bool msgRes,) = payable(msg.sender).call{value: msg.value - valueToPay}("");
        require(msgRes);
        _mint(msg.sender, amount);
    }
    function MintForOthers(address _friendAddress, uint amount) external payable  {
        uint valueToPay = amount *10;
        require(msg.value >= valueToPay,"You didn't payed enough");
        (bool msgRes,) = payable(msg.sender).call{value: msg.value - valueToPay}("");
        require(msgRes);
        _mint(_friendAddress, amount);
    }

    function burnToken(uint256 amount) external 
    {
        _burn(msg.sender, amount);
    }

	function showMyBalance() external view returns(uint ){
		return balanceOf(msg.sender);
	}

    function TransferToAny(address recipient, uint256 amount) external
    {   require(balanceOf(msg.sender)>=amount);
        transfer(recipient, amount);
    }
}
