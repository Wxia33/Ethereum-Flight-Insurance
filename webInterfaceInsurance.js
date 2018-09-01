console.log(web3);

if (typeof web3 !== 'undefined') {
	web3 = new Web3(web3.currentProvider);
} else {
	web3 = new Web3(new Web3.provers.HttpProvider("http://localhost:8545"));
}

web3.setProvider(new web3.providers.HttpProvider('http://host.url', 
	0, BasicAuthUsername, BasicAuthPassword));

var coinbase = web3.eth.coinbase;
var balance = web3.eth.getBalance(coinbase);