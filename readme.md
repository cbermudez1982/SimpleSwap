# SimpleSwap Contract

## Overview

**SimpleSwap** is a decentralized exchange (DEX) contract that facilitates liquidity provision and token swaps. This contract allows users to:

- Add liquidity to a pool of two ERC20 tokens.
- Remove liquidity from the pool and receive the underlying tokens.
- Swap between two ERC20 tokens.

The contract uses the ERC20 standard for the liquidity pool token, implements token burning, and is governed by an owner (via the `Ownable` contract from OpenZeppelin).

## Key Features

- **ERC20 Token**: The contract is based on the ERC20 standard, allowing it to issue fungible tokens.
- **Liquidity Management**: Users can add and remove liquidity for a pair of tokens.
- **Swapping**: Users can swap between two ERC20 tokens.
- **Burnable Tokens**: Users can burn their tokens, reducing the total supply.
- **Owner Control**: The contract uses the `Ownable` contract, which allows the owner to manage contract parameters and permissions.
  
## Contract Components

### Modifiers

#### `checkDeadline`

Ensures that the provided deadline is later than the current block timestamp.

#### `checkLiquidity`

Ensures that the liquidity reserves for both tokens are greater than zero.

#### `checkTokensSelected`

Ensures that exactly two tokens are selected for any token swap operation.

### Functions

#### `_getReserves`

Retrieves the current reserves of the two tokens in the contract.

#### `_approveTokenTransfers`

Approves the contract to transfer the specified amounts of tokens on behalf of the user.

#### `_safeTransferFrom` / `_safeTransfer`

These functions safely transfer tokens between addresses, ensuring that the transfer succeeds.

#### `_calculateMin`

Calculates the minimum of two values based on the liquidity of both tokens in the pair.

#### `_calculateLiquidity`

Calculates the liquidity for a pair of tokens based on the amount added and the total supply.

#### `addLiquidity`

Allows users to add liquidity to the contract and receive liquidity tokens in return.

#### `removeLiquidity`

Allows users to remove liquidity from the contract and receive the underlying tokens.

#### `swapExactTokensForTokens`

Allows users to swap one token for another, ensuring that the output is at least as much as the minimum specified.

#### `getAmountOut`

Calculates the amount of output tokens a user would receive based on the amount of input tokens and the current reserves.

#### `getPrice`

Gets the price of one token in terms of another token, based on the current reserves.

## Constructor

The constructor initializes the contract with the name "Simple Swap" and symbol "SSWP", and sets the deployer as the contract owner.

## Example Usage

```solidity
SimpleSwap swap = new SimpleSwap();
address tokenA = 0x1234567890abcdef1234567890abcdef12345678;
address tokenB = 0xabcdefabcdefabcdefabcdefabcdefabcdefabcdef;
uint amountADesired = 1000;
uint amountBDesired = 2000;
uint amountAMin = 500;
uint amountBMin = 1000;
address to = msg.sender;
uint deadline = block.timestamp + 1 hours;

// Adding liquidity
swap.addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin, to, deadline);
