# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```


# Install HardHat
`npm init -y`
`npm install -D hardhat`
### configure hardhat
`npx hardhat`

### lancer hardat node local
`npx hardhat node`

### Compiler
`npx hardhat compile`

### Lancer script deploy
`npx hardhat --network localhost run scripts/deploy.js`

### shortcut hh
`npm install --global hardhat-shorthand`

### Lancer la console
`npx hardhat --network localhost console`

### Attacher contrat dans la console
`const greeter = await Greeter.attach("0xe7f1725e7734ce288f8367e1bb143e90bb3f0512");`

### Tasks
https://ethereum.stackexchange.com/questions/83656/where-does-the-line-blur-between-a-task-and-a-script-in-hardhat/93433#93433

### Type script and openseppelin test-helpers

`npm install --prefix . --save-dev @openzeppelin/test-helpers`
`npm install --prefix . --save-dev @nomiclabs/hardhat-web3 web3`

```
add this to your hardhat.config.ts:

import "@nomiclabs/hardhat-web3";

```

