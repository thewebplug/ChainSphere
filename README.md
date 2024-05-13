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
1. Created a modifier in the test file called `registerOneUser`. This is to make the code for testing modular and to avoid unnecessary repetition.
2. Wrote a function `testUserCantRegisterIfUsernameAlreadyExists` in the test file to test the assertion that a user can not register if the username already exists. The test reverts as expected - Test passes.
3. Wrote a function `testEmitsEventAfterUserRegistration` in the test file to test the assertion that the `UserRegistered` event will be emited after a user is registered successfully. The Test passes.
4. Wrote a function `testCantChangeUsernameIfUserDoesNotExist` in the test file to test the assertion that a user cannot change username if user does not exist. The Test passes.
5. Made some changes to the `changerUsername` function in the Smart Contract so that user information is accessed using userId and hereafter, change the username to a new name.
6. Wrote a function `testCanChangeUsernameWhereAllConditionsAreMet` in the test file to test the assertion that a user can change their username if all conditions are satisfied. The Test passes.
7. Added a snapshot of test coverage so far.
