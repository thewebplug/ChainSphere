// Layout of Contract:
// version
// imports
// interfaces, libraries, contracts
// errors
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// internal & private view & pure functions
// external & public view & pure functions

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { PriceConverter } from "./PriceConverter.sol";
import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// import {VRFv2Consumer} from "./VRFv2Consumer.sol";

// import {AutomationCompatible} from "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";


contract SocialMedia {
    using PriceConverter for uint256;
    // VRFv2Consumer public vrfConsumer;


    //////////////
    /// Errors ///
    //////////////
    error SocialMedia__NotOwner();
    error SocialMedia__NotPostOwner();
    error SocialMedia__NotCommentOwner();
    error SocialMedia__UsernameAlreadyTaken();
    error SocialMedia__UserDoesNotExist();
    error SocialMedia__OwnerCannotVote();
    error SocialMedia__AlreadyVoted(); 
    error SocialMedia__PaymentNotEnough();
    
    ///////////////////////////////////
    /// Type Declarations (Structs) ///
    ///////////////////////////////////
    struct User {
        uint256 id;
        address userAddress;
        string name;
        string bio;
        string profileImageHash;
        // Post[] userPosts;
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
    
    ///////////////////////
    /// State Variables ///
    ///////////////////////


    /* For gas efficiency, we declare variables as private and define getter functions for them where necessary */

    // Imported Variables
    AggregatorV3Interface private s_priceFeed;

    // Constants
    uint256 private constant MINIMUM_USD = 5e18;
    uint256 private constant MIN_POST_SCORE = 10;
    uint256 private constant VALIDITY_PERIOD = 30 days; // Period for which a post can be adjudged eligible for reward based on its postScore


    // Mappings

    /** Variables Relating to User */
    User[] s_users; // array of users
    mapping(address userAddress => User) private s_addressToUserProfile;
    uint256 userId;
    mapping(address userAddress => uint256 userId) private s_userAddressToId; // gets userId using address of user


    /** Variables Relating to Post */
    Post[] s_posts; // array of all posts
    Post[] s_recentPosts; // array of posts that are not more than VALIDITY_PERIOD old. This array is reset anytime authors have been picked for reward.
    mapping(uint256 postId => Post) private s_idToPost; // get full details of a post using the postId
    
    mapping(address author => uint256 postId) private s_authorToPostId; // Get postId using address of the author 
    mapping(uint256 postId => address author) private s_postIdToAuthor; // Get the address of the author of a post using the postId
    
    mapping(string name => address userAddress) private s_usernameToAddress; // get user address using their name
    mapping(address user => mapping(uint256 postId => bool voteStatus)) private s_hasVoted; //Checks if a user has voted for a post or not
    mapping(address user => Post[]) private userPosts; // gets all posts by a user using the user address
    

    /** Variables Relating to Comment */

    mapping(uint256 postId => Comment[]) private s_postIdToComments; // gets array of comments on a post using the postId
    mapping(uint256 postId => mapping(uint256 commentId => address commenterAddress)) private s_postAndCommentIdToAddress; // gets comment author using the postId and commentId

    mapping(address user => Comment[]) private userComments; // gets an array of comments by a user using user address
    mapping(uint256 postId => mapping(uint256 commentId => mapping(address commenterAddress => bool likeStatus))) private s_likedComment; // indicates whether a comment is liked by a user using postId and commentId and userAddress
    mapping(uint256 postId => mapping(uint256 commentId => address[])) private s_likersOfComment; // gets an array of likers of a comment using the postId and commentId
        
    /** Other Variables */

    address private s_owner; // would have made this variable immutable but for the changes_Owner function in the contract
    address[] private s_authorsEligibleForReward; // An array of users eligible for rewards
    mapping(address author => bool status) private s_authorEligibilityStatus; // variable that indicates whether or not the author of a post is eligible for a reward
    mapping(uint256 postId => bool status) private  s_postMarkedAsEligibleForReward; // indicate that a post already qualifies author for reward and as such, author should not be qualified multiple times on the basis of one same post
    
    //////////////
    /// Events ///
    //////////////

    event UserRegistered(uint256 indexed id, address indexed userAddress, string indexed name);
    event PostCreated(uint256 postId, string authorName);
    event PostEdited(uint256 postId, string authorName);
    event CommentCreated(uint256 indexed commentId, string postAuthor, string commentAuthor, uint256 postId);
    event PostLiked(uint256 indexed postId, address indexed postAuthor, address indexed liker);
    event Upvoted(uint256 postId, string posthAuthorName, string upvoterName);
    event Downvoted(uint256 postId, string posthAuthorName, string downvoterName);
    // Event for rewarding users
    event RewardSent(address indexed user, uint256 amount);
    
    /////////////////
    /// Modifiers ///
    /////////////////
    modifier onlyOwner() {
        if(msg.sender != s_owner){
            revert SocialMedia__NotOwner();
        }
        _;
    }
    
    modifier onlyPostOwner(uint _postId) {
        if(msg.sender !=  s_postIdToAuthor[_postId]){
            revert SocialMedia__NotPostOwner();
        }
        _;
    }
    
    modifier onlyCommentOwner(uint256 _postId, uint256 _commentId) {
        if(msg.sender != s_postAndCommentIdToAddress[_postId][_commentId]){
            revert SocialMedia__NotCommentOwner();
        }
        _;
    }
    
    modifier usernameTaken(string memory _name) {
        if(s_usernameToAddress[_name] != address(0)){
            revert SocialMedia__UsernameAlreadyTaken();
        }
        _;
    }
    
    modifier checkUserExists(address _userAddress) {
        if(s_addressToUserProfile[_userAddress].userAddress == address(0)){
            revert SocialMedia__UserDoesNotExist();
        }
        _;
    }
    
    modifier notOwner(uint256 _postId) {
        if(msg.sender == s_postIdToAuthor[_postId]){
            revert SocialMedia__OwnerCannotVote();
        }
        _;
    }

    modifier hasNotVoted(uint256 _postId) {
        if(s_hasVoted[msg.sender][_postId]){
           revert SocialMedia__AlreadyVoted(); 
        }
        _;
    }
    
    modifier hasPaid() {
        if(msg.value.getConversionRate(s_priceFeed) < MINIMUM_USD){
            revert SocialMedia__PaymentNotEnough();
        }
        _;
    }

    modifier isValid(uint256 _postId) {
        uint256 presentTime = block.timestamp;
        uint256 postTime = getPostById(_postId).timestamp;
        if(presentTime - postTime >= VALIDITY_PERIOD){
            revert();
        }
        _;
    }

    ///////////////////
    /// Constructor ///
    ///////////////////
    constructor(address priceFeed) {
        s_owner = msg.sender;

        s_priceFeed = AggregatorV3Interface(priceFeed);
    }
    
    /////////////////
    /// Functions ///
    /////////////////

    // The receive function
    /**
    * @dev this function enables the Smart Contract to receive payment
     */
    receive() external payable {}

    function registerUser(string memory _name, string memory _bio, string memory _profileImageHash) public usernameTaken(_name) {
        uint256 id = userId++;
        // For now, this is the way to create a post with empty comments
        User memory newUser;

        newUser.id = id;
        newUser.userAddress = msg.sender;
        newUser.name = _name;
        newUser.bio = _bio;
        newUser.profileImageHash = _profileImageHash;
        s_addressToUserProfile[msg.sender]=newUser;
        s_userAddressToId[msg.sender] = id;

        s_usernameToAddress[_name] = msg.sender;

        // Add user to list of users
        s_users.push(newUser);
        emit UserRegistered(id, msg.sender, _name);
    }
    
    function changeUsername(string memory _newName) public checkUserExists(msg.sender) usernameTaken(_newName) {
        
        // get userId using the user address
        uint256 currentUserId = s_userAddressToId[msg.sender];
        // change user name using their id
        s_users[currentUserId].name = _newName;
    }
    
    /**
    * only a registered user can create posts on the platform
     */
    function createPost(string memory _content, string memory _imgHash) public checkUserExists(msg.sender) {
        // generate id's for posts in a serial manner
        uint256 postId = s_posts.length;
        
        // Initialize an instance of a post for the user
        Post memory newPost = Post({
            postId: postId,
            content: _content,
            imgHash: _imgHash,
            timestamp: block.timestamp,
            upvotes: 0,
            downvotes: 0,
            author: msg.sender
        });

        string memory nameOfUser = getUserNameFromAddress(msg.sender);
        
        userPosts[msg.sender].push(newPost); // Add the post to userPosts
        s_posts.push(newPost); // Add the post to the array of posts
        s_recentPosts.push(newPost); // Add the post to the array of recent posts for possible nomination for reward
        s_authorToPostId[msg.sender] = postId; // map post to the author
        s_postIdToAuthor[postId] = msg.sender;
        emit PostCreated(postId, nameOfUser);
    }
    
    /**
    * @dev A user should pay to edit post. The rationale is, to ensure users go through their content before posting since editing of content is not free
    * @notice To effect the payment functionality, we include a receive function to enable the smart contract receive ether. Also, we use Chainlink pricefeed to ensure ether is amount has the required usd equivalent
     */
    function editPost(uint _postId, string memory _content, string memory _imgHash) public payable onlyPostOwner(_postId) hasPaid {
        
        s_posts[_postId].content = _content;
        s_posts[_postId].imgHash = _imgHash;
        string memory nameOfUser = getUserNameFromAddress(msg.sender);
        emit PostEdited(_postId, nameOfUser);
    }
    
    function deletePost(uint _postId) public payable onlyPostOwner(_postId) hasPaid {
        // delete the content of post by 
        s_posts[_postId].content = "";
        s_posts[_postId].author = address(0);
    }
    
    function upvote(uint _postId) public notOwner(_postId) hasNotVoted(_postId) {
        s_posts[_postId].upvotes++;
        s_hasVoted[msg.sender][_postId] = true;
        // s_voters.push(msg.sender);
        address postAuthAddress = s_postIdToAuthor[_postId];
        string memory postAuthorName = getUserNameFromAddress(postAuthAddress);
        string memory upvoter = getUserNameFromAddress(msg.sender);
        
        
        emit Upvoted(_postId, postAuthorName, upvoter);
    }
    
    function downvote(uint _postId) public notOwner(_postId) hasNotVoted(_postId) {
        s_posts[_postId].downvotes++;
        s_hasVoted[msg.sender][_postId] = true;
        // s_voters.push(msg.sender);
        address postAuthAddress = s_postIdToAuthor[_postId];
        string memory postAuthorName = getUserNameFromAddress(postAuthAddress);
        string memory downvoterName = getUserNameFromAddress(msg.sender);
        
        emit Downvoted(_postId, postAuthorName, downvoterName);
        
    }
    
    /**
    * @dev createComment enables registered users to comment on any post
    * @notice Since the postId is unique and can be mapped to author of the post, we only need the postId to uniquely reference any post in order to comment on it
    * Because in any social media platform there are so much more comments than posts, we allow the commentId not to be unique in general. However, comment ids are unique relative to any given post. Our thought is that this will prevent overflow
     */
    function createComment(uint _postId, string memory _content) public checkUserExists(msg.sender) {
        //
        uint256 commentId = s_postIdToComments[_postId].length;
        
        Comment memory newComment = Comment({
            commentId: commentId,
            author: msg.sender,
            postId: _postId,
            content: _content,
            timestamp: block.timestamp,
            likesCount: 0
        });
        // s_comments[commentId] = Comment(commentId, msg.sender, _postId, _content, block.timestamp, 0);
        string memory postAuthor = getUserById(_postId).name;
        string memory commenter = getUserNameFromAddress(msg.sender);

        s_postAndCommentIdToAddress[_postId][commentId] = msg.sender;
        s_postIdToComments[_postId].push(newComment);

        emit CommentCreated(commentId, postAuthor, commenter, _postId);
    }
    
    /**
    * @dev only the user who created a comment should be able to edit it. Also, a user should pay to edit their post
     */
    function editComment(uint256 _postId, uint256 _commentId, string memory _content) public payable onlyCommentOwner(_postId, _commentId) hasPaid {
        // get the comment from the Blockchain (call by reference) and update it
        s_postIdToComments[_postId][_commentId].content = _content;
        
    }
    
    /**
    * @dev only the user who created a comment should be able to delete it. Also, a user should pay to delete their post
     */
    function deleteComment(uint256 _postId, uint256 _commentId) public payable onlyCommentOwner(_postId, _commentId) hasPaid {
        // get the comment from the Blockchain (call by reference) and update it
        s_postIdToComments[_postId][_commentId].content = ""; // delete content
        s_postIdToComments[_postId][_commentId].author = address(0); // delete address of comment author
    }
    
    function likeComment(uint256 _postId, uint256 _commentId) public checkUserExists(msg.sender){
        // retrieve the comment from the Blockchain in increment number of likes 
        s_postIdToComments[_postId][_commentId].likesCount++;
        // There is need to note the users that like a comment
        s_likedComment[_postId][_commentId][msg.sender] = true;
        // Add liker to an array of users that liked the comment
        s_likersOfComment[_postId][_commentId].push(msg.sender);
        
    }


    ///////////////////////
    // Private Functions //
    ///////////////////////

    /**
    * @dev This function checks the the number of upvotes and number of downvotes of a post, calculates their difference to tell if the author of the post is eligible for rewards in that period.
    * @notice A user can be adjudged eligible on multiple grounds if they have multiple posts with significantly more number of upvotes than downvotes
     */
    function _isPostEligibleForReward(uint256 _postId) private view isValid(_postId) returns(bool isEligible) {
        uint256 numOfUpvotes = getPostById(_postId).upvotes; // get number of upvotes of post
        uint256 numOfDownvotes = getPostById(_postId).downvotes; // get number of downvotes of post
        uint256 postScore = numOfUpvotes - numOfDownvotes > 0 ? numOfUpvotes - numOfDownvotes : 0; // set minimum postScore to zero. We dont want negative values
        if(postScore > MIN_POST_SCORE){
            isEligible = true; // a post is adjudged eligible for reward if the post has ten (10) more upvotes than downvotes
        }
    }

    /**
    * @dev This function is to be called automatically using Chainlink Automation every VALIDITY_PERIOD (i.e. 30 days or as desirable). The function loops through an array of recentPosts and checks if posts are eligible for rewards and add the corresponding authors to an array of eligible authors for reward
     */
    function _pickEligibleAuthors() private {
        uint256 len = s_recentPosts.length; // number of recent posts
        uint256 i; // define the counter variable

        /** Loop through the array and pick posts that are eligible for reward */
        for(i; i < len; ){
            // Check if author is eligible for rewards and add their address to the array of eligible users

            if(_isPostEligibleForReward(s_recentPosts[i].postId)){
                uint256 postId = s_recentPosts[i].postId;
                address postAuthAddress = s_postIdToAuthor[postId]; // get address of author
                s_authorsEligibleForReward.push(postAuthAddress); // add address of author to list of authors eligible for reward
            }

            unchecked {
                i++;
            }
        }
    }

    //////////////////////
    // Getter Functions //
    //////////////////////    
    function getUser(address _userAddress) public view returns(User memory) {
        return s_addressToUserProfile[_userAddress];
    }

    function getUserPosts(address _userAddress) public view returns(Post[] memory) {
        // Implementation to retrieve all posts by a user
        return userPosts[_userAddress];

    }

    function getUserById(uint256 _userId) public view returns(User memory) {
        return s_users[_userId];
    }

    function getPostById(uint256 _postId) public view returns(Post memory) {
        return s_posts[_postId];
    }

    function getCommentByPostIdAndCommentId(uint256 _postId, uint256 _commentId) public view returns(Comment memory) {
        return s_postIdToComments[_postId][_commentId];
    }

    function getCommentLikersByPostIdAndCommentId(uint256 _postId, uint256 _commentId) public view returns(address[] memory) {
        return s_likersOfComment[_postId][_commentId];
    }


    function getUserComments(address _userAddress) public view returns(Comment[] memory) {
        // Implementation to retrieve all comments by a user
        return userComments[_userAddress];
    }
    
    function getUserNameFromAddress(address _userAddress) public view returns(string memory nameOfUser) {
        User memory user = s_addressToUserProfile[_userAddress];
        nameOfUser = user.name;
    }
    // Owner functions
    function getBalance() public view onlyOwner returns(uint) {
        return address(this).balance;
    }
    
    function getContractOwner() public view returns(address){
        return s_owner;
    }

    function transferContractBalance(address payable _to) public onlyOwner {
        _to.transfer(address(this).balance);
    }

    
    function changeOwner(address _newOwner) public onlyOwner {
        s_owner = _newOwner;
    }
    
    

}
