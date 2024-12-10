const { encrypt, decrypt } = require("ethereum-cryptography/aes");
const { sha256 } = require("ethereum-cryptography/sha256");
const { hexToBytes, bytesToHex, utf8ToBytes, bytesToUtf8 } = require("ethereum-cryptography/utils");

const msg = "This is a secret info, must be kept confidentially!"
const msgHash = sha256(utf8ToBytes(msg));
const secretKey = hexToBytes("2b7e151628aed2a6abf7158809cf4f3c");
const iv = hexToBytes("f0f1f2f3f4f5f6f7f8f9fafbfcfdfeff");

async function AESEnc() {
    return await encrypt(msgHash, secretKey, iv);
    //console.log("Ciphertext =>", bytesToHex(await encrypt(msgHash, secretKey, iv)));
}

async function AESDec(_ciphertext) {
    //console.log("Ciphertext in bytes =>", _ciphertext);
    return await decrypt(_ciphertext, secretKey, iv);
}

async  function AESDecrypt(){

    console.log("Result after AES  Decryption =>", 
        bytesToUtf8(await decrypt(await encrypt(utf8ToBytes("Calyptus"), secretKey, iv), secretKey, iv)));
}

(async () => {
    ciphertext = await AESEnc();
    //console.log("Ciphertext in bytes =>", ciphertext);
    console.log("Ciphertext =>", bytesToHex(ciphertext));
    plainText = await AESDec(ciphertext);
    console.log("Plaintext =>", bytesToUtf8(plainText));
    AESDecrypt()
})()
