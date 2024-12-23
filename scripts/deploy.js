const{ethers, upgrades} = require('hardhat');

async function main(){

const[deployer] = await ethers.getSigners();

console.log("Deploying the contract with the account:", deployer.address);

//Deploy the Voting Contract(Logic)
const Voting = await ethers.getContractFactory('Voting');
const voting = await upgrades.deployProxy(Voting, ["2026 CM Election"],{
    initializer: "initialize",
    kind: "uups",
});
const VotingAddress = await voting.getAddress();

console.log(`Voting Token deployed to: ${VotingAddress}`)

//Deploy the Beacon Contract
const VotingBeacon = await ethers.getContractFactory('VotingBeacon');
const votingBeacon = await upgrades.deployProxy(VotingBeacon,[VotingAddress], {
    initializer: "initialize",
    kind: "uups"
})

const BeaconAddress = await votingBeacon.getAddress();
console.log(`Beacon address deployed to: ${BeaconAddress}`);
}
main().catch((error) =>{
    console.error(error);
    process.exit(1);
})
