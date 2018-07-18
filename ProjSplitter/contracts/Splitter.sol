//This is Splitter Contract to split the amount in to half sent from Alice to Bob & Carol
pragma solidity ^0.4.19;
contract Splitter{

	mapping (address => uint) public balances;

	event LogSenderBalance(address sender, uint amount);
	event LogBalance(address receiverOne,uint recOneBal,address receiverTwo,uint recTwoBal);

	function owned() public { owner = msg.sender; }
  	  address owner;


	

	function split(address receiverOne, address receiverTwo)  public  payable returns(bool isSuccessfull){
	      	uint amt = msg.value;
		//LogSenderBalance(msg.sender,msg.value);
		LogSenderBalance(owner,amt);
		require(amt > 0);
		
		uint remAmt = msg.value % 2;
		uint splitAmt = (msg.value - remAmt) / 2;

		if (remAmt > 0){
			balances[owner] += remAmt;}

		balances[receiverOne] += splitAmt;
		
		balances[receiverTwo] += splitAmt;

		LogBalance(receiverOne,balances[receiverOne],receiverTwo,balances[receiverTwo]);	

		return true;
	
	}
	
	//Funds withdraw
	function withdrawFunds() public {

	    require(balances[msg.sender]>0);
	    uint amount = balances[msg.sender];

	 
	    balances[msg.sender] = 0;

	    LogSenderBalance(msg.sender,msg.value);
	  
	    msg.sender.transfer(amount);

	  }





	//Self destruct function to be called only by owner
  	function kill() public{ 
		if (msg.sender == owner) selfdestruct(owner);
		 }
	
}

