// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.27;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @author Carlos Bermudez 
 * @title VoltronToken
 * @dev A simple ERC20 token with minting functionality that can be controlled by the owner.
 * The contract allows the owner to mint new tokens at any time. 
 * Initially, the owner is the one who receives the entire supply of tokens.
 */
contract VoltronToken is ERC20, Ownable {
    /**
     * @dev Constructor that initializes the contract with the token name "Mazinger Token" and symbol "MZGR".
     * The constructor also mints an initial supply of tokens to the contract owner.
     */
    constructor()
        ERC20("Voltron Token", "VLTR")
        Ownable(msg.sender)
    {
        // Mint an initial supply of 1,000,000 tokens to the owner
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    /**
     * @dev Allows the owner to mint new tokens to any address.
     * @param to The address to which the newly minted tokens will be sent.
     * @param amount The amount of tokens to mint.
     * Requirements:
     * - Only the owner can call this function.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    
}