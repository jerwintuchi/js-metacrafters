# Metacrafters Ethereum Project

This repository contains Ethereum smart contracts for managing items and a custom ERC20 token called DegenToken. The contracts are developed using Solidity and deployed using Hardhat.

## Contracts

### ItemManager.sol

The `ItemManager.sol` contract manages items. It provides functionalities to create, transfer ownership, put items for sale, change prices, and mark items as sold. This contract emits events for item creation, transfers, sale status changes, and price updates.

### DegenToken.sol

The `DegenToken.sol` contract implements the ERC20 standard for the DegenToken. It inherits from the OpenZeppelin ERC20 contract and adds functionalities for minting, setting an ItemManager address, transferring tokens, redeeming tokens for items, checking balances, and burning tokens.

## Deployment Script (deploy.js)

The `deploy.js` script automates the deployment of the ItemManager and DegenToken contracts using Hardhat. It gets the contract factories, deploys the contracts, and displays their deployed addresses.

## How to Run and Deploy

### Prerequisites

- Node.js
- Hardhat

To run the project locally, follow these steps:

1. **Clone the Repository:** `git clone https://github.com/jerwintuchi/metacrafters-projects.git`
2. **Navigate to the Project Directory:** `cd metacrafter-projects\eth+avax-project-module-1-to-4\module-4\DegenToken`
3. **Install Dependencies:** `npm install`
4. Open two additional terminals in your VS code
3. In the second terminal type: npx hardhat node
4. In the third terminal, type: npx hardhat run --network localhost scripts/deploy.js
5. Back in the first terminal, type npm run dev to launch the front-end.

### Interacting with Contracts

The contracts provide various functionalities that can be interacted with:

- `ItemManager.sol`: Handles item management.
- `DegenToken.sol`: Manages the DegenToken and provides functionalities for token transfers, redemptions, and burns.

### Smart Contract Development and Deployment

1. **Modify Contracts:** Modify the Solidity contracts (`ItemManager.sol`, `DegenToken.sol`) to suit your requirements.
2. **Compile Contracts:** Run `npx hardhat compile` to compile the contracts.
3. **Start a Local Ethereum Node:** Run `npx hardhat node` to start a local Ethereum node.
4. **Deploy Contracts:** Use `npx hardhat run --network localhost scripts/deploy.js` to deploy the contracts to the local network.

The project will be accessible at [http://localhost:3000/](http://localhost:3000/).

## Author

[@jerwintuchi](https://github.com/jerwintuchi)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
