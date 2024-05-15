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

## Importing from Chainlink

To import dependencies from Chainlink for use in our Contract, we use this command
```
forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit
```

Next, we go to our `foundry.toml` file and use `remappings` to redirect our imports to the location of the relevant file imports on our local machine. This is because sometimes, when we download dependencies on our local machine, the file path may vary from what the github repo is. We remap in `foundry.toml` using the following command
```
remappings = ["@chainlink/contracts/src/v0.8/vrf=lib/chainlink-brownie-contracts/contracts/src/v0.8"]
```

## Link Tokens for Chainlink Subscription
The `LinkToken.sol` file in `test/mocks` directory was created to enable us fund our subscription. Use the following command to download dependency files for the `LinkToken.sol`
```bash
forge install transmissions11/solmate --no-commit
```

We then edit `remappings` in our `foundry.toml` file to enable us pick the dependency on our local machine without changing the file path on our `LinkToken.sol` file. Our `remappings` now become

```
remappings = ["@chainlink/contracts/src/v0.8/vrf=lib/chainlink-brownie-contracts/contracts/src/v0.8", "@solmate=lib/solmate/src"]
```

## Install Foundry DevOps

The foundry devOps repo enables us to get the most recent deployment from a given environment in foundry. This way, we can do scripting off previous deployments in solidity.
```bash
forge install Cyfrin/foundry-devops --no-commit
```
Update your `foundry.toml` to have read permissions on the broadcast folder.
```
fs_permissions = [{ access = "read", path = "./broadcast" }]
```

## Tests in Foundry
To run a test in foundry, navigate to the root directory of the project and run the following command
```bash
forge test
```
The above command will search for any files in the directory with a `.t.sol` extension and further search for any functions in such files whose names begin with `test` and execute them.

To run a specific test, run the following command instead
```bash
forge test --match-test <name-of-test>
```

To see the test coverage so far, run the following command
```bash
forge coverage
```



Tasks Carried Out:
Note that the test script is `SocialMediaTest.t.sol`
1. Modified the `createPost` function to allow only registered users create a post.
2. Wrote a test `testUserCantCreatePostIfNotRegistered` to certify that a user can not create post if not registered. The test reverts as expected - test passed.
3. Created a mapping `s_userAddressToPostId` which maps every post to the author of that post. 
4. Wrote a test `testRegisteredUserCanCreatePost` to certify that a registered user can create post. The test passed.
5. Wrote a test `testRegisteredUserCanCreatePost` to certify that a registered user can create post. The test passed.
6. Improve test coverage from 33% to 49%. Target is for test coverage to be at least 90%


Tasks Carried Out:
Note that the test script is `SocialMediaTest.t.sol`
1. Introduced the `receive` function in the Smart Contract. This is to enable Smart Contract receive payment from users who want to edit or delete their posts. This feature is introduced to reduce misuse of platform from users.
2. Introduced the Chainlink Price Feed. This is useful so that for instance, if we peg the fee for deleting of posts as USD5, the Chainlink price feed will enable us know the required amount of ETH or any other asset that is worth 5 dollars using the current price.
3. Installed the `chainlink-brownie-contracts` to enable us use the chainlink price feed.
4. Added a `remappings` section in our `foundry.toml` file to ensure our contract can read the dependency files download to our project repository from chainlink-brownie-contracts.
5. Wrote a test `testCantEditPostIfNotTheOwner` to certify that a user can not edit a post if he is not the author. The test passed.
6. Wrote a test `testOwnerCantEditPostWithoutPaying` to certify that a user can not edit their post if they don't pay the required amount. The test passed.
7. Wrote a test `testOwnerCanEditPostAfterPaying` to certify that a user can edit their post if they pay the required amount. The test passed.
8. Wrote a test `testEventEmitsWhenPostIsEdited` to certify that an event will be emited whenever user edits their post. The test passed.


Tasks Carried Out:
Note that the test script is `SocialMediaTest.t.sol`
1. Wrote a test `testContractReceivesPayment` to certify that the Contract actually receives payment from users. The test passed.
2. Modified the `deletePost` function to actually delete post. In addition, users have to pay to delete any post.
3. Wrote a test `testCantDeletePostIfNotTheOwner` to certify that a user can not delete a post if he is not the author. The test passed.
4. Wrote a test `testOwnerCantDeletePostWithoutPaying` to certify that a user can not delete their post if they don't pay the required amount. The test passed.
5. Wrote a test `testOwnerCanDeletePostAfterPaying` to certify that a user can delete their post if they pay the required amount. The test passed.


