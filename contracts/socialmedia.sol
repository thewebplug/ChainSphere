// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract SocialMedia {
    // Structs
    struct User {
        uint id;
        address userAddress;
        string name;
        string bio;
        string profileImageHash;
    }
    
    struct Post {
        uint postId;
        string content;
        string imgHash;
        uint timestamp;
        uint upvote;
        uint downvote;
        address author;
    }
    
    struct Comment {
        uint commentId;
        address author;
        uint postId;
        string content;
        uint timestamp;
        uint likeCount;
    }
    
    // Mappings
    mapping(address => User) public users;
    mapping(uint => Post) public posts;
    mapping(uint => Comment) public comments;
    
    // Events
    event RegisterUser(uint id, address userAddress, string name);
    event PostCreated(uint postId, address author);
    event CommentCreated(uint commentId, address author, uint postId);
    event Upvoted(uint postId, address voter);
    event Downvoted(uint postId, address voter);
    
    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    modifier onlyPostOwner(uint _postId) {
        require(posts[_postId].author == msg.sender, "Only post owner can call this function");
        _;
    }
    
    modifier onlyCommentOwner(uint _commentId) {
        require(comments[_commentId].author == msg.sender, "Only comment owner can call this function");
        _;
    }
    
    modifier usernameTaken(string memory _name) {
        require(usernames[_name] == address(0), "Username already taken");
        _;
    }
    
    modifier checkUserExists(address _userAddress) {
        require(users[_userAddress].userAddress != address(0), "User does not exist");
        _;
    }
    
    // Variables
    address public owner;
    mapping(string => address) usernames;
    address[] public voters;
    
    // Constructor
    constructor() {
        owner = msg.sender;
    }
    
    // Functions
    function registerUser(string memory _name, string memory _bio, string memory _profileImageHash) public usernameTaken(_name) {
        uint id = generateUserId();
        users[msg.sender] = User(id, msg.sender, _name, _bio, _profileImageHash);
        usernames[_name] = msg.sender;
        emit RegisterUser(id, msg.sender, _name);
    }
    
    function changeUsername(string memory _newName) public usernameTaken(_newName) {
        require(users[msg.sender].userAddress != address(0), "User does not exist");
        delete usernames[users[msg.sender].name];
        usernames[_newName] = msg.sender;
        users[msg.sender].name = _newName;
    }
    
    function getUser(address _userAddress) public view returns(User memory) {
        return users[_userAddress];
    }
    
    function createPost(string memory _content, string memory _imgHash) public {
        uint postId = generatePostId();
        posts[postId] = Post(postId, _content, _imgHash, block.timestamp, 0, 0, msg.sender);
        emit PostCreated(postId, msg.sender);
    }
    
    function editPost(uint _postId, string memory _content, string memory _imgHash) public onlyPostOwner(_postId) {
        Post storage post = posts[_postId];
        post.content = _content;
        post.imgHash = _imgHash;
    }
    
    function deletePost(uint _postId) public onlyPostOwner(_postId) {
        delete posts[_postId];
    }
    
    function upvote(uint _postId) public {
        require(posts[_postId].author != msg.sender, "You cannot upvote your own post");
        require(!hasVoted( msg.sender), "You have already voted");
        posts[_postId].upvote++;
        voters.push(msg.sender);
        emit Upvoted(_postId, msg.sender);
    }
    
    function downvote(uint _postId) public {
        require(posts[_postId].author != msg.sender, "You cannot downvote your own post");
        require(!hasVoted( msg.sender), "You have already voted");
        posts[_postId].downvote++;
        voters.push(msg.sender);
        emit Downvoted(_postId, msg.sender);
    }
    
    function hasVoted( address _voter) internal view returns(bool) {
        for (uint i = 0; i < voters.length; i++) {
            if (voters[i] == _voter) {
                return true;
            }
        }
        return false;
    }
    
    function getUserPosts(address _userAddress) public view returns(Post[] memory) {
        // Implementation to retrieve all posts by a user

    }
    
    function createComment(uint _postId, string memory _content) public {
        uint commentId = generateCommentId();
        comments[commentId] = Comment(commentId, msg.sender, _postId, _content, block.timestamp, 0);
        emit CommentCreated(commentId, msg.sender, _postId);
    }
    
    function editComment(uint _commentId, string memory _content) public onlyCommentOwner(_commentId) {
        Comment storage comment = comments[_commentId];
        comment.content = _content;
    }
    
    function deleteComment(uint _commentId) public onlyCommentOwner(_commentId) {
        delete comments[_commentId];
    }
    
    function likeComment(uint _commentId) public {
        comments[_commentId].likeCount++;
    }
    
    function getUsersComment(address _userAddress) public view returns(Comment[] memory) {
        // Implementation to retrieve all comments by a user
    }
    
    // Owner functions
    function getBalance() public view onlyOwner returns(uint) {
        return address(this).balance;
    }
    
    function transferContractBalance(address payable _to) public onlyOwner {
        _to.transfer(address(this).balance);
    }
    
    function stopDapp() public onlyOwner {
        // Implement to stop the Dapp
    }
    
    function startDapp() public onlyOwner {
        // Implement to start the Dapp
    }
    
    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
    
    // Internal functions
    function generateUserId() internal pure returns(uint) {
        // Implementation to generate unique user IDs
        return 1;
    }
    
    function generatePostId() internal pure returns(uint) {
        // Implementation to generate unique post IDs
        return 1;
    }
    
    function generateCommentId() internal  pure returns(uint) {
        // Implementation to generate unique comment IDs
        return 1;
    }
}
