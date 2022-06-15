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
    string data;
    address owner;
    function beforeAll () public {
        certificationServiceToTest = new CertificationService();
        data = "testing";
        owner = address(0x1C6195d95742705538723F28b89257128275dDeA);
    }
    
    function testCreateCertificate () public {
        certificationServiceToTest.createCertificate(data, owner);
        (,string memory _data) = certificationServiceToTest.certificates(owner);
        emit Print(_data);
        Assert.equal(_data, data, "proposal at index 0 should be the winning proposal");
    }
    
}
