const contract = artifacts.require("Lottery");

module.exports = (deployer) => {
  deployer.deploy(contract);
};
