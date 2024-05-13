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

    function setUp() public {
        deployer = new DeploySocialMedia();
        socialMedia = deployer.run();

    }

    /////////////////////////////
    // User Registration Tests //
    /////////////////////////////

    /** Test Passes as expected */
    function testUserCanRegister() public {
        string memory myName = "Nengak Goltong";
        string memory myBio = "I love to code";
        string memory myImgHash = "";
        string memory expectedName;
        string memory expectedBio;
        vm.prank(USER);
        socialMedia.registerUser(myName, myBio, myImgHash);
        
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
}