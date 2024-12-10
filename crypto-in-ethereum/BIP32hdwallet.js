const { HDKey } = require("ethereum-cryptography/hdkey");
const { bytesToHex, hexToBytes, utf8ToBytes } = require("ethereum-cryptography/utils");
const { sha256 } = require("ethereum-cryptography/sha256");
const { generateMnemonic,mnemonicToSeedSync,mnemonicToEntropy } = require("ethereum-cryptography/bip39");
const { wordlist } = require("ethereum-cryptography/bip39/wordlists/english");

// Get seed using BIP-39
//seed = hexToBytes("aba95e0851419e1e67a4d9c47017ce85117115fe0c0dc266f6f000d44e1d7f8c0618df2e127f51538ef62d389c1ffa4ee0b02ba9d9efc376606b37095299a20d");
const wList = generateMnemonic(wordlist);
mnemonicToEntropy(wList, wordlist);
seed = mnemonicToSeedSync(wList);

const hdkey1 = HDKey.fromMasterSeed(seed);

// Generate keys
// first normal child private key of master private key m/0
console.log(bytesToHex(hdkey1.derive("m/0").privateKey));
console.log(bytesToHex(hdkey1.derive("m/0/0").privateKey));
console.log(bytesToHex(hdkey1.derive("m/0/0/0").privateKey));   
console.log(bytesToHex(hdkey1.derive("m/0/0/0").publicKey));
console.log(bytesToHex(hdkey1.derive("m/0/0/1").privateKey));   
console.log(bytesToHex(hdkey1.derive("m/0/0/1").publicKey));

// Signing
const msg = "Hello cryptography-ethereum!";
const msgHash = sha256(utf8ToBytes(msg));
const sig = hdkey1.sign(msgHash);

console.log("Signature =>", bytesToHex(sig));

// verify
console.log("Signature verification =>", hdkey1.verify(msgHash, sig));
