import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect } from "chai";
import { ethers } from "hardhat";
import { signNonce } from "../scripts/lib/signNonce";
import { StanfordCS251NFT } from "../typechain";

const EXPECTED_TOKEN_URI = "ipfs://QmUW2246fZRGMv3An4EZhN78xVANQSw3ZKLXsAVa3DsAu9";

describe("CS251 Stanford NFT", function () {
  let StanfordCS251NFT: StanfordCS251NFT;
  let minter: SignerWithAddress;
  let account1: SignerWithAddress;
  let account2: SignerWithAddress;
  this.beforeAll(async () => {
    [minter, account1, account2] = await ethers.getSigners();
  });
  beforeEach(async () => {
    const StanfordCS251NFTFactory = await ethers.getContractFactory("StanfordCS251NFT");
    StanfordCS251NFT = await StanfordCS251NFTFactory.deploy();
    await StanfordCS251NFT.deployed();
  });
  it("Should return the correct name", async function () {
    expect(await StanfordCS251NFT.name()).to.equal("Stanford CS 251 NFT Autumn 2021");
  });
  it("Should allow mint with valid signature", async function () {
    const nonce = 42;
    const signature = await signNonce(nonce, minter);

    const tx = await StanfordCS251NFT.connect(account1).mint(nonce, signature);
    await tx.wait();
    expect(await StanfordCS251NFT.totalSupply()).to.equal(1);
    expect(await StanfordCS251NFT.ownerOf(nonce)).to.equal(account1.address);
  });
  it("Should revert on invalid signature", async function () {
    const nonce = 42;
    const fakeMinter = account1;
    const fakeSignature = await signNonce(nonce, fakeMinter);

    await expect(StanfordCS251NFT.connect(account1).mint(nonce, fakeSignature)).to.be.revertedWith("Invalid signature");
  });
  it("Should revert on double mint", async function () {
    const nonce = 42;
    const signature = await signNonce(nonce, minter);

    const tx = await StanfordCS251NFT.connect(account1).mint(nonce, signature);
    await tx.wait();
    expect(await StanfordCS251NFT.ownerOf(nonce)).to.equal(account1.address);
    await expect(StanfordCS251NFT.connect(account1).mint(nonce, signature)).to.be.revertedWith("Token already minted");
    await expect(StanfordCS251NFT.connect(account2).mint(nonce, signature)).to.be.revertedWith("Token already minted");
  });
  it("Should not be transferable", async function () {
    const nonce = 42;
    const signature = await signNonce(nonce, minter);
    const tx = await StanfordCS251NFT.connect(account1).mint(nonce, signature);
    await tx.wait();
    await expect(
      StanfordCS251NFT.connect(account1).transferFrom(account1.address, account2.address, nonce)
    ).to.be.revertedWith("Token is not transferable");
  });
  it("Should have the correct tokenURI for all tokens", async function () {
    const nonce = 42;
    const signature = await signNonce(nonce, minter);
    const tx = await StanfordCS251NFT.connect(account1).mint(nonce, signature);
    await tx.wait();

    const tokenURI = await StanfordCS251NFT.tokenURI(nonce);
    expect(tokenURI).to.equal(EXPECTED_TOKEN_URI);
  });
});
