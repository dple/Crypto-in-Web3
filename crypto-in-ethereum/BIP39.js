const { generateMnemonic,mnemonicToSeedSync,mnemonicToEntropy } = require("ethereum-cryptography/bip39");
const { wordlist } = require("ethereum-cryptography/bip39/wordlists/english");
const { bytesToHex, hexToBytes } = require("ethereum-cryptography/utils");


const wList = generateMnemonic(wordlist);

console.log("Entropy =>", bytesToHex(mnemonicToEntropy(wList, wordlist)));
console.log("Master seed =>", bytesToHex(mnemonicToSeedSync(wList)));