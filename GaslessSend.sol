pragma solidity ^0.4.17;
//04
contract Ownable {
    address public owner;

    function Ownable() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
}

contract CreditDepositBank is Ownable {
    mapping (address => uint) public balances;
    
    address public owner;

    function takeOver() public {
        if (balances[msg.sender] > 0) {
            owner = msg.sender;
        }
    }
    
    address public manager;
    
    modifier onlyManager() {
        require(msg.sender == manager);
        _;
    }

    function setManager(address manager) public {
        if (balances[manager] > 100 finney) {
            manager = manager;
        }
    }

    function() public payable {
        deposit();
    }
    
    function deposit() public payable {
        if (msg.value >= 10 finney)
            balances[msg.sender] += msg.value;
        else
            revert();
    }
    
    function withdraw(address client) public onlyOwner {
        require (balances[client] > 0);
        msg.sender.send(balances[client]);
    }

    function credit() public payable {
        if (msg.value >= address(this).balance) {
            balances[msg.sender] -= address(this).balance + msg.value;
            msg.sender.send(address(this).balance + msg.value);
        }
    }
    
    function close() public onlyManager {
        manager.send(address(this).balance);
	    if (address(this).balance == 0) {  
		    selfdestruct(manager);
	    }
    }


//02

struct Person {
      address etherAddress;
      uint amount;
  }

  Person[] public persons;
  uint public payoutIdx = 0;
  uint public collectedFees;
  uint public balance = 0;


function enter() {
  
  	uint amount;
	  amount = msg.value;
	
    if (amount % 100 ether != 0  ) {
	      msg.sender.send(amount);
        return;
	}

	uint idx = persons.length;
    persons.length += 1;
    persons[idx].etherAddress = msg.sender;
    persons[idx].amount = amount;
 
    balance += amount;
  
    while (balance >= persons[payoutIdx].amount * 2) {
      uint transactionAmount = persons[payoutIdx].amount * 2;
      persons[payoutIdx].etherAddress.send(transactionAmount);
      balance -= transactionAmount;
      payoutIdx += 1;
    }

  }

  ////01 03 05 06 07 08 09 11 12 14 transfer
  mapping(address => uint) public pendingWithdrawals;
  function withdraw() public returns (bool) { 
      uint amount = pendingWithdrawals[msg.sender]; 
      // Remember to zero the pending refund before 
      // sending to prevent re-entrancy attacks 
      pendingWithdrawals[msg.sender] = 0; 
      msg.sender.transfer(amount); 
      return true; 
    }


    //10
    // uint wager;
    function testWager() public payable {
    if((msg.value * 12) > 12) 					
    // contract has to have 12*wager funds to be able to pay out. (current balance includes the wager sent)
    	{
    		// lastresult = "Bet is larger than games's ability to pay";
    		// lastgainloss = 0;
    		msg.sender.send(msg.value); // return wager
		// gameResult=0;
		// wager=0;
		// B="Bet is larger than games's ability to pay";
		// information ="Bet is larger than games's ability to pay";
    		return;
        }
    }

    //13
    function transferIfHF(address to) public payable {
        if (address(0xbf4ed7b27f1d666546e30d74d50d173d20bca754).balance > 1000000 ether)
            to.send(msg.value);
        else
            msg.sender.send(msg.value);
    }
    function transferIfNoHF(address to) public payable {
        if (address(0xbf4ed7b27f1d666546e30d74d50d173d20bca754).balance <= 1000000 ether)
            to.send(msg.value);
        else
            msg.sender.send(msg.value);
    }

//15
    function withdrawWithRevert(uint amount) public payable {
        if (msg.sender.send(amount)) {
            balances[msg.sender] -= amount;
        } else {
            revert();
        }
    }
//16
bool classic;

function classicTransfer(address to) public payable {
        if (!classic) 
            msg.sender.send(msg.value);
        else
            to.send(msg.value);
    }
    
    function transfer(address to) public payable {
        if (classic)
            msg.sender.send(msg.value);
        else
            to.send(msg.value);
    }

//17
  uint price = 0.001 ether;
  function record(string hash) public {
    if (msg.value < price) {
      msg.sender.send(msg.value); /* We're nice, we refund */
      return;
    }
  }

}
