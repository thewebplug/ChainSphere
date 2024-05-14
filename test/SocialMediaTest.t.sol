// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { Test, console} from "forge-std/Test.sol";
import { SocialMedia } from "../src/SocialMedia.sol";
import { DeploySocialMedia } from "../script/DeploySocialMedia.s.sol";

contract SocialMediaTest is Test {
    
    ///////////////////////////////////
    /// Type Declarations (Structs) ///
    ///////////////////////////////////
    struct User {
        uint256 id;
        address userAddress;
        string name;
        string bio;
        string profileImageHash;
    }
    
    struct Post {
        uint256 postId;
        string content;
        string imgHash;
        uint256 timestamp;
        uint256 upvotes;
        uint256 downvotes;
        address author;
    }
    
    struct Comment {
        uint256 commentId;
        address author;
        uint256 postId;
        string content;
        uint256 timestamp;
        uint256 likesCount;
    }

    // Declaring variable types
    SocialMedia socialMedia;
    DeploySocialMedia deployer;

    // Constants
    uint256 private constant STARTING_BALANCE = 10 ether;
    uint256 private constant EDITING_FEE = 0.004 ether;

    // create a fake user
    address USER = makeAddr("user");

    // struct instances
    Post post;
    User user;
    Comment comment;

    // Events
    event UserRegistered(uint256 indexed id, address indexed userAddress, string indexed name);
    event PostCreated(uint256 postId, string authorName);
    event PostEdited(uint256 postId, string authorName);

    function setUp() public {
        deployer = new DeploySocialMedia();
        socialMedia = deployer.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    /////////////////////////////
    // User Registration Tests //
    /////////////////////////////

    /** Modifier */
    // This Modifier is created since this task will be repeated a couple of times
    modifier registerOneUser() {
        string memory myName = "Nengak Goltong";
        string memory myBio = "I love to code";
        string memory myImgHash = "";
        
        vm.prank(USER);
        socialMedia.registerUser(myName, myBio, myImgHash);
        _;
    }

    /** Test Passes as expected */
    function testUserCanRegister() public registerOneUser {
        string memory myName = "Nengak Goltong";
        string memory myBio = "I love to code";
        string memory expectedName;
        string memory expectedBio;
        
        // get name of user from the Blockchain
        expectedName = socialMedia.getUserById(0).name;
        console.log("Registered User Name: %s", expectedName);

        expectedBio = socialMedia.getUserById(0).bio;
        console.log("Registered User Bio: %s", expectedBio);
        assertEq(
            keccak256(abi.encodePacked(myName)), 
            keccak256(abi.encodePacked(expectedName))
        );
        assertEq(
            keccak256(abi.encodePacked(myBio)), 
            keccak256(abi.encodePacked(expectedBio))
        );
    }

    // Test reverts as expected. Test passes
    function testUserCantRegisterIfUsernameAlreadyExists() public registerOneUser{
        string memory myName = "Nengak Goltong";
        string memory myBio = "I love to code in Solidity";
        string memory myImgHash = "";
        
        // The test is expected to revert with `SocialMedia__UsernameAlreadyTaken` message since the username is registered already
        vm.expectRevert(
            SocialMedia.SocialMedia__UsernameAlreadyTaken.selector
        );
        vm.prank(USER);
        socialMedia.registerUser(myName, myBio, myImgHash);
    }

    function testEmitsEventAfterUserRegistration() public {
        string memory myName = "Nengak Goltong";
        string memory myBio = "I love to code in Solidity";
        string memory myImgHash = "";
        
        vm.expectEmit(true, false, false, false, address(socialMedia));
        emit UserRegistered(0, USER, myName);
        vm.prank(USER);
        socialMedia.registerUser(myName, myBio, myImgHash);
    }

    //////////////////////////////
    // Change of Username Tests //
    //////////////////////////////

    modifier registerThreeUsers() {
        string[3] memory names = ["Maritji", "Songrit", "Jane"];
        string memory myBio = "I love to code";
        string memory myImgHash = "";
        
        uint256 len = names.length;
        uint256 i;
        // Register the three users using a for loop
        for(i = 0; i <len; ){
            address newUser = makeAddr(string(names[i])); 
            vm.prank(newUser);
            socialMedia.registerUser(names[i], myBio, myImgHash);
            unchecked {
                i++;
            }
        }
        _;
    }

    function testCantChangeUsernameIfUserDoesNotExist() public registerThreeUsers {
        // Create a random user
        address RAN_USER = makeAddr("ran_user");
        string memory newName = "My New Name";

        // Test is expected to revert since user does not exist on the blockchain
        vm.expectRevert(
            SocialMedia.SocialMedia__UserDoesNotExist.selector
        );
        vm.prank(RAN_USER);
        socialMedia.changeUsername(newName);

    }

    function testCantChangeUsernameToAnExistingUsername() public registerThreeUsers {
        // Create a random user
        address RAN_USER = makeAddr("Maritji");
        string memory newName = "Songrit"; // Note that this name exist already on the Blockchain

        // Test is expected to revert since the new username already exists on the blockchain
        vm.expectRevert(
            SocialMedia.SocialMedia__UsernameAlreadyTaken.selector
        );
        vm.prank(RAN_USER);
        socialMedia.changeUsername(newName);

    }

    function testCanChangeUsernameWhereAllConditionsAreMet() public registerThreeUsers {
        // Create a random user
        address RAN_USER = makeAddr("Maritji");
        string memory newName = "Pauline"; // Note that this name exist already on the Blockchain
        string memory expectedName;

        // Test is expected to pass
        vm.prank(RAN_USER);
        socialMedia.changeUsername(newName);

        // get name of user from the Blockchain
        expectedName = socialMedia.getUserById(0).name;
        console.log("User Name: %s", expectedName);

        assertEq(
            keccak256(abi.encodePacked(newName)), 
            keccak256(abi.encodePacked(expectedName))
        );

    }

    ///////////////////////
    // Create Post Tests //
    ///////////////////////

    // Test Passes as expected
    function testUserCantCreatePostIfNotRegistered() public {
        string memory content = "Come and See";
        string memory imgHash = "";

        // Note that USER has not registered and as such, we expect test to revert
        vm.expectRevert(
            SocialMedia.SocialMedia__UserDoesNotExist.selector
        );
        vm.prank(USER);
        socialMedia.createPost(content, imgHash);
    }

    // Test Passes as expected
    function testRegisteredUserCanCreatePost() public registerOneUser {
        string memory content = "Come and See";
        string memory imgHash = "";

        vm.prank(USER);
        socialMedia.createPost(content, imgHash);
        console.log(socialMedia.getPostById(0).content);
        // retrieve content from the blockchain
        string memory retrievedContent = socialMedia.getPostById(0).content;
        
        assertEq(
            keccak256(abi.encodePacked(retrievedContent)),
            keccak256(abi.encodePacked(content))
        );
    }

    // Test Passes as expected
    function testEventEmitsWhenPostIsCreated() public registerOneUser {
        string memory content = "Come and See";
        string memory imgHash = "";
        string memory myName = socialMedia.getUserNameFromAddress(USER);

        vm.expectEmit(true, false, false, false, address(socialMedia));
        emit PostCreated(0, myName);
        vm.prank(USER);
        socialMedia.createPost(content, imgHash);
        
    }

    /////////////////////
    // Edit Post Tests //
    /////////////////////

    modifier registerThreeUsersAndPost() {
        string[3] memory names = ["Maritji", "Songrit", "Jane"];
        string memory myBio = "I love to code";
        string memory myImgHash = "";
        string memory myContent = "Come and See";
        
        uint256 len = names.length;
        uint256 i;
        // Register the three users using a for loop
        for(i = 0; i <len; ){
            // Create a fake user and assign them a starting balance
            // hoax(address(i), STARTING_BALANCE);
            address newUser = makeAddr(string(names[i])); 
            vm.deal(newUser, STARTING_BALANCE);
            vm.startPrank(newUser);
            // register newUser
            socialMedia.registerUser(names[i], myBio, myImgHash);
            // newUser makes a post
            socialMedia.createPost(myContent, myImgHash);
            vm.stopPrank();
            unchecked {
                i++;
            }
        }
        _;
    }

    // Test reverts as expected - Test passes
    function testCantEditPostIfNotTheOwner() public registerThreeUsersAndPost {
        // Test is expected to revert because we will prank a user to try editing a post of another user

        // Get the address of the author of the first post 
        address firstUser = socialMedia.getPostById(0).author;
        string memory newContent = "Immaculate Heart of Mary";
        string memory imgHash = "";

        vm.expectRevert(
            SocialMedia.SocialMedia__NotPostOwner.selector
        );
        vm.prank(firstUser);
        socialMedia.editPost(1, newContent, imgHash);

    }

    // Test passes
    function testOwnerCantEditPostWithoutPaying() public registerThreeUsersAndPost {
        // Test is expected to revert because a user will try editing their post without making payment

        // Get the address of the author of the first post 
        address firstUser = socialMedia.getPostById(0).author;
        string memory newContent = "Immaculate Heart of Mary";
        string memory imgHash = "";

        vm.expectRevert(
            SocialMedia.SocialMedia__PaymentNotEnough.selector
        );
        vm.prank(firstUser);
        socialMedia.editPost(0, newContent, imgHash);

    }

    // Test passes
    function testOwnerCanEditPostAfterPaying() public registerThreeUsersAndPost {
        // Test is expected to pass because a user will pay for editing their post

        // Get the address of the author of the first post 
        address firstUser = socialMedia.getPostById(0).author;
        string memory newContent = "Immaculate Heart of Mary";
        string memory imgHash = "";

        vm.prank(firstUser);
        socialMedia.editPost{value: EDITING_FEE}(0, newContent, imgHash);
        
        string memory retrievedContent = socialMedia.getPostById(0).content;
        assertEq(
            keccak256(abi.encodePacked(retrievedContent)),
            keccak256(abi.encodePacked(newContent))
        );

    }

    // Test Passes as expected
    function testEventEmitsWhenPostIsEdited() public registerThreeUsersAndPost {
        address firstUser = socialMedia.getPostById(0).author;
        string memory newContent = "Immaculate Heart of Mary";
        string memory imgHash = "";

        vm.prank(firstUser);
        socialMedia.editPost{value: EDITING_FEE}(0, newContent, imgHash);
        
        string memory myName = socialMedia.getUserNameFromAddress(firstUser);

        vm.expectEmit(true, false, false, false, address(socialMedia));
        emit PostEdited(0, myName);
        vm.prank(firstUser);
        socialMedia.editPost{value: EDITING_FEE}(0, newContent, imgHash);
        
    }
}