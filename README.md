## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```


Tasks Carried Out:
Note that the test script is `SocialMediaTest.t.sol`
1. Modified the `createPost` function to allow only registered users create a post.
2. Wrote a test `testUserCantCreatePostIfNotRegistered` to certify that a user can not create post if not registered. The test reverts as expected - test passed.
3. Created a mapping `s_userAddressToPostId` which maps every post to the author of that post. 
4. Wrote a test `testRegisteredUserCanCreatePost` to certify that a registered user can create post. The test passed.
5. Wrote a test `testRegisteredUserCanCreatePost` to certify that a registered user can create post. The test passed.
6. Improve test coverage from 33% to 49%. Target is for test coverage to be at least 90%