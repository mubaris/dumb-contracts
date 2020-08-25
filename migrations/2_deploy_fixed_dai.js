const fDai = artifacts.require("FixedDai");

module.exports = function (deployer) {
  deployer.deploy(fDai);
};
