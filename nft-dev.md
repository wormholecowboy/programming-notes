# NFT Dev

Created: December 9, 2021 9:11 PM
Updated: December 9, 2021 9:12 PM

COMMON EXPLOITS

Our game combines reliable concepts and mechanics of the on-chain technologies with low gas fee solutions of decentralized storage. Part of the processes such as the decisioning, the results, and the part of metadata run on-chain. And the other parts (other traits and images) are stored on IPFS, protected with InterPlanetary File System technology which has proven itself in such well-known projects as BAYC and CoolCats. Moreover, such a division helps us to keep protocol-level game mechanics and low gas fees, which are crucial for any project now, especially for games. You can always check out our smart contract source code that is available to everyone.

# **SECURITY**

On-chain game development carries some risks to the NFT owners and gamers. Solidity developers know that solidity smart contracts are completely deterministic. Anyone who figures out how your contract produces randomness can anticipate its results and use this information to exploit your application, as it occurred in the case of the famous Wolf Game.

There are a set of common practices to generate a random number in smart contracts, and only 2 approaches are actively used:

- Using block variables (like block.timestamp or block.number) with a combination of block hash and secret seed number. Such an approach can be exploited, and there is no guarantee the result is a truly random number.
- Using third-party dependencies like Oraclize or Chainlink - it would be 100% random off-chain generation and cannot be exploited. Though it is expected to pay an extra fee for each random number generation. In our game it is used not only on mint transactions, but for stacking and unstacking transactions. The gas fees and the total mint cost will be increased drastically.

In our approach, we are using a brand-new way to generate a random number and we are nearly positive the exploit risk is almost eliminated.

The way it is developed is a tricky combination of a common way of using a keccak256 hash function and multiple unpredictable values on the blockchain. There are billions of transactions in the blockchain generated each second, and no one can 100% predict when a certain one will be processed and verified within a certain time. So we use that information based on balances of multiple top Ethereum exchange accounts - and these balances are changing almost every second.

Hackers cannot predict and calculate that in a certain timestamp, the overall balance of a set of different wallets equals the desired value. However, even these truly unpredictable and hard-to-calculate values are not 100% guarantee that random function will not be exploited.

Assuming that we have added one more extra security layer to our solution - each random call uses an extra seed number, which is changed by the previous random call. Moreover, this seed number will be randomly changed from time to time, so to figure out a new number is an incredibly difficult task. In summation, we believe that the new multi-layered approach to contract defense excludes the possibility of RNG exploit.

Another popular exploit is the reentrancy bug. A reentrancy attack occurs when the attacker exploits the targeted contract by recursively calling the target’s functions. When the contract fails to update its state prior to sending funds or minting, the attacker can continuously call the function to drain the contract’s funds or to mint an unlimited number of NFTs.

To prevent this from happening, we reviewed the code several times and improved the quality of the original contract to exclude any possibility of reentrancy exploitation.