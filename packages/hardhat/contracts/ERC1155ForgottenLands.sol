// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./OperationAllowance.sol";

contract ERC1155ForgottenLands is
	OperationAllowance,
	ReentrancyGuard,
	ERC1155("ipfs://QmVhPhAKHXpAg6DnfjV4oNxVtJyjTSLCd9JKXPhWvFgY1k/")
{
	using Strings for uint256;

	error TypeNonFungible(uint256 typeId);
	error ArraysMustHaveTheSameLength();
	error NotSufficientPayment();

	uint256 private constant FIRST_NONFUNGIBLE = 7;

	uint256 private nextNonfungible = FIRST_NONFUNGIBLE;

	mapping(uint256 id => uint256 typeId) private _tokenTypes;
	mapping(address user => bool) private allowed;

	constructor() {
		// set type ids for the first 7 tokens
		setFungibleTypeIds();
	}

	function uri(uint256 id) public view override returns (string memory) {
		return string.concat(super.uri(id), _tokenTypes[id].toString());
	}

function mint(
	uint256 typeId,
	uint256 amount,
	uint256 coinAmount,
	uint256[] calldata tokenTypeIdsToBurn,
	uint256[] calldata tokenAmountsToBurn
) public payable allowedOperation nonReentrant {
	if (typeId >= FIRST_NONFUNGIBLE && amount > 1) {
		revert TypeNonFungible(typeId);
	}
	if (tokenAmountsToBurn.length != tokenTypeIdsToBurn.length) {
		revert ArraysMustHaveTheSameLength();
	}
	if (tokenAmountsToBurn.length != 0) {
		for (uint256 i = 0; i < tokenTypeIdsToBurn.length; i++) {
			_burn(
				_msgSender(),
				tokenTypeIdsToBurn[i],
				tokenAmountsToBurn[i]
			);
		}
	}
	if (msg.value != coinAmount) {
		revert NotSufficientPayment();
	}
	_mint(_msgSender(), typeId, amount, "");
}

	function setFungibleTypeIds() internal {
		for (uint256 i = 0; i < FIRST_NONFUNGIBLE; i++) {
			_tokenTypes[i] = i;
		}
	}
}
