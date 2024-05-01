// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    string private salt = "ваша строка тут"; 

    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }

    mapping(uint => Contact) private contacts;
    uint private nextId = 1;

    error ContactNotFound(uint id);

    function addContact(string calldata firstName, string calldata lastName, uint[] calldata phoneNumbers) external onlyOwner {
        contacts[nextId] = Contact(nextId, firstName, lastName, phoneNumbers);
        nextId++;
    }

    function deleteContact(uint id) external onlyOwner {
        require(contacts[id].id != 0, "Contact not found");
        delete contacts[id];
    }

    function getContact(uint id) external view returns (Contact memory) {
        if (contacts[id].id == 0) revert ContactNotFound(id);
        return contacts[id];
    }

    function getAllContacts() external view returns (Contact[] memory) {
        Contact[] memory allContacts = new Contact[](nextId - 1);
        for (uint i = 1; i < nextId; i++) {
            allContacts[i - 1] = contacts[i];
        }
        return allContacts;
    }
}
