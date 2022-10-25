### Type script + truffle

#### Install
```
npm install truffle typescript ts-node typechain @typechain/truffle-v5 --save-dev
npm install @types/node @types/mocha @types/chai --save-dev
```

#### truffle-config.js
```js
require("ts-node").register({
  files: true,
});
```

#### Générer vos fichier de types (.d.ts):
yarn compile

### Exemple fichier de test
Créer un fichier Voting.spec.ts dans votre répertoire test:

```js
import { VotingInstance } from "../types/Voting";

const Voting = artifacts.require('Voting');

contract('Voting', (accounts) => {

    const administrator = accounts[0];
    const account1 = accounts[1];

    let votingInstance: VotingInstance;
    
    describe('> Write your tests', () => {
        beforeEach(async () => {
            votingInstance = await Voting.new({ from: administrator });
        });

        it('test', () => {
          // TODO
        });
    });
});
```

#### Config ts

Créer un fichier tsconfig.json à la racine de votre projet:

```json
{
    "compilerOptions": {
      "lib": ["ES2018"],
      "module": "CommonJS",
      "target": "ES2018",
      "strict": true,
      "noImplicitAny": false,
      "esModuleInterop": true,
      "types": ["@types/node", "@types/chai", "@types/mocha"],
      "typeRoots": ["../node_modules/@types", "./types"]
    },
    "include": ["**/*.ts"],
    "exclude": ["node_modules", "build", "cache", "artifacts"]
  }
```
