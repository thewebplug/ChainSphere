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


Tasks Carried Out
1. Removed the Post array from the User struct because I find it difficult to add user post to the array whenever the user creates a new post
2. Created varable that maps a user address to an array of posts, called `userPosts`. This variable makes it possible to track all posts by a user. This way, any time a user creates a new post, the new post is pushed to the array of posts i.e. `userPosts[msg.sender].push(newPost)`.
3. Updated the `getUserPosts` function to return all posts by the user.
4. Removed the Comment array from the Post struct because I find it difficult to add user comment to the array whenever a user comments on a post
5. Created varable that maps the address of the author of a post and the postId to an array of comments, called `postComments`. This variable makes it possible to track all comments on a post. This way, any time a comment is added to a post, the new comment is pushed to the array of comments i.e. `postComments[_postAuthor][_postId].push(newPost)`.
6. Created varable that maps the address of a user to an array of comments, called `userComments`. This variable makes it possible to track all comments by a user.
7. Updated the `getUserComments` function to return all comments by the user.