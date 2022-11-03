// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

struct Student {
    string name;
    uint age;
}

contract Groups {
    uint constant groups_count = 10;
    Student[][groups_count] public groups;

    event NewStudent(string name, uint age, uint group_idx);

    constructor()   {

    }

    function get_random_idx(string memory name) private view returns (uint) {
        uint name_hash = uint(keccak256(abi.encodePacked(name)));
        uint block_hash = uint(blockhash(block.number));

        return (block_hash + name_hash) % groups_count;
    }

    function add_student(Student memory student) public returns (uint) {
        require(student.age < 100, "Age must be less than 100");

        uint group_idx = get_random_idx(student.name);
        groups[group_idx].push(student);

        emit NewStudent(student.name, student.age, group_idx);

        return group_idx;
    }
}
