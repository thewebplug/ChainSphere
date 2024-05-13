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

    // create a fake user
    address USER = makeAddr("user");

    // struct instances
    Post post;
    User user;
    Comment comment;

    // Events
    event UserRegistered(uint256 indexed id, address indexed userAddress, string indexed name);

    function setUp() public {
        deployer = new DeploySocialMedia();
        socialMedia = deployer.run();

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


}