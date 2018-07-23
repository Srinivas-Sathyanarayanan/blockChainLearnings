//This is Splitter Contract to split the amount in to half sent from Alice to Bob & Carol
pragma solidity ^0.4.19;
contract Splitter{
	
	//state variables
	address public owner;
	mapping (address => uint) public balances;
	
	//events
	event LogSplitFunds(address owner, uint amount,address receiverOne,uint recOneBal,address receiverTwo,uint recTwoBal);
	
	//modifiers
	// The contract here will only define a modifier but will not 
	// use it - derived contracts are going to utilize it.
	// The body of the function is inserted where the special 
	// symbol "_;" in the modifier's definition appears.
	// That means that when the owner will call this function, 
	// the function will get executed and otherwise, an exception 
	// will be thrown.
	modifier onlyOwner {
	  require(msg.sender == owner);
	  _;
	}


	function Splitter() public { owner = msg.sender; }
  	  
  	  
	function split(address receiverOne, address receiverTwo)  public  payable returns(bool isSuccessfull){
	      	uint amt = msg.value;
		//LogSenderBalance(msg.sender,msg.value);
		require(amt > 0);
		
		uint remAmt = msg.value % 2;
		uint splitAmt = (msg.value - remAmt) / 2;

		if (remAmt > 0){
			balances[owner] += remAmt;}

		balances[receiverOne] += splitAmt;
		
		balances[receiverTwo] += splitAmt;

		LogSplitFunds(owner,balances[owner],receiverOne,balances[receiverOne],receiverTwo,balances[receiverTwo]);	

		return true;
	
	}
	
	//Funds withdraw
	function withdrawFunds() public {
	   uint bal = balances[msg.sender];

	    require(bal>0);
	    
	    balances[msg.sender] = 0;
	  
	    msg.sender.transfer(bal);

	  }


	//Self destruct function to be called only by owner
  	function kill() public onlyOwner(){ 
		 selfdestruct(owner);
  	}
	
}

