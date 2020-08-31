let instance = await SynthaSwap.deployed()

instance.convertEthtoSynthEth({value: 10000000000000000000})

instance.convertEthtoWbtc({value: 15000000000000000000})

let accounts = await web3.eth.getAccounts()

let balance = await web3.eth.getBalance(accounts[0])

let erc20abi = [{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_spender","type":"address"},{"name":"_value","type":"uint256"}],"name":"approve","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transferFrom","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"_owner","type":"address"}],"name":"balanceOf","outputs":[{"name":"balance","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"_owner","type":"address"},{"name":"_spender","type":"address"}],"name":"allowance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"payable":true,"stateMutability":"payable","type":"fallback"},{"anonymous":false,"inputs":[{"indexed":true,"name":"owner","type":"address"},{"indexed":true,"name":"spender","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Approval","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"from","type":"address"},{"indexed":true,"name":"to","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Transfer","type":"event"}]

var sEth = new web3.eth.Contract(erc20abi, "0x5e74C9036fb86BD7eCdcb084a0673EFc32eA31cb")

let address = "0x8A88722FbA5Ee19a3F782516bc21c2f35630e2E7"

sEth.methods.balanceOf(address).call().then(r => {console.log(r)})

let unlockedAddress = "0x0967aea99754974a4cc4dbf29009155a49588171"

var wBtc = new web3.eth.Contract(erc20abi, "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599")

address = accounts[0]

wBtc.methods.transferFrom(unlockedAddress, address, 100000000).call().then(r => {console.log(r)})

wBtc.methods.approve(instance.address, 100000000).send({from: address}).then(r => {console.log(r)})

instance.convertWbtctoSynthEth(50000000)