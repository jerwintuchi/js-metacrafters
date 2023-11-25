# Fullstack Ethereum Project with React, Hardhat, and ethers.js

This is a fullstack project utilizing React.js for the front end and Hardhat for Ethereum development, integrating an Ethereum wallet using ethers.js.

## Project Structure

### Directories and Files

- `pages/index.js`: React component handling the Ethereum wallet interactions.
- `scripts/deploy.js`: Script for deploying the `Assessment` smart contract using Hardhat.
- `contracts/Assessment.sol`: Solidity smart contract implementing an assessment feature on the Ethereum blockchain.

### React Component (pages/index.js)

The `index.js` file contains a React component that manages interactions with an Ethereum wallet:

- Manages wallet connectivity with MetaMask.
- Displays user account information, balances, and allows transactions (deposit, withdraw, burn) on the Ethereum network.
- Utilizes `ethers.js` for interacting with Ethereum smart contracts.

### Smart Contract (contracts/Assessment.sol)

The `Assessment.sol` file includes a Solidity smart contract defining an assessment contract on the Ethereum blockchain:

- Implements functionalities for deposit, withdraw, transfer, and burn of Ether.
- Handles ownership and balance management.
- Utilizes Solidity's events for transaction logs.

## How to Run

### Prerequisites

- Node.js
- Hardhat
- MetaMask extension (for wallet interaction)

To run the project locally, follow these steps:

1. **Clone the Repository:** `git clone https://github.com/jerwintuchi/metacrafters-projects.git`
2. **Head to Module 2 Directory** `cd metacrafters-projects/eth+avax-project-module-1-to-4/module-2`
3. **Install Dependencies:** at the root folder type **`npm i`**

### Interacting with the Contract

1. **Connect MetaMask:** Install and connect MetaMask to your browser.
2. **Connect Wallet:** Click on "Connect your MetaMask wallet" to connect your wallet to the app.
3. **Perform Transactions:** Deposit, withdraw, transfer, or burn Ether using the respective buttons.

## Smart Contract Development and Deployment

1. **Make 3 terminals inside VS** click the **`+`** on terminal tab, or press **`Ctrl + Shift + ``*
2. **Smart Contract Development:** Modify `Assessment.sol` in the `contracts` directory for contract logic.
3. **Setup the Smart Contract:** Run **`npx hardhat node`** to start a local Ethereum node.
4. **Deploy Contract:** Use **`npx hardhat run --network localhost scripts/deploy.js`** to deploy the contract to a local network.

The project will be accessible at [http://localhost:3000/](http://localhost:3000/).

## Contributors

- [@jerwintuchi](https://github.com/jerwintuchi)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
