const Voting = artifacts.require("./Voting.sol");
const { BN, expectRevert, expectEvent } = require('@openzeppelin/test-helpers');
const { expect } = require('chai');



contract('Voting', accounts => {
    const owner = accounts[0];
    const second = accounts[1];
    const third = accounts[2];

    let VotingInstance;

    describe("test votes/proposals", function () {

        before(async function () {
            VotingInstance = await Voting.new({from:owner});
        });

        it("should add voter", async () => {
            await VotingInstance.addVoter(owner, { from: owner });
            const storedData = await VotingInstance.getVoter(owner);
            expect(storedData.isRegistered).to.equal(true);
        });

        it("add voter already done, getVoter", async () => {
            const storedData = await VotingInstance.getVoter(owner);
            expect(storedData.isRegistered).to.equal(true);
        });

        it("Start proposal registering, getOneProposal", async () => {
            await VotingInstance.startProposalsRegistering();
            const storedData = await VotingInstance.getOneProposal(0);
            expect(storedData.description).to.equal("GENESIS");
        });

        it("Add proposal", async () => {
            await VotingInstance.addProposal("First proposal");
            await VotingInstance.addProposal("Second proposal");
            const storedData = await VotingInstance.getOneProposal(2);
            expect(storedData.description).to.equal("Second proposal");
        });

        it("SetVote", async () => {
            await VotingInstance.endProposalsRegistering();
            await VotingInstance.startVotingSession();
            
            await VotingInstance.setVote(0);
            const storedData = await VotingInstance.getVoter(owner);
            expect(storedData.hasVoted).to.equal(true);
        });

    });

});