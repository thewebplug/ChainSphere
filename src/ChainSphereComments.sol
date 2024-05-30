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

/// @dev Implements Chainlink VRFv2, Automation and Price Feed

import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
// import {VRFConsumerBaseV2} from "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
// import {PriceConverter} from "./PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import { ChainSpherePosts as CSPosts}  from "./ChainSpherePosts.sol";

contract ChainSphereComments is CSPosts {
    

    //////////////
    /// Errors ///
    //////////////
    
    error ChainSphere__NotCommentOwner();
    

    ///////////////////////////////////
    /// Type Declarations (Structs) ///
    ///////////////////////////////////

    
    /**
    * @dev the comment struct uniquely saves all the relevant information about a comment
    * @param commentId is the id of the comment. The commentId is only unique with respect to each post. This number is generated serially as each comment is created on a post
    * @param author is the address of the user who commented on the post. This is useful to track for issuing of rewards for authors whose posts are adjuged as eligible for rewards.
    * @param postId is the id of the post. The postId is unique and is used to uniquely identify a post. This number is generated serially as each post is created
    * @param content is the content of the comment
    * @param timestamp is the time the comment was created.
    * @param likesCount is the number of likes acrued by the comment. This indicates how useful other users perceive the comment to be. 
     */
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

    // Mappings

    /** Variables Relating to Comment */

    mapping(uint256 postId => Comment[]) private s_postIdToComments; // gets array of comments on a post using the postId
    mapping(uint256 postId => mapping(uint256 commentId => address))
        private s_postAndCommentIdToAddress; // gets comment author using the postId and commentId

    mapping(address => Comment[]) private userComments; // gets an array of comments by a user using user address
    mapping(uint256 commentId => mapping(address commenter => bool))
        private s_likedComment; // indicates whether a comment is liked by a user using postId and commentId and userAddress
    mapping(uint256 commentId => address[]) private s_likersOfComment; // gets an array of likers of a comment using the postId and commentId
    Comment[] private s_comments;
    mapping(uint256 postId => uint256[] commentsId) private s_postIdToCommentsId; // gets array of comment ids on a post using the postId

    //////////////
    /// Events ///
    //////////////

    event CommentCreated(
        uint256 indexed commentId,
        string postAuthor,
        string commentAuthor,
        uint256 postId
    );
    
    /////////////////
    /// Modifiers ///
    /////////////////

    modifier _onlyCommentOwner(/*uint256 _postId,*/ uint256 _commentId) {
        if (msg.sender != _getCommentByCommentId(_commentId).author) {
            revert ChainSphere__NotCommentOwner();
        }
        _;
    }

    modifier _postExists(uint256 _postId) {
        if(_getPostById(_postId).author == address(0) || _postId >= _getAllPosts().length){
            revert ChainSphere__PostDoesNotExist();
        }
        _;
    }


    constructor(
        address priceFeed,
        uint256 interval,
        address vrfCoordinator,
        bytes32 gasLane,
        uint256 subscriptionId,
        uint32 callbackGasLimit
    ) CSPosts(
        priceFeed, interval, vrfCoordinator, gasLane, subscriptionId, callbackGasLimit
    ){}
    
    /////////////////
    /// Functions ///
    /////////////////

    
    /**
     * @dev createComment enables registered users to comment on any post
     * @notice Since the postId is unique and can be mapped to author of the post, we only need the postId to uniquely reference any post in order to comment on it
     * Because in any social media platform there are so much more comments than posts, we allow the commentId not to be unique in general. However, comment ids are unique relative to any given post. Our thought is that this will prevent overflow
     */
    function _createComment(uint256 _postId, string memory _content)
        internal
        _checkUserExists(msg.sender) _postExists(_postId)
    {
        
        // uint256 _commentId = s_postIdToComments[_postId].length;
        uint256 _commentId = s_comments.length;

        Comment memory newComment = Comment({
            commentId: _commentId,
            author: msg.sender,
            postId: _postId,
            content: _content,
            timestamp: block.timestamp,
            likesCount: 0
        });
        
        string memory postAuthor = _getUserById(_postId).nickName;
        string memory commenter = _getUserNameFromAddress(msg.sender);

        s_postAndCommentIdToAddress[_postId][_commentId] = msg.sender;
        // s_postIdToComments[_postId].push(newComment);
        s_postIdToCommentsId[_postId].push(_commentId);
        s_comments.push(newComment);

        emit CommentCreated(_commentId, postAuthor, commenter, _postId);
    }

    /**
     * @dev This function allows only the user who created a comment to edit it.
     * @param _commentId is the id of the comment of interest
     * @param _content is the new content of the comment
     */
    function _editComment(
        uint256 _commentId,
        string memory _content
    ) internal _onlyCommentOwner(_commentId) {
        // get the comment from the Blockchain (call by reference) and update it
        // s_postIdToComments[_postId][_commentId].content = _content;
        s_comments[_commentId].content = _content;
    }

    /**
     * @dev This function allows only the user who created a comment to delete it. 
     * @param _commentId is the id of the comment of interest
     * @notice the function checks if the caller is the owner of the comment and has paid the fee for deleting comment
     */
    function _deleteComment(uint256 _commentId) internal _onlyCommentOwner(_commentId) {
        // get the comment from the Blockchain (call by reference) and update it
        // s_postIdToComments[_postId][_commentId].content = ""; // delete content
        // s_postIdToComments[_postId][_commentId].author = address(0); // delete address of comment author
        s_comments[_commentId].content = ""; // delete content
        s_comments[_commentId].author = address(0); // delete address of comment author
    }

    /**
    * @dev this function allows a registered user to like any comment
    * @param _commentId is the id of the comment in question
    * @notice the function increments the number of likes on the comment by 1 and adds user to an array of likers
     */
    function _likeComment(uint256 _commentId)
        internal
        _checkUserExists(msg.sender)
    {
        if(s_likedComment[_commentId][msg.sender] == false){
            // There is need to note the users that like a comment
            s_likedComment[_commentId][msg.sender] = true;
            // retrieve the comment from the Blockchain in increment number of likes
            s_comments[_commentId].likesCount++;
            // Add liker to an array of users that liked the comment
            s_likersOfComment[_commentId].push(msg.sender);
        }
        
    }

    
    //////////////////////
    // Getter Functions //
    //////////////////////

    
    
    /**
    * @dev function retrieves all information about a comment on a post given the postId and the commentId
    * @param _commentId is the id of the comment. 
    * @return function returns the comment corresponding to that postId and commentId
     */
    function _getCommentByCommentId(uint256 _commentId)
        internal
        view
        returns (Comment memory)
    {
        return s_comments[_commentId];
    }

    /**
    * @dev function retrieves all users that liked a comment on a post given the postId and the commentId
    * @param _commentId is the id of the comment. 
    * @return function returns an array of userAddresses that liked the  comment
     */
    function _getCommentLikersByCommentId(
        // uint256 _postId,
        uint256 _commentId
    ) internal view returns (address[] memory) {
        return s_likersOfComment[_commentId];
    }

    /**
    * @dev function retrieves all comments by a user given the userAddress
    * @param _userAddress is the wallet address of user
    * @return function returns an arry of all comments by the user
     */
    function _getUserComments(address _userAddress)
        internal
        view
        returns (Comment[] memory)
    {
        // Implementation to retrieve all comments by a user
        return userComments[_userAddress];
    }

    /**
    * @dev function retrieves all comments on a given post
    * @param _postId is the id of the post we want to retrieve its comments
    * @return function returns an arry of all comments on the post
     */
    function _getCommentsByPostId(uint256 _postId) internal returns (Comment[] memory) {
        uint256[] memory commentIds = s_postIdToCommentsId[_postId];
        uint256 len = commentIds.length;
        for(uint256 i; i < len; ){
            s_postIdToComments[_postId].push(
                _getCommentByCommentId(commentIds[i])
            );

            unchecked {
                i++;
            }
        }

        return s_postIdToComments[_postId];
    }

}
