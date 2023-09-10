# Ethers.js

Created: January 26, 2022 10:53 PM
Updated: October 4, 2022 7:01 PM

SELECT NETWORK

```solidity
var provider = new ethers.providers.Web3Provider(
  web3.currentProvider,
  "ropsten"
);
```

VARS YOU MIGHT NEED

```solidity
var MoodContractAddress = "<contract address>";
  var MoodContractABI = <contract ABI>
  var MoodContract
  var signer
```

CREATE CONTRACT OBJECT TO CONNECT

```solidity
MoodContract = new ethers.Contract(
    MoodContractAddress,
    MoodContractABI,
    signer
```

EX: CONNECTING FUNCTIONS

```solidity
async function getMood() {
  getMoodPromise = MoodContract.getMood();
  var Mood = await getMoodPromise;
  console.log(Mood);
}
```

EX: CONNECTING TO DOM

```solidity
async function setMood() {
  let mood = document.getElementById("mood").value;
  setMoodPromise = MoodContract.setMood(mood);
  await setMoodPromise;
}
```