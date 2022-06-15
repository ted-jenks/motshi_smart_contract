// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

contract CertificationService {

    struct Certificate {
        address issuer;
        string data;
    }

    mapping(address => Certificate) public certificates;

    function createCertificate(string memory _data, address _owner) external {
        certificates[_owner] = Certificate(msg.sender, _data);
    }

}