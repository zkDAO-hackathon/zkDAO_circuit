# ZKDAO Noir Circuit

by hackathon

## Quick start 🏄

Prerequisites: [Node (v22.16 LTS)](https://nodejs.org/en/download) and [Git](https://git-scm.com/downloads)

> Clone the repository:

```bash
git clone https://github.com/zkDAO-hackathon/zkDAO_circuit.git
```

## Noir Setup 🎯

If you don't have it yet, install Noir with the following command:

```bash
curl -L https://raw.githubusercontent.com/noir-lang/noirup/refs/heads/main/install | bash
```

Update to the latest version:

```bash
noirup
```

Compile the circuit:

```bash
nargo compile
```

Generate the verification key:

```bash
bb write_vk -b ./target/zkDAO_circuit.json -o ./target --oracle_hash keccak
```

Generate the Solidity verifier contract:

```bash
bb write_solidity_verifier -k ./target/vk -o Verifier.sol
```

## Authors 🏗

[salviega](https://github.com/salviega)
