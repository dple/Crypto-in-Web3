const { secp256k1 } = require("ethereum-cryptography/secp256k1");
//const { ethers } = require("ethers");
const { utf8ToBytes, bytesToHex, hexToBytes } = require("ethereum-cryptography/utils");
const { sha256 } = require("ethereum-cryptography/sha256");
const { keccak256 } = require("ethereum-cryptography/keccak");
const { getRandomBytes } = require("ethereum-cryptography/random");
const { scrypt } = require("ethereum-cryptography/scrypt");
const { pbkdf2 } = require("ethereum-cryptography/pbkdf2");

(async () => {
    // Key length = 32 bytes
    const keylen = 32;
    // Seed for generating private key
    const seed = "jdlkafjdslafjeoksdjf343jfk30fskl"
    const messageHash = bytesToHex(await sha256(utf8ToBytes("Web3 is Awesome")));
    
    // Get a random private key using CSRPN
    const privateKey = bytesToHex(await getRandomBytes(keylen)); 
    // Get a random key from a seed fed into a hash function
    // const privateKey = bytesToHex(await sha256(utf8ToBytes(seed)));
    
    // Generate public key from private key. Produce 33-byte compressed signatures by default
    const publicKey = secp256k1.getPublicKey(privateKey);   
    console.log("Public Key =>", bytesToHex(publicKey));

    // Generate Ethereum wallet address from public key => last 20 of public key's hash
    const ethAddress = bytesToHex(await keccak256(publicKey));
    const ethAddressWithPrefix = "0x" + ethAddress.slice(-20);
    console.log("Ethereum address =>", ethAddressWithPrefix);

    // Signature generation
    const sig = await secp256k1.sign(messageHash, privateKey);
    console.log("Signature of {} is {}: ", messageHash, sig);

    // Signature verification 
    const verified = secp256k1.verify(sig, messageHash, publicKey);
    console.log("Verified", verified);

    // Receover public key
    publicKeyRecovered = sig.recoverPublicKey(messageHash).toHex(true);
    console.log("Recovered public key =>", publicKeyRecovered);
    if (bytesToHex(publicKey) == publicKeyRecovered) 
        console.log("Public key recovered sucessfully!");

    // Get signer's Ethereum address
    const ethAddressRecovered = bytesToHex(await keccak256(hexToBytes(publicKeyRecovered)));
    const ethAddressRecoveredWithPrefix = "0x" + ethAddressRecovered.slice(-20);
    console.log("Recovered Ethereum address =>", ethAddressRecoveredWithPrefix);
    if (ethAddressRecoveredWithPrefix == ethAddressWithPrefix) 
        console.log("Signer's Ethereum address was sucessfully regenerated!");
}) ();
