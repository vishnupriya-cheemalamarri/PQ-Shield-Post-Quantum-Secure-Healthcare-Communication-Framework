# PQ-Shield: Post-Quantum Secure IoT Healthcare Communication

A post-quantum cryptographic framework for secure IoT-based healthcare 
data transmission with blockchain-enabled access control and audit logging.

---

## What This Project Does

This system simulates a hospital IoT network where medical devices 
(doctors, nurses, admins) securely transmit patient records to each other 
using quantum-resistant cryptography and blockchain-based access control.

**Two security layers:**
- **PQ Crypto layer** — protects the actual patient data
- **Blockchain layer** — enforces access control and provides tamper-proof audit trail

---

## Features

- ML-DSA-44 (Dilithium) digital signatures — quantum-resistant
- ML-KEM-512 (Kyber) key encapsulation — quantum-resistant
- AES-GCM-128 symmetric encryption
- Seed-based key compression — 97% storage reduction
- Role-based access control via Ethereum smart contracts
- Immutable audit logging on blockchain
- 10 simulated IoT devices with roles (doctor/nurse/admin/guest)
- Custom patient dataset (3 medical records)
- Python to Ethereum bridge via web3.py

---

## Technology Stack

| Component | Technology |
|---|---|
| Language | Python 3.11 |
| PQ Signatures | ML-DSA-44 / Dilithium (NIST FIPS 204) |
| PQ Encryption | ML-KEM-512 / Kyber (NIST FIPS 203) |
| Symmetric Encryption | AES-GCM 128-bit |
| Blockchain | Ethereum (Hardhat local) |
| Smart Contracts | Solidity 0.8.20 |
| Web3 Bridge | web3.py 7.x |
| Notebook | Jupyter |

---

## Project Structure
iot-pq-blockchain/
├── contracts/
│   ├── DeviceRegistry.sol
│   ├── AccessControl.sol
│   └── AuditLog.sol
├── scripts/
│   └── deploy.js
├── hardhat.config.js
├── package.json
├── patient_data.py
└── CRYPTO_FINAL_DA2.ipynb
---

## Smart Contracts

### DeviceRegistry.sol
- Registers all 10 IoT devices on-chain
- Stores keccak256 hash of each device's PQ public keys
- Prevents device impersonation

### AccessControl.sol
- Enforces role-based access policy on-chain
- Admin can send to anyone
- Doctor can send to doctor or nurse
- Nurse to nurse only
- Guest is blocked

### AuditLog.sol
- Permanently records every transmission attempt
- Stores sender, receiver, message hash, access result, timestamp
- Append-only, nothing can be deleted

---

## Setup Instructions

### Prerequisites
- Python 3.11+
- Node.js 18+
- Git

### 1. Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/iot-pq-blockchain.git
cd iot-pq-blockchain
```

### 2. Install Node dependencies
```bash
npm install
```

### 3. Install Python dependencies
```bash
pip install cryptography pqcrypto numpy matplotlib web3 notebook
```

### 4. Start local blockchain — Terminal 1, keep running
```bash
npx hardhat node
```

### 5. Deploy smart contracts — Terminal 2
```bash
npx hardhat run scripts/deploy.js --network localhost
```

### 6. Launch Jupyter notebook — Terminal 3
```bash
python -m notebook
```

### 7. Open and run the notebook
- Open CRYPTO_FINAL_DA2.ipynb
- Run cells in order Cell 0 to Cell 12
- Cell 4 will ask for device roles, type doctor/nurse/admin/guest
- Cell 11 will ask for sender, patient ID, receiver

---

## Results

| Metric | Value |
|---|---|
| Dilithium public key | 1312 bytes |
| Kyber public key | 800 bytes |
| Raw key storage 10 devices | 21120 bytes |
| Compressed seed storage | 640 bytes |
| Compression ratio | 97% |
| Signature size | 2420 bytes |
| Smart contracts deployed | 3 |

---

## Access Control Policy Results

| Sender | Receiver | Result |
|---|---|---|
| doctor | nurse | GRANTED |
| guest | doctor | DENIED |
| nurse | doctor | DENIED |
| admin | anyone | GRANTED |

---

## Patient Dataset

| ID | Patient | Condition |
|---|---|---|
| P001 | Ravi Kumar | Type 2 Diabetes |
| P002 | Ananya Sharma | Hypertension |
| P003 | Suresh Reddy | Coronary Artery Disease |

---

## Security Analysis

| Attack | Classical | This System |
|---|---|---|
| Quantum attack | RSA/ECC broken | ML-KEM + ML-DSA resistant |
| Message tampering | Hash only | Dilithium signature + on-chain hash |
| Unauthorized access | Password | Smart contract role policy |
| Audit tampering | Centralized logs | Immutable blockchain |
| Key storage | Large plaintext keys | 97% compressed seeds |

---
