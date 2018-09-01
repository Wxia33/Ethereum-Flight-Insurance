pragma solidity ^0.4.17;

contract FlightContract {
    address public owner = msg.sender;
    address public oracleAddr;
    uint insurancePool;
    uint premiumPrice = 5;
    uint coverageAmnt = 50;
    bool oracleRequest;
    bytes32 requestFlightNumber;
    bytes32 oracleFlightNumber;
    bytes32 oracleDepartureDate;
    uint256 oracleDepartureTime;
    uint256 oracleArrivalTime;
    mapping (address => uint) public policyHolders;
    mapping (address => bytes32) public policyHolderFlightNumber;
    mapping (address => bytes32) public policyDepartureDate;
    mapping (address => uint) public policyDepartureTime;
    mapping (address => uint) public policyArrivalTime;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyOracle() {
        require(msg.sender == oracleAddr);
        _;
    }

    function FlightContract() payable {

    }

    function registerPolicy(
        bytes32 flightNumber,
        bytes32 departureDate,
        uint256 _departureTime,
        uint256 _arrivalTime) payable {
        if (msg.value < premiumPrice) {
            throw;
        }
        policyHolders[msg.sender] = 1;
        policyHolderFlightNumber[msg.sender] = flightNumber;
        policyDepartureDate[msg.sender] = departureDate;
        policyDepartureTime[msg.sender] = _departureTime;
        policyArrivalTime[msg.sender] = _arrivalTime;
    }

    function changePremium(uint _newPrice) returns (uint) {
        premiumPrice = _newPrice;
        return premiumPrice;
    }

    function changeCoverageAmnt(uint _newCoverage) returns (uint) {
        coverageAmnt = _newCoverage;
        return coverageAmnt;
    }

    function disburse() {
        if (policyHolders[msg.sender] != 1) {
            throw;
        }
        if (oracleDepartureDate > policyDepartureDate[msg.sender]
            || oracleDepartureTime > policyDepartureTime[msg.sender]
            || oracleArrivalTime > policyArrivalTime[msg.sender]) {
            if (msg.sender.send(coverageAmnt)) {
                policyHolders[msg.sender] = 0;
            }
        }
    }

    function oracleCallback(
        bytes32 flightNumber,
        bytes32 departureDate,
        uint256 _departureTime,
        uint256 _arrivalTime) onlyOracle {
        oracleFlightNumber = flightNumber;
        oracleDepartureDate = departureDate;
        oracleDepartureTime = _departureTime;
        oracleArrivalTime = _arrivalTime;
        oracleRequest = false;
    }

    function getOracleData(bytes32 flightNumber) {
        oracleRequest = true;
        requestFlightNumber = flightNumber;
    }

}