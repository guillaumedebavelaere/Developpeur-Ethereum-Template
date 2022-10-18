
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