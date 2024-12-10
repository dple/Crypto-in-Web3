const { secp256k1 } = require("ethereum-cryptography/secp256k1");
const { utf8ToBytes } = require("ethereum-cryptography/utils");
const { sha256 } = require("ethereum-cryptography/sha256");
const { bytesToHex } = require("ethereum-cryptography/utils");
const { getRandomBytes } = require("ethereum-cryptography/random");

(async () => {
    const keylen = 32;
    const seed = "jdlkafjdslafjeoksdjf343jfk30fskl"
    const message = bytesToHex(await sha256(utf8ToBytes("Hello ECDSA. Could you sing?")));
    // Get a random private key using CSRPN
    const privateKey = bytesToHex(await getRandomBytes(keylen)); 
    // Get a random key from a seed fed into a hash function
    // const privateKey = bytesToHex(await sha256(utf8ToBytes(seed)));
    const publicKey = secp256k1.getPublicKey(privateKey, false);    
    const signature = await secp256k1.sign(message, privateKey);
    console.log("Signature of {} is {}: ", message, signature);
    const verified = secp256k1.verify(signature, message, publicKey);
    console.log("Verified", verified);
}) ();
