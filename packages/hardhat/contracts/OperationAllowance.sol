// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/access/Ownable.sol";

contract OperationAllowance is Ownable {
    error OperationNotAllowed(bytes4 operation);
    
    event OperationAccessedBy(bytes4 operation, address user);
    event OperationAllowedTo(bytes4 operation, address user);
    event OperationDisallowedTo(bytes4 operation, address user);

    mapping(bytes4 operationId => mapping(address user => bool)) private allowed;

    modifier allowedOperation() {
        if (!allowed[msg.sig][msg.sender]) {
            revert OperationNotAllowed(msg.sig);
        }
        _;
        emit OperationAccessedBy(msg.sig, msg.sender);
        setAllowed(msg.sig, msg.sender, false);
    }

    function setAllowed(bytes4 operation, address user, bool value) public onlyOwner {
        allowed[operation][user] = value;

        if (value) {
            emit OperationAllowedTo(operation, user);
        } else {
            emit OperationDisallowedTo(operation, user);
        }
    }
}