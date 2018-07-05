//This is Splitter Contract to split the amount in to half sent from Alice to Bob & Carol
pragma solidity ^0.4.19;
contract Splitter{

	function owned() public { owner = msg.sender; }
  	  address owner;


	mapping (address => uint) public addresses;

	 // This contract only defines a modifier but does not use
    // it: it will be used in derived contracts.
    // The function body is inserted where the special symbol
    // `_;` in the definition of a modifier appears.
    // This means that if the owner calls this function, the
    // function is executed and otherwise, an exception is
    // thrown.
	  modifier onlyOwner {
		require(
		    msg.sender == owner,
		    "Only owner can call this function."
		);
		_;
	    }

	function split(address receiverOne, address receiverTwo)  public  payable returns(bool isSuccessfull){
	      
		require(msg.value>0);
		
		uint remAmt = msg.value % 2;
		uint splitAmt = (msg.value - remAmt) / 2;

		if (remAmt > 0){
			addresses[owner] += remAmt;}

		addresses[receiverOne] += splitAmt;
		
		addresses[receiverTwo] += splitAmt;

		return true;
	
	}
	
//Funds withdraw
	function withdrawFunds() public {

	    require(addresses[msg.sender]>0);
	    uint amount = addresses[msg.sender];

	 
	    addresses[msg.sender] = 0;
	  
	    msg.sender.transfer(amount);

	  }





	//Self destruct function to be called only by owner
  	function kill() public{ 
		if (msg.sender == owner) selfdestruct(owner);
		 }
	
}

