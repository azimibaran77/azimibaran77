// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AddressBook.sol";

contract AddressBookFactory {
    string private salt = "ваша строка тут";
    function deploy() external returns (AddressBook) {
        AddressBook newAddressBook = new AddressBook();
        newAddressBook.transferOwnership(msg.sender);
        return newAddressBook;
    }
}
