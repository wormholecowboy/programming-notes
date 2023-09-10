# Ethereum

Created: February 3, 2022 9:28 PM
Updated: February 8, 2022 5:13 PM

GAS

- Gwei stands for giga wei. Wei is the smallest unit of ETH: 10^18
- Contracts are compiled down to OPCODES, which each have fixed gas costs for each one
- The gas cost of a function is the sum of all its OPCODES costs
- gas limits: unused gas in a transaction is refunded. if it goes over the limit, fail and lose eth
- Eth keeps the blockchain in sync by imposing a limit on gas per block
- An ETH send is 21,000 gas units.
- London introduced minimum base fees per gas unit for each transaction, which is burnt
    - Also introduced tipping(priority fee)
    - Changed the gas limit to a range from 15M-30M. Can go less than 15.
    - Base fees are calculated by how over or under the last block was on gas limit to get equillibrium.
        - **If the block gas is greater than the 15M target, the base fees for the next block is increased. Similarly, if the block gas is smaller than the 15M target, the base fees for the next block is decreased.**
    - The base fees is increased by a maximum of 12.5% per block if the target 15M gas is exceeded.
    

MINING

1. User signs transaction request and it gets broadcast to network
2. Nodes add it to their mempool
3. Miners group tx to maximize fees and stay under gas limit
    1. verify each tx
    2. execute it on local EVM and get paid fees
    3. execute POW certificate for block
4. Propose block to network
5. Other nodes validate certificate, execute tx on local EVM, and verify new EVM state
6. Nodes add new block to their EVM
7. remove tx from mempool
- Nakamoto Consensus: Proof of work + longest chain rule
    - ETH uncles get rewarded 1.75ETH
- Finality: How long you wait for a tx to be irreversible (~1 min, 6 blocks)
- Ethash: Eth’s hash algo
    - Miner gather’s tx’s
    - The network slices ~1GB of network data
    - Hash data to create target
    - target is inversely proportionate to the mining difficulty. The higher the mining difficulty, the lower the **`target`**
    - Miners us nonce, target, data and others to create a hash that is lower than the target.
    - ***The mining difficulty becomes less or more difficult based on how many miners are on the network***
    
    EVM
    
    - The entire Ethereum state is stored in a huge data structure: The Merkle Patricia Trie
    - The EVM itself behaves as a **[stack machine](https://en.wikipedia.org/wiki/Stack_machine)**
     with a maximum depth of 1024 items on the stack. Each item in the stack is a 256-bit (32 bytes) word.
    - During execution, the EVM maintains a transient **memory**
    , as a 32 byte addressed byte array, which does not persist between transactions. The transient memory is cleared when a new transaction is being executed.
    - The EVM executes smart contracts compiled down to OPCODES as bytecode, represented in hexadecimal