Tasks Carried Out:
Note that the test script is `SocialMediaTest.t.sol`
1. Modified the `notOwner` modifier to check if `msg.sender` is the caller of a function by using the `s_postIdToAuthor` mapping to get the address of the author of any post using the postId.
2. Wrote a test `testUserCantUpvotePostIfTheyAreTheOwner` to certify that a user cannot cast an upvote to any post for which they are the author. The test reverted as expected - test passed.
3. Modified the `upvote` function so that it increases the number of upvotes by 1 whenever it is called.
4. Wrote a test `testUserCanUpvotePostIfTheyAreNotTheOwner` to certify that a user can cast an upvote to any post for which they are not the author. The test passed.
5. Wrote a test `testUserCantUpvoteSamePostMoreThanOnce` to certify that a user cannot cast more than one upvote to any post. The test reverted as expected - test passed.
6. Wrote a test `testUserCanUpvoteMultiplePostsIfTheyAreNotTheOwner` to certify that a user cannot cast one upvote to multiple posts. The test passed.
7. Modified the `Upvoted` and `Downvoted` events to emit names of voters rather than addresses
8. Wrote a test `testEmitsEventWhenPostGetsAnUpvote` to certify that an event is emitted whenever a post gets an upvote. The test passed.




Tasks Carried Out:
Note that the test script is `SocialMediaTest.t.sol`
1. Wrote a test `testUserCantDownvotePostIfTheyAreTheOwner` to certify that a user cannot cast a downvote to any post for which they are the author. The test reverted as expected - test passed.
2. Modified the `downvote` function so that it increases the number of downvotes by 1 whenever it is called.
3. Wrote a test `testUserCanDownvotePostIfTheyAreNotTheOwner` to certify that a user can cast a downvote to any post for which they are not the author. The test passed.
4. Wrote a test `testUserCantDownvoteSamePostMoreThanOnce` to certify that a user cannot cast more than one downvote to any post. The test reverted as expected - test passed.
5. Wrote a test `testUserCanDownvoteMultiplePostsIfTheyAreNotTheOwner` to certify that a user can cast one downvote to each of multiple posts. The test passed.
6. Wrote a test `testEmitsEventWhenPostGetsAnUpvote` to certify that an event is emitted whenever a post gets an upvote. The test passed.
7. Wrote a test `testUserCantUpvoteAndDownvoteSamePost` to certify that a user cannot cast an upvote and also cast a downvote on the same post. The test reverted as expected - test passed.
8. Wrote a test `testUserCantDownvoteAndUpvoteSamePost` to certify that a user cannot cast a downvote and also cast an upvote on the same post. The test reverted as expected - test passed.
9. Test coverage improved from 63% to 75%


Tasks Carried Out:
Note that the test script is `SocialMediaTest.t.sol`
1. Modified the `createComment` function. The comment id is now made to be unique only within a comment but in general, comment id's are not unique. They are tied to post ids. We think that if comment id's are made unique as well, we may likely encounter overflows.
3. Wrote a test `testUserCantCreateCommentIfNotRegistered` to certify that only a registered user can comment on a post. The test reverted as expected - test passed.
4. Wrote a test `testRegisteredUserCanCreateComment` to certify that a registered user can comment on a post. The test passed.
5. Wrote a test `testEventEmitsWhenCommentIsCreated` to certify that an event emits any time a comment is created. The test passed.
6. Test coverage improved from 75% to 84%



Tasks Carried Out:
Note that the test script is `SocialMediaTest.t.sol`
1. Modified the `editComment` function which now takes `postId` and `commentId` as arguments. 
2. Wrote a test `testCantEditCommenttIfNotTheOwner` to certify that a user cannot edit a comment for which they are not the author. The test reverted as expected - test passed.
3. Wrote a test `testOwnerCantEditCommentWithoutPaying` to certify that a user cannot edit their comment without paying. The test reverted as expected - test passed.
4. Wrote a test `testOwnerCanEditCommentAfterPaying` to certify that a user can edit their comment if they are paying for it. The test passed.
5. Test coverage improved from 84% to 87%