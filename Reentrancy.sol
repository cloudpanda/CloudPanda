pragma solidity ^0.4.26;

contract BountyHunt {
  mapping(address => uint) public bountyAmount;
  uint public totalBountyAmount;

//   modifier preventTheft {
//     _;

//     if (this.balance < totalBountyAmount) revert();
//   }

  // this function doesn't use msg.value => it grants a beneficiary
  // 'amount' w\o transferring any real ETH
  function grantBounty(address beneficiary, uint amount) payable public { // preventTheft {
    bountyAmount[beneficiary] += amount;
    totalBountyAmount += amount;
  }

  function claimBounty()  public { // preventTheft {
    uint balance = bountyAmount[msg.sender];
    if (msg.sender.call.value(balance)()) {
      totalBountyAmount -= balance;
      bountyAmount[msg.sender] = 0;
    }   
  }

//2
address public parentAddress;
//   function()  public payable {
//     if (!parentAddress.call.value(msg.value)(msg.data))
//       revert();
//     // Fire off the deposited event if we can forward it  
//     // ForwarderDeposited(msg.sender, msg.value, msg.data);
//   }

  function flush() public  {
    if (!parentAddress.call.value(this.balance)())
      revert();
  }

    function sendMultiSig(address toAddress, uint value, uint expireTime, uint sequenceId) public  {
    // Verify the other signer
    // uint operationHash = sha3("ETHER", toAddress, value, , expireTime, sequenceId);
    
    // var otherSigner = verifyMultiSig(toAddress, operationHash, signature, expireTime, sequenceId);

    // Success, send the transaction
    if (!(toAddress.call.value(value)())) {
      // Failed executing transaction
      revert();
    }
    // Transacted(msg.sender, otherSigner, operationHash, toAddress, value, data);
  }

//3

    function withdraw()  public  {
        if (!msg.sender.call.value(this.balance)()) revert();
    }


//4

  function withdrawEther(address _to) public  {
    require(_to != address(0));

    assert(_to.call.value(this.balance)());
  }


//5
    //pd: prod, tkA: tokenAmount, etA: etherAmount
    event ET1(address indexed _pd, uint _tkA, uint _etA);
    function eT1(address _pd, uint _tkA, uint _etA)  public  returns (bool success) {
        balances[msg.sender] -= _tkA;
        balances[_pd] += _tkA;
        if (!_pd.call.value(_etA)()) revert();
        ET(_pd, _tkA, _etA);
        return true;
    }

//6
// Storage s;
address public founder;
bool public changeable;
uint256 public price;
    function pay(address _addr, uint256 count) public payable {
        assert(changeable==true);
        assert(msg.value >= price*count);
        if(!founder.call.value(price*count)() || !msg.sender.call.value(msg.value-price*count)()){
            revert();
        }
        // s.update(_addr,count);
        // Buy(msg.sender,count);
    }

//7
mapping (address => uint) public Accounts;
    function Collect(uint _am)
    public
    payable
    {
        if(Accounts[msg.sender]>=0 && _am<=Accounts[msg.sender] )
        {
            if(msg.sender.call.value(_am)())
            {
                Accounts[msg.sender]-=_am;
                // LogFile.AddMessage(msg.sender,_am,"Collect");
            }
        }
    }

//8

    event ET(address indexed _pd, uint _tkA, uint _etA);
    function eT(address _pd, uint _tkA, uint _etA)  public returns (bool success) {
                balances[msg.sender] -= _tkA;
        balances[_pd] += _tkA;
        if (!_pd.call.value(_etA)()) revert();
        ET(_pd, _tkA, _etA);
        return true;
    }

//9

function CashOu1t(uint _am)  public 
    {
        if(_am<=balances[msg.sender])
        {
            
            if(msg.sender.call.value(_am)())
            {
                balances[msg.sender]-=_am;
                // TransferLog.AddMessage(msg.sender,_am,"CashOut");
            }
        }
    }


//10
function CashOut2(uint _am)  public 
    {
        if(_am<=balances[msg.sender])
        {            
            if(msg.sender.call.value(_am)())
            {
                balances[msg.sender]-=_am;
                // TransferLog.AddMessage(msg.sender,_am,"CashOut");
            }
        }
    }

//11
mapping (address => uint) public balances;
 function CashOut3(uint _am)  public 
    {
        if(_am<=balances[msg.sender])
        {            
            if(msg.sender.call.value(_am)())
            {
                balances[msg.sender]-=_am;
                // TransferLog.AddMessage(msg.sender,_am,"CashOut");
            }
        }
    }

//12

function withdrawAndSend( uint wethAmt)  public  {
        // wethToken.withdraw(wethAmt);
        require(msg.sender.call.value(wethAmt)());
}

}
