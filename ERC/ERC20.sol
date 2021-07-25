// SPDX-License-Identifier: UNLICENSE

import "SafeMath.sol";

pragma solidity ^0.8.6;

/**
 * @title ERC20Examp
 * @author Nauxiuh Gnehz
 */
contract ERC20Example {
    
    using SafeMath for uint256;
    
    string public name;                   //fancy name: eg Example Token .
    string public symbol;                 //An identifier: eg ET .
    uint8 public decimals;                //How many decimals to show .
    
    
    uint256 private _totalSupply;
    
    
    address public tokenOwner;
    
    
    
    mapping (address => uint256) public balances;
    
    mapping (address => mapping (address => uint256)) public allowed;
    
    
    
    event Transfer(address indexed from,address indexed to,uint256 value);

    event Approval(address indexed owner,address indexed spender,uint256 valueis );
    
    
    
    
    /**
     * @dev Initialize the basic information of the Token
     */
    constructor() {
        name = "Example Token";
        symbol = "ET";
        decimals = 8;
        
        _totalSupply = 50000;
        
        balances[msg.sender] = _totalSupply;
        
        tokenOwner = msg.sender;
    }
    
    
    // modifier to check if caller is owner
    modifier onlyOwner() {
        require(msg.sender == tokenOwner, "Caller is not owner");
        _;
    }
    
    
    
    /**
     * @dev Public function that mints an amount of the token and assigns it to an account. 
     * @param account The account that will receive the created tokens.
     * @param amount The amount that will be created.
     */
    function mint(address account, uint256 amount) public onlyOwner {
        require(account != address(0));
        _totalSupply = _totalSupply.add(amount);
        balances[account] = balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }
    
    

    /**
     * @dev Public function that burns an amount of the token of a given account.
     * @param account The account whose tokens will be burnt.
     * @param amount The amount that will be burnt.
     */
    function burn(address account, uint256 amount) public onlyOwner {
        require(account != address(0));
        require(amount <= balances[account]);

        _totalSupply = _totalSupply.sub(amount);
        balances[account] = balances[account].sub(amount);
        emit Transfer(account, address(0), amount);
    }
    
    
    
     /**
     * @dev The total amount of existential token
     */
     function totalSupply() public view returns (uint256) {
         return _totalSupply;
     }
     
     
  
     /**
     * @dev Gets the balance of the specified tokenOwner.
     * @param owner The address to query the balance of.
     * @return An uint256 representing the amount owned by the passed address.
     */
     function balanceOf(address owner) public view returns (uint256) {
         return balances[owner];
     }
     
     
  
    /**
     * @dev Function to check the amount of tokens that an owner allowed to a spender.
     * @param owner address The address which owns the funds.
     * @param spender address The address which will spend the funds.
     * @return A uint256 specifying the amount of tokens still available for the spender.
     */
    function allowance(address owner,address spender) public view returns (uint256) {
        return allowed[owner][spender];
    }
    
    
  
    /**
     * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
     * @param spender The address which will spend the funds.
     * @param value The amount of tokens to be spent.
     */
    function approve(address spender, uint256 value) public returns (bool) {
        require(spender != address(0));

        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    
    
    /**
     * @dev Increase the amount of tokens that an owner allowed to a spender.
     * @param spender The address which will spend the funds.
     * @param addedValue The amount of tokens to increase the allowance by.
     */
    function increaseAllowance(address spender,uint256 addedValue) public returns (bool) {
        require(spender != address(0));
        allowed[msg.sender][spender] = (allowed[msg.sender][spender].add(addedValue));
        emit Approval(msg.sender, spender, allowed[msg.sender][spender]);
        return true;
    }
    
    

    /**
     * @dev Decrease the amount of tokens that an owner allowed to a spender.
     * @param spender The address which will spend the funds.
     * @param subtractedValue The amount of tokens to decrease the allowance by.
     */
    function decreaseAllowance(address spender,uint256 subtractedValue) public returns (bool) {
        require(spender != address(0));
        allowed[msg.sender][spender] = (allowed[msg.sender][spender].sub(subtractedValue));
        emit Approval(msg.sender, spender, allowed[msg.sender][spender]);
        return true;
    }
  
  
  
    /**
     * @dev Transfer token to a specified address
     * @param to The address to transfer to.
     * @param value The amount to be transferred.
     */
    function transfer(address to, uint256 value) public returns (bool) {
        require(value <= balances[msg.sender]);
        require(to != address(0));

        balances[msg.sender] = balances[msg.sender].sub(value);
        balances[to] = balances[to].add(value);
        emit Transfer(msg.sender, to, value);
        return true;
    }
  
  
  
    /**
     * @dev Transfer tokens from one address to another
     * @param from address The address which you want to send tokens from
     * @param to address The address which you want to transfer to
     * @param value uint256 the amount of tokens to be transferred
     */
    function transferFrom(address from,address to,uint256 value) public returns (bool) {
        require(value <= balances[from]);
        require(value <= allowed[from][msg.sender]);
        require(to != address(0));

        balances[from] = balances[from].sub(value);
        balances[to] = balances[to].add(value);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(value);
        emit Transfer(from, to, value);
        return true;
    }
  
  
}


