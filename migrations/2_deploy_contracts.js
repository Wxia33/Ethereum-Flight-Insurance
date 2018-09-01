var FlightContract = artifacts.require("FlightContract");

module.exports = function(deployer) {
  deployer.deploy(FlightContract);
};