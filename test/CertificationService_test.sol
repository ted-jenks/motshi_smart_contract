// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "../contracts/CertificationService.sol";
import "truffle/Assert.sol";

contract CertificationServiceTest {

    struct Certificate {
        address issuer;
        string data;
    }
    event Print(string state);
   
    CertificationService certificationServiceToTest;
    address owner;
    bytes32 data_hash;
    bytes32 image_hash = [ 0x00 , 0x01 ];
    bytes32 salt_hash = [ 0x00 , 0x01 ];
    bytes32 image_embedding = [ 0x00 , 0x01 ];
    uint expiry = [ 0x00 , 0x01 ];

    function beforeAll () public {
        certificationServiceToTest = new CertificationService();
        owner = address(0x1C6195d95742705538723F28b89257128275dDeA);
        data_hash = [ 0x00 , 0x01 ];
        image_hash = [ 0x02 , 0x03 ];
        salt_hash = [ 0x04 , 0x05 ];
        image_embedding = [ 0x06 , 0x07 ];
        expiry = now + 30 days ;
    }
    
    function testCreateCertificate () public {
        certificationServiceToTest.createCertificate(
            owner,
            data_hash,
            image_hash,
            salt_hash,
            image_embedding,
            expiry);
        (,bytes32 data_hash_1,
        bytes32 data_hash_2,
        bytes32 image_hash_1,
        bytes32 image_hash_2,
        bytes32 salt_hash_1,
        bytes32 salt_hash_2,
        bytes32 image_embedding_1,
        bytes32 image_embedding_2,
        uint expiry) = certificationServiceToTest.certificates(owner);

        Assert.equal(data_hash_1, data_hash[0], "first hash of data do not match");
        Assert.equal(data_hash_2, data_hash[1], "second hash of data do not match");
        Assert.equal(image_hash_1, image_hash[0], "first hash of image do not match");
        Assert.equal(image_hash_2, image_hash[1], "second hash of image do not match");
        Assert.equal(salt_hash_1, salt_hash[0], "first hash of salt do not match");
        Assert.equal(salt_hash_2, salt_hash[1], "second hash of salt do not match");
        Assert.equal(image_embedding_1, image_embedding[0], "first embedding of image do not match");
        Assert.equal(image_embedding_2, image_embedding[1], "second embedding of image do not match");
    }

    function testHashMapping () public {
        certificationServiceToTest.createCertificate(
            owner,
            data_hash,
            image_hash,
            salt_hash,
            image_embedding,
            expiry);

        bytes32 data = certificationServiceToTest.data_hash(data_hash[0]);
        (,bytes32 data_hash_1,
        bytes32 data_hash_2,
        bytes32 image_hash_1,
        bytes32 image_hash_2,
        bytes32 salt_hash_1,
        bytes32 salt_hash_2,
        bytes32 image_embedding_1,
        bytes32 image_embedding_2,
        uint expiry) = certificationServiceToTest.account(data);

        Assert.equal(data_hash_1, data_hash[0], "first hash of data do not match");
        Assert.equal(data_hash_2, data_hash[1], "second hash of data do not match");
        Assert.equal(image_hash_1, image_hash[0], "first hash of image do not match");
        Assert.equal(image_hash_2, image_hash[1], "second hash of image do not match");
        Assert.equal(salt_hash_1, salt_hash[0], "first hash of salt do not match");
        Assert.equal(salt_hash_2, salt_hash[1], "second hash of salt do not match");
        Assert.equal(image_embedding_1, image_embedding[0], "first embedding of image do not match");
        Assert.equal(image_embedding_2, image_embedding[1], "second embedding of image do not match");
    }

    function testMoveAccount () public {
        certificationServiceToTest.createCertificate(
            owner,
            data_hash,
            image_hash,
            salt_hash,
            image_embedding,
            expiry);

        certificationServiceToTest.moveAccount(owner, msg.sender);
        
        bytes32 data = certificationServiceToTest.data_hash(data_hash[0]);
        (,bytes32 data_hash_1,
        bytes32 data_hash_2,
        bytes32 image_hash_1,
        bytes32 image_hash_2,
        bytes32 salt_hash_1,
        bytes32 salt_hash_2,
        bytes32 image_embedding_1,
        bytes32 image_embedding_2,
        uint expiry) = certificationServiceToTest.account(owner);

        Assert.equal(data_hash_1, 0x0, "first hash of data do not match");
        Assert.equal(data_hash_2, 0x0, "second hash of data do not match");
        Assert.equal(image_hash_1, 0x0, "first hash of image do not match");
        Assert.equal(image_hash_2, 0x0, "second hash of image do not match");
        Assert.equal(salt_hash_1, 0x0, "first hash of salt do not match");
        Assert.equal(salt_hash_2, 0x0, "second hash of salt do not match");
        Assert.equal(image_embedding_1, 0x0, "first embedding of image do not match");
        Assert.equal(image_embedding_2, 0x0, "second embedding of image do not match");

        bytes32 data = certificationServiceToTest.data_hash(data_hash[0]);
        (,bytes32 data_hash_1,
        bytes32 data_hash_2,
        bytes32 image_hash_1,
        bytes32 image_hash_2,
        bytes32 salt_hash_1,
        bytes32 salt_hash_2,
        bytes32 image_embedding_1,
        bytes32 image_embedding_2,
        uint expiry) = certificationServiceToTest.account(msg.sender);

        Assert.equal(data_hash_1, data_hash[0], "first hash of data do not match");
        Assert.equal(data_hash_2, data_hash[1], "second hash of data do not match");
        Assert.equal(image_hash_1, image_hash[0], "first hash of image do not match");
        Assert.equal(image_hash_2, image_hash[1], "second hash of image do not match");
        Assert.equal(salt_hash_1, salt_hash[0], "first hash of salt do not match");
        Assert.equal(salt_hash_2, salt_hash[1], "second hash of salt do not match");
        Assert.equal(image_embedding_1, image_embedding[0], "first embedding of image do not match");
        Assert.equal(image_embedding_2, image_embedding[1], "second embedding of image do not match");
    }
    
}
