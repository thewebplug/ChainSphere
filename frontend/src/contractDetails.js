export const contractABI = 
[
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_postId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_commentId",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_content",
				"type": "string"
			}
		],
		"name": "_editComment",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_postId",
				"type": "uint256"
			}
		],
		"name": "downvote",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "priceFeed",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "interval",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "vrfCoordinator",
				"type": "address"
			},
			{
				"internalType": "bytes32",
				"name": "gasLane",
				"type": "bytes32"
			},
			{
				"internalType": "uint64",
				"name": "subscriptionId",
				"type": "uint64"
			},
			{
				"internalType": "uint32",
				"name": "callbackGasLimit",
				"type": "uint32"
			},
			{
				"internalType": "uint256",
				"name": "minimumUsd",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [],
		"name": "ChainSphere__AlreadyVoted",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "winner",
				"type": "address"
			}
		],
		"name": "ChainSphere__BatchTransferFailed",
		"type": "error"
	},
	{
		"inputs": [],
		"name": "ChainSphere__NotCommentOwner",
		"type": "error"
	},
	{
		"inputs": [],
		"name": "ChainSphere__NotOwner",
		"type": "error"
	},
	{
		"inputs": [],
		"name": "ChainSphere__NotPostOwner",
		"type": "error"
	},
	{
		"inputs": [],
		"name": "ChainSphere__NotProfileOwner",
		"type": "error"
	},
	{
		"inputs": [],
		"name": "ChainSphere__OwnerCannotVote",
		"type": "error"
	},
	{
		"inputs": [],
		"name": "ChainSphere__PaymentNotEnough",
		"type": "error"
	},
	{
		"inputs": [],
		"name": "ChainSphere__PostDoesNotExist",
		"type": "error"
	},
	{
		"inputs": [],
		"name": "ChainSphere__TransferFailed",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "balance",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "numOfEligibleAuthors",
				"type": "uint256"
			}
		],
		"name": "ChainSphere__UpkeepNotNeeded",
		"type": "error"
	},
	{
		"inputs": [],
		"name": "ChainSphere__UserDoesNotExist",
		"type": "error"
	},
	{
		"inputs": [],
		"name": "ChainSphere__UsernameAlreadyTaken",
		"type": "error"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_userId",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_newNickName",
				"type": "string"
			}
		],
		"name": "changeUsername",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "bytes",
				"name": "",
				"type": "bytes"
			}
		],
		"name": "CheckUpkeep",
		"outputs": [
			{
				"internalType": "bool",
				"name": "upkeepNeeded",
				"type": "bool"
			},
			{
				"internalType": "bytes",
				"name": "",
				"type": "bytes"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "have",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "want",
				"type": "address"
			}
		],
		"name": "OnlyCoordinatorCanFulfill",
		"type": "error"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "commentId",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "postAuthor",
				"type": "string"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "commentAuthor",
				"type": "string"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "postId",
				"type": "uint256"
			}
		],
		"name": "CommentCreated",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_postId",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_content",
				"type": "string"
			}
		],
		"name": "createComment",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_content",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_imgHash",
				"type": "string"
			}
		],
		"name": "createPost",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_postId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_commentId",
				"type": "uint256"
			}
		],
		"name": "deleteComment",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_postId",
				"type": "uint256"
			}
		],
		"name": "deletePost",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "postId",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "posthAuthorName",
				"type": "string"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "downvoterName",
				"type": "string"
			}
		],
		"name": "Downvoted",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_postId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_commentId",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_content",
				"type": "string"
			}
		],
		"name": "editComment",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_postId",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_content",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_imgHash",
				"type": "string"
			}
		],
		"name": "editPost",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_userId",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_bio",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_profileImageHash",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_newName",
				"type": "string"
			}
		],
		"name": "editUserProfile",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getRecentTrendingPosts",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "postId",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "content",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "imgHash",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "timestamp",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "upvotes",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "downvotes",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "author",
						"type": "address"
					},
					{
						"internalType": "string",
						"name": "authorNickName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "authorFullName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "authorProfileImgHash",
						"type": "string"
					}
				],
				"internalType": "struct ChainSphereUserProfile.Post[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getRecentWinningPosts",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "postId",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "content",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "imgHash",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "timestamp",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "upvotes",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "downvotes",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "author",
						"type": "address"
					},
					{
						"internalType": "string",
						"name": "authorNickName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "authorFullName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "authorProfileImgHash",
						"type": "string"
					}
				],
				"internalType": "struct ChainSphereUserProfile.Post[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getUsernameOfRecentWinners",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "",
				"type": "string[]"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_postId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_commentId",
				"type": "uint256"
			}
		],
		"name": "likeComment",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "bytes",
				"name": "",
				"type": "bytes"
			}
		],
		"name": "performUpkeep",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "winner",
				"type": "address"
			}
		],
		"name": "PickedWinner",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "postId",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "authorName",
				"type": "string"
			}
		],
		"name": "PostCreated",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "postId",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "authorName",
				"type": "string"
			}
		],
		"name": "PostEdited",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "postId",
				"type": "uint256"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "postAuthor",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "liker",
				"type": "address"
			}
		],
		"name": "PostLiked",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "requestId",
				"type": "uint256"
			},
			{
				"internalType": "uint256[]",
				"name": "randomWords",
				"type": "uint256[]"
			}
		],
		"name": "rawFulfillRandomWords",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_fullNameOfUser",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_username",
				"type": "string"
			}
		],
		"name": "registerUser",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "requestId",
				"type": "uint256"
			}
		],
		"name": "RequestWinningAuthor",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "user",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "amount",
				"type": "uint256"
			}
		],
		"name": "RewardSent",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address payable",
				"name": "_to",
				"type": "address"
			}
		],
		"name": "transferContractBalance",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "postId",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "posthAuthorName",
				"type": "string"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "upvoterName",
				"type": "string"
			}
		],
		"name": "Upvoted",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "userAddress",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "username",
				"type": "string"
			}
		],
		"name": "UserRegistered",
		"type": "event"
	},
	{
		"stateMutability": "payable",
		"type": "fallback"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_postId",
				"type": "uint256"
			}
		],
		"name": "upvote",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"stateMutability": "payable",
		"type": "receive"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_username",
				"type": "string"
			}
		],
		"name": "getAddressFromUsername",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getAllPosts",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "postId",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "content",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "imgHash",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "timestamp",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "upvotes",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "downvotes",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "author",
						"type": "address"
					},
					{
						"internalType": "string",
						"name": "authorNickName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "authorFullName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "authorProfileImgHash",
						"type": "string"
					}
				],
				"internalType": "struct ChainSphereUserProfile.Post[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getBalance",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_commentId",
				"type": "uint256"
			}
		],
		"name": "getCommentByCommentId",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "commentId",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "author",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "postId",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "content",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "timestamp",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "likesCount",
						"type": "uint256"
					}
				],
				"internalType": "struct ChainSphereComments.Comment",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_postId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_commentId",
				"type": "uint256"
			}
		],
		"name": "getCommentLikersByPostIdAndCommentId",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_postId",
				"type": "uint256"
			}
		],
		"name": "getCommentsByPostId",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "commentId",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "author",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "postId",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "content",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "timestamp",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "likesCount",
						"type": "uint256"
					}
				],
				"internalType": "struct ChainSphereComments.Comment[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getContractOwner",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getIdsOfEligiblePosts",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getIdsOfRecentPosts",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getIdsOfRecentWinningPosts",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_postId",
				"type": "uint256"
			}
		],
		"name": "getPostById",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "postId",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "content",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "imgHash",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "timestamp",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "upvotes",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "downvotes",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "author",
						"type": "address"
					},
					{
						"internalType": "string",
						"name": "authorNickName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "authorFullName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "authorProfileImgHash",
						"type": "string"
					}
				],
				"internalType": "struct ChainSphereUserProfile.Post",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_ethAmount",
				"type": "uint256"
			}
		],
		"name": "getUsdValueOfEthAmount",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_userAddress",
				"type": "address"
			}
		],
		"name": "getUser",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "id",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "userAddress",
						"type": "address"
					},
					{
						"internalType": "string",
						"name": "nickName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "fullNameOfUser",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "bio",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "profileImageHash",
						"type": "string"
					}
				],
				"internalType": "struct ChainSphereUserProfile.User",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_userId",
				"type": "uint256"
			}
		],
		"name": "getUserById",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "id",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "userAddress",
						"type": "address"
					},
					{
						"internalType": "string",
						"name": "nickName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "fullNameOfUser",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "bio",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "profileImageHash",
						"type": "string"
					}
				],
				"internalType": "struct ChainSphereUserProfile.User",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_userAddress",
				"type": "address"
			}
		],
		"name": "getUserComments",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "commentId",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "author",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "postId",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "content",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "timestamp",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "likesCount",
						"type": "uint256"
					}
				],
				"internalType": "struct ChainSphereComments.Comment[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_userAddress",
				"type": "address"
			}
		],
		"name": "getUserNameFromAddress",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_userAddress",
				"type": "address"
			}
		],
		"name": "getUserPosts",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "postId",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "content",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "imgHash",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "timestamp",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "upvotes",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "downvotes",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "author",
						"type": "address"
					},
					{
						"internalType": "string",
						"name": "authorNickName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "authorFullName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "authorProfileImgHash",
						"type": "string"
					}
				],
				"internalType": "struct ChainSphereUserProfile.Post[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_postId",
				"type": "uint256"
			}
		],
		"name": "getUserVoteStatus",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]
  export const contractAddress = '0xD1D9DE2f13b247F7D0Ca80Abc68FCCA9c557eEb0';
  
  