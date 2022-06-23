// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

contract CertificationService {

    address owner;
    
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You aren't smart contract owner!");
        _;
    }

    struct Certificate {
        address issuer;
        bytes32 data_hash_1;
        bytes32 data_hash_2;
        bytes32 image_hash_1;
        bytes32 image_hash_2;
        bytes32 salt_hash_1;
        bytes32 salt_hash_2;
        bytes32 image_embedding_1;
        bytes32 image_embedding_2;
        uint expiry;
    }

    mapping(address => Certificate) public certificates;
    mapping(bytes32 => bytes32) public data_hash;
    mapping(bytes32 => address) public account;

    function createCertificate(address _owner, 
        bytes32[2] memory _data_hash,
        bytes32[2] memory _image_hash,
        bytes32[2] memory _salt_hash,
        bytes32[2] memory _image_embedding,
        uint _expiry) external onlyOwner {
        certificates[_owner] = Certificate(
            msg.sender, 
            _data_hash[0], 
            _data_hash[1],
            _image_hash[0],
            _image_hash[1],
            _salt_hash[0],
            _salt_hash[1],
            _image_embedding[0],
            _image_embedding[1],
            _expiry);
        data_hash[_data_hash[0]] = _data_hash[1];
        account[_data_hash[1]] = _owner;
    }

    function moveAccount(address _old_address, address _new_address) external onlyOwner {
        Certificate storage cert = certificates[_old_address];
        require(block.timestamp > cert.expiry, "Certification expired! Transfer Failed.");
        certificates[_new_address] = Certificate(
            cert.issuer, 
        cert.data_hash_1, 
        cert.data_hash_2, 
        cert.image_hash_1, 
        cert.image_hash_2, 
        cert.salt_hash_1,
        cert.salt_hash_2, 
        cert.image_embedding_1, 
        cert.image_embedding_2, 
        cert.expiry);
        delete certificates[_old_address];
    }

}