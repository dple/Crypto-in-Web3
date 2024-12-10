const { pbkdf2 } = require("ethereum-cryptography/pbkdf2");
const { scrypt } = require("ethereum-cryptography/scrypt");
const { getRandomBytes } = require("ethereum-cryptography/random");
const { utf8ToBytes } = require("ethereum-cryptography/utils");
const { bytesToHex } = require("ethereum-cryptography/utils");

let pass = utf8ToBytes("P@ssw0rd!");
let salt = utf8ToBytes("S@lt");
let keylen = 32;
let digest = "sha256";

/**
 * 
 * @param {*} _pass(Bytes) - A passphrse, string of characters to be hashed 
 * @param {*} _salt(Bytes) - A salt, string of random characters that 
 *                          modifies the hash to protect against Rainbow table attacks 
 * @param {*} _iterations 
 * @param {*} _keylen(Number) - Desired key length in bytes  
 * @param {*} _digest 
 */
async function getPbkdf2(_pass, _salt, _iterations, _keylen, _digest) {
    console.log("Key derived from PBKDF2 =>:", bytesToHex( await pbkdf2(_pass, _salt, _iterations, _keylen, _digest)));
}

getPbkdf2(pass, salt, 1024, keylen, digest); 

/**
 * 
 * @param {*} _pass(Bytes) - A passphrse, string of characters to be hashed 
 * @param {*} _salt(Bytes) - A salt, string of random characters that 
 *                          modifies the hash to protect against Rainbow table attacks 
 * @param {*} _costfactor(Number) - CPU/memory cost parameter – Must be a power of 2 (e.g. 1024)
* @param {*} _parallelizationfactor(NUmber) - Parallelization parameter 
* @param {*} _blocksizefactor(Number) - blocksize parameter, which fine-tunes sequential 
 *                          memory read size and performance. (8 is commonly used) 
 * @param {*} _keylen(Number) - Desired key length in bytes 
 */
async function getScrypt(_pass, _salt, _costfactor, _parallelizationfactor, _blocksizefactor, _keylen) {
    console.log("Key derived from Scrypt =>:", bytesToHex( await scrypt(_pass, _salt, _costfactor, _parallelizationfactor, _blocksizefactor, _keylen)));
}

getScrypt(pass, salt, 1024, 1, 8, keylen);

/**
 * 
 * @param {*} _keylen(Number) - Desired key length in bytes  
 */
async function getCSPRN(_keylen) {
    console.log("Key derived from CSPRN =>:", bytesToHex( await getRandomBytes(_keylen)));
    console.log(getRandomBytes(48));
}

getCSPRN(keylen);