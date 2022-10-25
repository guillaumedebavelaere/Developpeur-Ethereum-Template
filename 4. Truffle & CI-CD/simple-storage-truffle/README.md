
#Compile the code

`truffle compile`

# Deploy the code

`truffle deploy --network goerli`

# Compile + deploy the code

`truffle migrate --network goerli`

# To recompile

`truffle migrate --reset --network goerli`


# Truffle console
`truffle console`

## Dans la console:
var instance = await SimpleStorage.deployed() // recuperer une instance du contrat
await instance.get()

# Truffle dashboard pour se connecter avec metamask
`truffle dashboard`
`truffle migrate --network dashboard`

# eth95 pour interface graphique
https://github.com/adrianmcli/eth95

# install open zeppelin
`npm install -prefix . @openzeppelin/contracts`

# Truffle test
`truffle test test/TestSimpleStorage.sol --network develop`

# helpers pour les tests en js
```js
const { BN, expectRevert, expectEvent } = require('@openzeppelin/test-helpers');
const { expect } = require('chai');
const constants = require('@openzeppelin/test-helpers/src/constants');
```