const hre = require("hardhat");
const { assert } = require("chai");

describe("Division circuit", () => {
    let circuit;
    const sampleInput = {
        in1: "13", 
        in2: "7", 
        in3: "4", 
        in4: "2",
    };

    const sanityCheck = true;

    before(async () => {
        circuit = hre.circuitTest.setup("division");
    });

    it("produces a witness with valid constraints", async() => {
        const witness = await circuit.calculateWitness(sampleInput, sanityCheck);
        await circuit.checkConstraints(witness);
    });

    it("has expected witness values", async() => {
        const witness = circuit.calculateLabeledWitness(sampleInput, sanityCheck);
        assert.propertyVal(witness, "main.in1", sampleInput.in1);
        assert.propertyVal(witness, "main.in2", sampleInput.in2);
        assert.propertyVal(witness, "main.in3", sampleInput.in3);
        assert.propertyVal(witness, "main.in4", sampleInput.in4);
        assert.propertyVal(witness, "main.x1", undefined);
        assert.propertyVal(witness, "main.x2", undefined);
        assert.propertyVal(witness, "main.out", "3");
    });

    it("has the correct output", async () => {
        const expected = { out: 3 };
        const witness = await circuit.calculateWitness(sampleInput, sanityCheck);
        await circuit.assertOut(witness, expected);
    });
});