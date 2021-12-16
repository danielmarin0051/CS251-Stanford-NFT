// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/*
MMMWNNWMMMWNNWMMMWNNWMMMWWNWMMMWWNWWMMWWNWWMMMWNNWMMMWNNWMMMWNNWMMMWNNWMMMWWWNWMMMWWNWWMMWWNWWMMMWNWWMMMWNNWMMMWNNWMMMWNNWMMMWNNWMMMWWNWWMMWWNWWMMMWNN
MMMWWWWMMMWWWWMMMWWWWMMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWMMMWWWWMMMWWWWMMMWWWWWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWMMMWWWWMMMWWWWMMMWWWWWMMWWWWWMMWWWWWMMWWWW
WWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWMMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWWMMWWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWMMMWWWWWMM
WWWWMWWWWWWMMWWWWWWWWWWWWWMWWWWWWWWWWWWWMWWWWWWMWWWWWWWWWNNNWWWWNNNWWWWNNNNWWWWNNNNWWWNNNNWWWNNWWWMWWWWWWMWWWWWWMMWWWWWMMWWWWWWMWWWWWWWWWWWWWMWWWWWWWW
MMMWNWWMMMWNNWMMMWNNWMMMWWNWWMMWWNWWMMWWNWWMMWWNWWMMNklclllllllllllllllllllllllllllllllllllllllxXWWWWMMMWNWWMMMWNNWMMMWWNWMMMWWNWWMMWWNWWMMWWNWWMMMWNN
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWNkc:dkkxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxOx::xXWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
NNWMMMWWNWWMMWWNWWMMMWNNWMMMWNNWMMMWNNWMMMWNNWMMXx::d0xc,,,,,,,,,,,,,,,,,;;,,,,,,,,,,,,,,,,,,:x0xc:dKWNWMMMWNNWMMMWWNWWMMMWNNWMMMWNNWMMMWNNWMMMWNNWMMM
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWXx::x0x:..................,dd:,..................;d0kc:dKWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
MMMWWWWMMMWWNWMMMWWNWMMMWWNWWMMWWNWWMMWWNWWWXd:cx0x;...................'lkxkl,...................;dOkc:oKNWWMMMWNWWMMMWWWWMMMWWNWWMMWWNWWMMWWNWWMMWWNW
WWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWWMWWWWWWWWKd:ck0d;....................;dx:cdkd'....................,oOkc;o0NWWWWWMWWWWWMMWWWWWMMWWWWWWMWWWWWWMWWWWWWMM
WWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWWKo:ckOd;......................;xx;;coxl'.....................,oOkl;l0NWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWWMM
MMMWWWWMMMWWWWMMMWWWWMMMWWWWWMMWWWWWMMM0;:k0o,......................,oxo:,,,ckl........................,lOOc,kWWWWWMMMWWWWMMMWWWWWMMWWWWWMMWWWWWMMWWWW
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWk,dNo........................;xOd:,,,;lol,........................cKx,xWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
NNWMMMWWNWWMMWWNWWMMMWNNWMMMWNNWMMMWNNWk,dNl......................'cdoc;,,,,,;dk:........................:Kx,xWMMMWWNWWMMMWNNWMMMWNNWMMMWNNWMMMWNNWMMM
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWk,dNl......................'codl,,,,,,,codc'......................:Kx,xWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
MMMWNNWMMMWNNWMMMWNNWMMMWWNWMMMWWNWWMMMk,dNl.....................':cll:,,,,,,,lddl'......................:Kx,xWWNNWMMMWNNWMMMWNNWMMMWWNWWMMWWNWWMMMWNN
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWk,dNl....................,dOdlll:,,,,,,:olcc,.....................:Kx,xWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWMMMWWNWk,dNl....................',:ldxd:,,,,,,,;codkl....................:Kx,xWMMMWWWWWMMWWWWWMMMWWWWMMMWWWWMMMWWWWMMM
MMWWWWWMMWWWWWMMMWWWWWMMWWWWWMMWWWWWMMMk,dNl...................':llll:,,,,,,,,;dkxdl;....................:Kx,xWWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWW
MMWWWWWWMWWWWWWMWWWWWWMMWWWWWMMWWWWWMWWk,dNl.................;looc;,,,,,,,,,,,,;cllll;'................'.cKx,xWWWWWWMWWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWW
WNWWMMWWNWWMMWWNWWMMWWNWWMMMWNWWMMMWNNWO,dNl...............,oxo:::codc,,,,,,,,,,,,,;coxOkxkkkkkkkkkkkkkkkOXd,xWMMMWWNWWMMWWNWWMMMWWWWMMMWNWWMMMWWNWMMM
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWk,dNl...............;olcccclxkc,,,,,,,,,colcc::cxOolllllllllllllllllc;kWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
MMMWNNWMMMWNNWMMMWNNWMMMWNNWMMMWWNWWMMMk,dNl....................,coo:,,,,,,,,,,ckxdkkxxxxk0XXXXXXXXXXXXXXXXXXWMWNNWMMMWNNWMMMWNNWMMMWWNWWMMWWNWWMMMWNN
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWO,dNl.................,clol:,,,,,,,,,,,,,:oxkOO0OOKXKKXXXNWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WNWWMMWWNWWMMWWNWWMMWWNWWMMMWNWWMMMWNNWO,dNl...............'cdl;,,,,,,,,,,,,,,,,,,:loddolllllllccdKWWWNWMMMWWNWMMMWWNWWMMWWNWWMMMWNWWMMMWNNWMMMWWNWMMM
WMWWWWWWMWWWWWWMWWWWWWMWWWWWWMMWWWWWWWWk,dNl...............cx:,,,,,:c;,,,,,,,,,,,,,,,;lkKOkkkkkOkc:dKWWWWWWWWMWWWWWWMWWWWWWMWWWWWWWMWWWWWMMWWWWWMMWWWW
MMWWWWWMMMWWWWMMMWWWWWMMWWWWWMMWWWWWMMMk,dNl..............'odclllclkOc,,,,,,,,,;clc:,,,:xl.....;dOkc:dKWWWWWMMMWWWWMMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWW
WWWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWMMMWWWWO,dNl..............'oxl:;llloc,,,,,,,,,,ckxccllllxd'......,dOkc:dKWMWWWWWMMWWWWWMMWWWWWMMMWWWWMMMWWWWMMMWWWWMMM
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWO,dNl...............''.ckxolloo;,,,,,,,,,colcc;;cl:.........,dOkc:dKWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
MMMWNNWMMMWNNWMMMWNNWMMMWNNWMMMWWNWWMMMk,oNd'.................;ccccokd;,,,,,,,,:c;;codl,.............,dOkc:dKWMWNNWMMMWNNWMMMWNNWMMMWWNWWMMWWNWWMMMWNN
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWKl;d0kc'.................,clol;,,,,,,,,,oOxlccld:...............,oOk:;OWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
NNWMMMWWNWWMMWWNWWMMMWNNWMMMWNNWMMMWNNWMNOc:d0kc'............;llll:,,,,,,,,,,,,;cooc;'...................cXx,xWMMMWWNWWMMMWNNWMMMWNNWMMMWNNWMMMWNNWMMM
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWNOc:d0kc'.........ckxl:::;,,,,,,,,,,,,,,:llll;.................:Kx,xWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
MMMWWWWMMMWWWWMMMWWWWMMMWWWWWMMWWWWWMMWWWWWMNOc:dOkc'.......coccclxl,,,,,,,,,,,,,,,,,;ldc'...............:Kx,xWWWWWMMMWWWWMMMWWWWWMMWWWWWMMWWWWWMMWWWW
WWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWWMMWWWWNOc:oOkc,,,,,,,',;cloc,,,,,,,,,,,,,cxolcclxl...............:Kx,xWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWWMMWWWWWMM
WWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWWMWWWWWWWNkc:okkxxxxk0Odol:,,,,,,,,,,,,,,,:dxxdlcoc'..............:Kx,xWWMMWWWWWMMWWWWWMMWWWWWWMWWWWWWMWWWWWWMM
MMMWWWWMMMWWWWMMMWWWWMMMWWNWWMMWWNWWMMWWNWWMMWWNWWNOlclllccdkl:clol:,,,,,,,,,,,,,,,:llll:'...............:Kx,xWWNWWMMMWWWWMMMWWNWWMMWWNWWMMWWNWWMMWWNW
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWNNNNXOkxlllldxc,,,,,,,,,,,,,:lolc:cxo'..............:Kx,xWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
NNWMMMWWNWWMMWWNWWMMMWNNWMMMWNNWMMMWNNWNXKKKKKKKKKKKKKKKKK0kxoclll;,,,,,,,,,,,,,,:xxllccll,..............:Kx,xWMMMWWNWWMMMWNNWMMMWNNWMMMWNNWMMMWNNWMMM
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWO::llllllllllllllllloOk:,,,,,,,,,,,,,,,,,,,;llcclc'...............:Kx,xWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
MMMWNNWMMMWNNWMMMWNNWMMMWWNWMMMWWNWWMMMk,oX0kkkkkkkkkkkkkxk0XXo,,,,,,,,,,,,,,,,,,,,,,,;ox;...............:Kx,xWWNNWMMMWNNWMMMWWNWWMMWWNWWMMWWNWWMMMWNN
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWk,dNl.............;lol:,,,,,,,:oc,,,,,,,,,,,,,,;xd,...............:Kx,xWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWMMMWWWWk,dNl............:xl,,,;:ccclooxd;,,,,,,,,,,,,,,:lol;.............:Kx,xWWMMWWWWWMMWWWWWMMMWWWWMMMWWWWMMMWWWWMMM
MMWWWWWMMMWWWWMMMWWWWWMMWWWWWMMWWWWWMMMk,dNl...........,do,:lllcccc:,.ld;,,,,col:;;;;,,,,,lx:............:Kx,xWWWWWMMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWW
WWWWWWWWWWWWWWWWWWWWWWMWWWWWWWWWWWWWWWWk,dNl...........;xdol:,........ld;,,,,dxcccccclllc;,ld,...........:Kx,xWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
NNWMMMWWNWWMMWWNWWMMMWNWWMMMWNNWMMMWNNWO,dNl............;c,...........ld;,,,,do.......,:loloxc...........:Kx,xWMMMWWNWWMMWWNWWMMMWNWWMMMWNNWMMMWNNWMMM
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWk,dNl..........................ld;,,,,do..........':cc,...........:Kx,xWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
MMMWNNWMMMWNNWMMMWNNWMMMWNNWMMMWWNWWMMMk,dNo..........................ld;,,,,do..........................cKx,xWWNNWMMMWNNWMMMWNNWMMMWWNWWMMWWNWWMMMWNN
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW0;:O0o,.......................'od,,,,,do........................,lOOc,kWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
WWWWMMWWNWWMMWWNWWMMWWNWWMMMWWWWMMMWWNWWKo:ckOd;.....................:xc,,,,,oo'.....................,lOOl;lONWWMMWWNWWMMWWNWWMMMWWWWMMMWWWWMMMWWWWMMM
MMWWWWWMMWWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWNKd:ck0d;.................:ooc,,,,,,cxc...................,oOkl;l0NWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWW
MMWWWWWMMWWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWWKd:cx0x;.............,odc,,,,,,,,,coo:'..............,oOkc;o0WWWMMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWW
WWWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWMMMWWWWMMMWWWWXx::x0x:..........:dl;,,,,,,,,,,,,cool,..........;dOkc:oKWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWMMMWWWWMMMWWWWMMM
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWXx::x0x:,',',;cddl;;;;;;;;;;;;;;;;:odoc;,'''';d0kc:dKWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
MMMWNNWMMMWNNWMMMWNNWMMMWNNWMMMWWNWWMMWWNWWMMMWNNWXkc:dOkxxxxO00kkkkkkkkkkkkkkkkkkkkk00Okxxxxkxc:dKWWMMMWNNWMMMWNNWMMMWNNWMMMWNNWMMMWWNWWMMWWNWWMMMWNN
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWXklcllllllllllllllllllllllllllllllllllllllcxXWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
NNWMMMWWNWWMMWWNWWMMMWNNWMMMWNNWMMMWNNWMMMWNNWMMMWNNWWWWNNNNNWWNNNNNWWNNNNNWWWNNNNNWWWNNNNNWWNNWWMMMWNNWMMMWWNWWMMWWNWWMMMWNWWMMMWNNWMMMWNNWMMMWNNWMMM
WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
MMMWWWWMMMWWWWMMMWWWWMMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWMMMWWWWMMMWWWWMMMWWWWWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWMMMWWWWMMMWWWWMMMWWWWWMMWWWWWMMWWWWWMMWWWW
WWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWWMWWWWWWMWWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMMWWWWWMMWWWWWWMWWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWMMWWWWWWMWWWWWWMWWWWWWMM
*/

/*
 * Stanford CS 251 NFT | Autumn 2021 Collection
 *
 * Features: Enumerable, Ownable, Non-Transferable, Mintable
 *
 * - Enumerable: totalSupply() can be queried on-chain for convenience.
 * - Owner: Only owner can generate valid mint signatures.
 * - Non-Transferable: Only CS 251 students can own a token.
 * - Mintable: Students can mint their own NFT if they have a valid signature.
 *
 * https://github.com/danielmarin0051/CS251-Stanford-NFT
 */

/// @custom:security-contact cs251ta@cs.stanford.edu
contract StanfordCS251NFT is ERC721, ERC721Enumerable, Ownable {
  constructor() ERC721("Stanford CS 251 NFT Autumn 2021", "CS 251") {}

  function _baseURI() internal pure override returns (string memory) {
    return "ipfs://QmUW2246fZRGMv3An4EZhN78xVANQSw3ZKLXsAVa3DsAu9";
  }

  // Override required by Solidity.
  function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
    return super.supportsInterface(interfaceId);
  }

  // -------- CUSTOM LOGIC ---------------------------

  function mint(uint256 nonce, bytes memory signature) public {
    require(!_exists(nonce), "Token already minted");
    require(verifySignature(nonce, signature, owner()), "Invalid signature");
    _safeMint(msg.sender, nonce);
  }

  // See https://solidity-by-example.org/signature/
  function verifySignature(
    uint256 nonce,
    bytes memory signature,
    address minter
  ) public pure returns (bool) {
    bytes32 message = getMessageHash(nonce);
    (uint8 v, bytes32 r, bytes32 s) = getVRSFromSignature(signature);
    return ecrecover(message, v, r, s) == minter;
  }

  /**
   * Signature is produced by signing a keccak256 hash with the following format:
   * "\x19Ethereum Signed Message\n" + len(msg) + msg
   * See EIP-191.
   */
  function getMessageHash(uint256 nonce) public pure returns (bytes32) {
    bytes32 message = keccak256(abi.encodePacked(nonce));
    return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", message));
  }

  function getVRSFromSignature(bytes memory signature)
    public
    pure
    returns (
      uint8 v,
      bytes32 r,
      bytes32 s
    )
  {
    require(signature.length == 65, "Invalid signature length");
    // solhint-disable-next-line no-inline-assembly
    assembly {
      r := mload(add(signature, 32))
      s := mload(add(signature, 64))
      v := byte(0, mload(add(signature, 96)))
    }
  }

  /**
   * Override Open Zeppelin's tokenURI() since it concatenates tokenId to
   * baseURI by default, but in our case each token has the same metadata.
   */
  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
    return _baseURI();
  }

  // Non-transferability
  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 tokenId
  ) internal override(ERC721, ERC721Enumerable) {
    require(from == address(0), "Token is not transferable");
    super._beforeTokenTransfer(from, to, tokenId);
  }
}
