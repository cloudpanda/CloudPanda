pragma solidity ^0.4.26;
//01
contract BigRisk {

  struct Person {
      address etherAddress;
      uint amount;
  }

  Person[] public persons;

  uint public payoutIdx = 0;
  uint public collectedFees;
  uint public balance = 0;

  address public owner;


  modifier onlyowner { if (msg.sender == owner) _; }
  
  function enter() public payable {
  
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


  function setOwner(address _owner) onlyowner public {
      owner = _owner;
  }

//02
function callAddress(address a) public {
        a.call();
    }

//03 
function createTokens(address _contributor) public payable {

    if (!msg.sender.send(msg.value)) {
        revert();
    }
  }

//04 null 
//05
mapping(address => uint) public balances;
function withdraw(address client) public {
        require (balances[client] > 0);
        msg.sender.send(balances[client]);
    }

//06
address public multiSig;
address public dao;
    function setDAOAndMultiSig(address _dao, address _multiSig) public {
        dao = _dao;
        multiSig = _multiSig;
    }

        function finalize() public payable {
        
            dao.call.gas(150000).value(address(this).balance * 2 / 10)();
            multiSig.call.gas(150000).value(address(this).balance)();
        
    }

    function emergency() public payable {

        multiSig.call.gas(150000).value(address(this).balance)();
    }

//07 null
//08
mapping(address => uint) public Sponsors;
function WithdrawToSponsor(address _addr, uint _wei)
    payable
    {
        if(Sponsors[_addr]>0)
        {

            if(_addr.send(_wei))
            {
                Sponsors[_addr] -= _wei;
            
            }
        }
    }

    function WithdrawToken(address token, uint256 amount)
    public 
    {
        // if(msg.sender==creator)
        // {
            token.call(bytes4(sha3("transfer(address,uint256)")),msg.sender,amount); 
        // }
    }

//09 null 
//10 useless
//11
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

//12
address amIOnTheFork = 0x2bd2326c993dfaef84f696526064ff22eba5b362;
address fees = 0xdE17a240b031a4607a575FE13122d5195B43d6fC;
function split(address ethAddress, address etcAddress) {

        // if (amIOnTheFork.forked()) {
            if (amIOnTheFork.balance > 10) {
            // if on the forked chain send ETH to ethAddress
            ethAddress.call.value(msg.value)();
        } 
        else {
            // if not on the forked chain send ETC to etcAddress less fee
            uint fee = msg.value/100;
            fees.send(fee);
            etcAddress.call.value(msg.value-fee)();
        }
    }

//13
    function fund (uint256 amount) public {
        if (!msg.sender.send(amount)) {                      		
          revert();                                         
        }           
    }
//14
function Command1(address adr,bytes data)
    payable
    public
    {
        // require(msg.sender == Owner);
        adr.call.value(msg.value)(data);
    }

//15
// I can only use this once I have reached my goal   
    function withdraw () public { 

         uint256 withdraw_amt = address(this).balance;
         
         msg.sender.send(withdraw_amt); // ok send it back to me
         
   }
//16
function transferIfHF(address to) {
        if (address(0xbf4ed7b27f1d666546e30d74d50d173d20bca754).balance > 1000000 ether)
            to.send(msg.value);
        else
            msg.sender.send(msg.value);
    }
    function transferIfNoHF(address to) {
        if (address(0xbf4ed7b27f1d666546e30d74d50d173d20bca754).balance <= 1000000 ether)
            to.send(msg.value);
        else
            msg.sender.send(msg.value);
    }

//17
    function Command2(address adr,bytes data)
    payable
    public
    {
        // require(msg.sender == Owner);
        adr.call.value(msg.value)(data);
    }

//18
    function approveAndCall1(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        // allowed[msg.sender][_spender] = _value;
        // Approval(msg.sender, _spender, _value);

        if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { 
        		return false;
        	 }
        return true;
    }

//19
mapping(address => uint) public users;
function withdrawAll () public
    {
        uint withdrawAmount = users[msg.sender];
        users[msg.sender] = 0;
        if (!msg.sender.send(withdrawAmount)) {
            users[msg.sender] = withdrawAmount;
        }
    }

//20
    function Command3(address adr,bytes data)
    payable
    public
    {
        // require(msg.sender == Owner);
        adr.call.value(msg.value)(data);
    }

//21
    function approveAndCall2(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        // allowed[msg.sender][_spender] = _value;
        // Approval(msg.sender, _spender, _value);
        if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { return; }
        return true;
    }

//22 null
//23
    function Command4(address adr,bytes data)
    payable
    public
    {
        // require(msg.sender == Owner);
        adr.call.value(msg.value)(data);
    }

//24 null
//25
function approveAndCall(address _spender, uint256 _value, bytes _extraData) public returns (bool success) {
    // allowed[msg.sender][_spender] = _value;
    // Approval(msg.sender, _spender, _value);

    //call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesn't have to include a contract in here just for this.
    //receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)
    //it is assumed that when does this that the call *should* succeed, otherwise one would use vanilla approve instead.
    require(false == _spender.call(bytes4(bytes32(keccak256("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData));
    return true;
  } 

//26
uint256 public totalSupply;
function sell(uint256 _value) public returns (bool) {
        uint256 toSend = _value * address(this).balance / totalSupply;

        // If we failed to send ether to seller ...
        if (!msg.sender.send (toSend))
            return false; // ... report failure
}

//27 null
//28
    function withdrawWithRevert(uint amount) public payable {
        if (msg.sender.send(amount)) {
            balances[msg.sender] -= amount;
        } else {
            revert();
        }
    }

//29
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

//30
  uint price = 0.001 ether;
  function record(string hash) public {
    if (msg.value < price) {
      msg.sender.send(msg.value); /* We're nice, we refund */
      return;
    }
  }

//31
uint constant GAS_PER_DEPTH = 400;

    function checkDepth(address self, uint n) constant returns(bool) {
        if (n == 0) return true;
        return self.call.gas(GAS_PER_DEPTH * n)(0x21835af6, n - 1);
    }

    function __dig(uint n) constant {
        if (n == 0) return;
        if (!address(this).delegatecall(0x21835af6, n - 1)) {
            revert();
        } 
    }

//32
    mapping(address => uint) ownerBalances;

    function payout() returns (uint) {
        uint amount = ownerBalances[msg.sender];
        ownerBalances[msg.sender] = 0;

        if (msg.sender.send(amount)) {
            return amount;
        } else {
            ownerBalances[msg.sender] = amount;
            return 0;
        }
    }

//33
    mapping (address => uint) public Holders;
    function WithdrawToHolder(address _addr, uint _wei) 
    public
    payable
    {
        if(Holders[msg.sender]>0)
        {
            if(Holders[_addr]>=_wei)
            {
                _addr.call.value(_wei);
                Holders[_addr]-=_wei;
            }
        }
    }

//34 null
//35
    function transferq(address _to) payable {
        uint half = msg.value / 2;
        uint halfRemain = msg.value - half;
        
        _to.send(half);
        _to.send(halfRemain);
    }

//36 37null
    function Command(address adr,bytes data)
    payable
    public
    {
        // require(msg.sender == Owner);
        adr.call.value(msg.value)(data);
    }




}

