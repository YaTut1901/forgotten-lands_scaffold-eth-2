// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract ERC1155ForgottenLandsV2 is Ownable, ERC1155("ipfs://QmVhPhAKHXpAg6DnfjV4oNxVtJyjTSLCd9JKXPhWvFgY1k/") {
    using Strings for uint256;
    
    uint256 private constant FIRST_NONFUNGIBLE = 7;

    uint256 private nextNonfungible = FIRST_NONFUNGIBLE;

    mapping(uint256 id => uint256 typeId) private _tokenTypes;

    constructor() {
        // set type ids for the first 7 tokens
        setFungibleTypeIds();
    }

    function uri(uint256 id) public override view returns (string memory) {
        return string.concat(super.uri(id), _tokenTypes[id].toString());
    }

    function setFungibleTypeIds() internal {
        for (uint256 i = 0; i < FIRST_NONFUNGIBLE; i++) {
            _tokenTypes[i] = i;
        }
    }
}