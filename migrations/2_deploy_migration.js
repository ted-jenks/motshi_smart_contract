const CertificationService = artifacts.require("CertificationService");

module.exports = function (deployer) {
  deployer.deploy(CertificationService);
};
