// Import Hardhat plugins and ethers
const { expect } = require("chai");

// Describe the contract and its tests
describe("SocialMedia", function () {
  let SocialMedia;
  let socialMedia;
  let owner;
  let addr1;
  let addr2;

  beforeEach(async function () {
    // Deploy the contract before each test
    SocialMedia = await ethers.getContractFactory("SocialMedia");
    [owner, addr1, addr2] = await ethers.getSigners();
    socialMedia = await SocialMedia.deploy();
  });

  // Test case 1: Registering a user
  it("Should register a new user", async function () {
    await socialMedia.registerUser("User1", "Bio1", "ImageHash1");
    const user = await socialMedia.users(owner.address);
    expect(user.name).to.equal("User1");
  });

  // Test case 2: Creating a post
  it("Should create a new post", async function () {
    await socialMedia.createPost("Content1", "ImageHash1");
    const post = await socialMedia.posts(1); // Assuming postId starts from 1
    expect(post.content).to.equal("Content1");
  });

  // Add more test cases for other functions

});
