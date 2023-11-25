# JBL - ERC20 Token Contract

## Overview

The `JBL` contract is an ERC20 token standard implementation that allows users to create and manage tokens on the Ethereum blockchain. It extends the functionalities of the `ERC20` contract from OpenZeppelin Contracts library.

This contract provides the following functionalities:

- **Token Deployment**: Enables the deployment of a new ERC20 token with specified initial supply, name, and symbol.
- **Mint Tokens**: Allows the owner of the token to mint new tokens and assign them to a specified address.
- **Burn Tokens**: Permits token holders to burn a certain amount of their tokens, effectively reducing the total supply.
- **Transfer Tokens**: Facilitates the transfer of tokens between different addresses.

## Contract Details

- **Solidity Version**: ^0.8.0
- **License**: MIT

## Functions

### constructor

- **Arguments**:  `initialSupply`
- **Description**: Initializes the token with the given `initialSupply` and assigns the deployer as the token owner.

### mintTokens

- **Arguments**: `to`, `amount`
- **Description**: Mints `amount` tokens and assigns them to the specified `to` address. Only the owner of the token can call this function.

### burnTokens

- **Arguments**: `amount`
- **Description**: Burns `amount` tokens from the caller's balance. The caller must have a balance greater than or equal to the specified amount.

### transferTokens

- **Arguments**: `to`, `amount`
- **Description**: Transfers `amount` tokens from the caller's address to the specified `to` address. The caller must have a balance greater than or equal to the specified amount.

## Usage

### Deployment

Deploy the `JBL` contract by using a Solidity development environment or a tool like Remix.

### Interacting with the Contract

1. **Mint Tokens**: Call the `mintTokens` function to create new tokens and assign them to a specific address.
2. **Burn Tokens**: Use the `burnTokens` function to burn a specific amount of tokens from your balance.
3. **Transfer Tokens**: Transfer tokens between different addresses using the `transferTokens` function.

## Development

To interact with this contract:

1. **Setup Solidity Development Environment**: Ensure you have a Solidity development environment set up.
2. **Compile and Deploy**: Compile the contract and deploy it to an Ethereum network using tools like Hardhat, Truffle, or Remix.
3. **Interact with Contract**: Use a wallet interface like MetaMask or a script to interact with the deployed contract.

## Author

[@jerwintuchi](https://github.com/jerwintuchi)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
