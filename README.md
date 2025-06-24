# SimpleSwap Contract

## Overview

**SimpleSwap** is a decentralized exchange (DEX) contract that facilitates liquidity provision and token swaps. This contract allows users to:

- Add liquidity to a pool of two ERC20 tokens.
- Remove liquidity from the pool and receive the underlying tokens.
- Swap between two ERC20 tokens.

The contract uses the ERC20 standard for the liquidity pool token, implements token burning, and is governed by an owner (via the `Ownable` contract from OpenZeppelin).

## ✨ Key Features

- **ERC20 Token**: The contract is based on the ERC20 standard, allowing it to issue fungible tokens.
- **Liquidity Management**: Users can add and remove liquidity for a pair of tokens.
- **Swapping**: Users can swap between two ERC20 tokens.
- **Burnable Tokens**: Users can burn their tokens, reducing the total supply.
- **Owner Control**: The contract uses the `Ownable` contract, which allows the owner to manage contract parameters and permissions.

---

## 🧰 Tech Stack

- Solidity ^0.8.27
- OpenZeppelin Contracts ^5.0.0
- ReentrancyGuard + Ownable
- Sepolia testnet

---

## 🚀 Deployment
| Network   |  Type            |    Contract Address                               |              Deployer Address                  |
|-----------|------------------|---------------------------------------------------|------------------------------------------------|
| Sepolia   | Smart Contract   |  [0x53716a2a8CF8ebfC9f829A9218F56dD492427Ee3](https://sepolia.etherscan.io/address/0x53716a2a8CF8ebfC9f829A9218F56dD492427Ee3) |   `0xa7a33b766647bb6E1AF4F4F65a0A6EC102f4A921` |
| Sepolia   | Test Token A     |  [0x1F784DeFBE370f6eC510eED68edc5eC9cD372935](https://sepolia.etherscan.io/address/0x1F784DeFBE370f6eC510eED68edc5eC9cD372935) |   `0xa7a33b766647bb6E1AF4F4F65a0A6EC102f4A921` |
| Sepolia   | Test Token B     |  [0x87A6480A7B77D74995302603016d88B9f54CB5a3](https://sepolia.etherscan.io/address/0x87A6480A7B77D74995302603016d88B9f54CB5a3) |   `0xa7a33b766647bb6E1AF4F4F65a0A6EC102f4A921` |
  
---

## Contract Components

### Modifiers

#### `checkDeadline`

Ensures that the provided deadline is later than the current block timestamp.

#### `checkLiquidity`

Ensures that the liquidity reserves for both tokens are greater than zero.

#### `checkTokensSelected`

Ensures that exactly two tokens are selected for any token swap operation.

### Events

#### `LiquidityAdded`

Event emited everytime liquidity is added to the pool.

#### `LiquidityRemoved`

Event emited everytime liquidity is removed to the pool.

#### `TokenSwapped`

Event emited everytime a token swap occurs in the contract.


### Functions

#### `_getReserves`

Retrieves the current reserves of the two tokens in the contract.

#### `_getOptimalAmountOut`

Calculates the optimal output amount of token B for a given input of token A.

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

---

## 🛠 Functions Overview & Usage Examples

### ✅ Add Liquidity

```solidity
IERC20(tokenA).approve(address(simpleSwap), amountADesired);
IERC20(tokenB).approve(address(simpleSwap), amountBDesired);

(simpleSwap).addLiquidity(
  tokenA,
  tokenB,
  amountADesired,
  amountBDesired,
  amountAMin,
  amountBMin,
  msg.sender,
  block.timestamp + 600
);
```

---

### ♻️ Remove Liquidity

```solidity
// Assume LP tokens are already owned
IERC20(address(simpleSwap)).approve(address(simpleSwap), liquidityAmount);

(simpleSwap).removeLiquidity(
  tokenA,
  tokenB,
  liquidityAmount,
  amountAMin,
  amountBMin,
  msg.sender,
  block.timestamp + 600
);
```

---

### 🔁 Swap Tokens

```solidity
address[] memory path = new address[](2);
path[0] = tokenIn;
path[1] = tokenOut;

IERC20(tokenIn).approve(address(simpleSwap), amountIn);

simpleSwap.swapExactTokensForTokens(
  amountIn,
  amountOutMin,
  path,
  msg.sender,
  block.timestamp + 600
);
```

---

### 📈 Get Output Amount

```solidity
uint expectedOut = simpleSwap.getAmountOut(
  amountIn,
  reserveIn,
  reserveOut
);
```

---

### 💰 Get Price

```solidity
uint price = simpleSwap.getPrice(tokenA, tokenB);
// Returns tokenB per tokenA (18 decimals)
```

---

## 📌 Notes

- LP tokens represent your share in the pool and must be burned to retrieve assets.
- Reserves and prices are calculated dynamically.
- No trading fees included — this can be added as a feature.

