#!/bin/bash

# cd circuits

circuit_folder=./circuits
build_folder=./build
input_folder=./inputs
contract_folder=./contracts

if [[ $# -ne 2 ]];
then 
    echo "Please provide CIRCUIT and INPUT to be compiled. Usage ./$0 circuit_name (without extension) input_file ..."
else
    echo "Compiling $1.circom ..."
    circom $circuit_folder/$1.circom --r1cs --wasm --c -o ${build_folder}

    PTAU=12   

    if [ -f ./ptau/powersOfTau28_hez_final_${PTAU}.ptau ]; then
        # Copy the input file inside the js directory
        cp ${input_folder}/$2 $build_folder/$1_js/input.json
        
        # Computing the witness with WebAssembly
        # Go inside the js directory and generate the witness.wtns
        cd $build_folder/$1_js
        node generate_witness.js $1.wasm input.json witness.wtns

        # Computing the witness with C++
        # cd $build_folder/$1_cpp
        # make
        # ./$1 input.json witness.wtns
        
        # Phase 1 - Powers of Tau
        # 1. Start a new powers of tau ceremony        
        snarkjs powersoftau new bn128 12 ../../ptau/pot12_0000.ptau -v
        # 2. Contribute to the ceremony
        snarkjs powersoftau contribute ../../ptau/pot12_0000.ptau ../../ptau/pot12_0001.ptau --name="First contribution" -v

        # 1. Phase 2 - circuit-specific
        snarkjs powersoftau prepare phase2 ../../ptau/pot12_0001.ptau pot_$1_final.ptau -v        
        # 2. Using Groth16 protocol to generate a .zkey file that will contain the 
        # proving and verification keys together with all phase 2 contributions
        snarkjs g16s ../$1.r1cs pot_$1_final.ptau $1_0000.zkey
        # 3. Contribute to the phase 2 of the ceremony:
        snarkjs zkey contribute $1_0000.zkey $1_0001.zkey --name="1st Contributor Name" -v
        # 4. Export verification key
        snarkjs zkey export verificationkey $1_0001.zkey verification_key.json

        # Proving circuit with ZK
        # Generate a zk-proof associated to the circuit and the witness. This generates proof.json and public.json
        snarkjs g16p $1_0001.zkey witness.wtns proof.json public.json

        # Verifying a proof
        snarkjs g16v verification_key.json public.json proof.json

        # Verifying from a smart contract
        snarkjs zkey export solidityverifier $1_0001.zkey ../../${contract_folder}/$1_verifier.sol
        # Generate and print parameters of call
        snarkjs generatecall | tee parameters.txt

    else
        echo "ptau not yet initialized!"
        exit 1;
    fi

fi

