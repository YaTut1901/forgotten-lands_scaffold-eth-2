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
	error NoTokenType(uint256 typeId);
	error NoToken(uint256 id);

	uint256 public constant FIRST_NONFUNGIBLE_TYPEID = 7;
	uint256 public constant LAST_NONFUNGIBLE_TYPEID = 46;

	uint256 private nextNonfungible = FIRST_NONFUNGIBLE_TYPEID;

	mapping(uint256 id => uint256 typeId) private _tokenTypes;
	mapping(address user => bool) private allowed;

	constructor() {
		// set type ids for the first 7 tokens
		setFungibleTypeIds();
	}

	function uri(uint256 id) public view override returns (string memory) {
		if (_tokenTypes[id] == 0 && id != 0) {
			revert NoToken(id);
		}
		return string.concat(super.uri(id), _tokenTypes[id].toString());
	}

	function mint(
		uint256 typeId,
		uint256 amount,
		uint256 coinAmount,
		uint256[] calldata tokenTypeIdsToBurn,
		uint256[] calldata tokenAmountsToBurn
	) public payable allowedOperation nonReentrant {
		// check if typeId exists
		if (typeId >= LAST_NONFUNGIBLE_TYPEID) {
			revert NoTokenType(typeId);
		}
		// check if it is fungible and revert if so and amount > 1
		if (typeId >= FIRST_NONFUNGIBLE_TYPEID && amount > 1) {
			revert TypeNonFungible(typeId);
		}
		// check if tokens to burn are in right format
		if (tokenAmountsToBurn.length != tokenTypeIdsToBurn.length) {
			revert ArraysMustHaveTheSameLength();
		}
		// check if amount of native token are payed correctly
		if (msg.value != coinAmount) {
			revert NotSufficientPayment();
		}
		// burn if tokens to burn are provided
		if (tokenAmountsToBurn.length != 0) {
			_burnBatch(_msgSender(), tokenTypeIdsToBurn, tokenAmountsToBurn);
		}
		// mint token with id = nextNonfungible if typeId belong to nonfungible, otherwise mint token with id = typeId
		_mint(
			_msgSender(),
			typeId >= FIRST_NONFUNGIBLE_TYPEID ? nextNonfungible : typeId,
			amount,
			""
		);
		nextNonfungible++;
	}

	function setFungibleTypeIds() internal {
		for (uint256 i = 0; i < FIRST_NONFUNGIBLE_TYPEID; i++) {
			_tokenTypes[i] = i;
		}
	}
}
