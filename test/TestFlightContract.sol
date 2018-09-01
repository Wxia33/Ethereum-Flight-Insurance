pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/FlightContract.sol";

contract TestFlightContract {
    FlightContract flightcontract
        = FlightContract(DeployedAddresses.FlightContract());

    function testChangePremium() public {
        uint premiumPrice = flightcontract.changePremium(3);
        uint expected = 3;
        Assert.equal(premiumPrice, expected, "Premium price should be changed to 3");
    }

    function testRegisterPolicy() public {
        bytes32 flightNumber;
        bytes32 departureDate;
        uint256 _departureTime;
        uint256 _arrivalTime;


    }
}