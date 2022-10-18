// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";

contract Voting  is Ownable {


event VoterRegistered(address voterAddress); 
event WorkflowStatusChange(WorkflowStatus previousStatus, WorkflowStatus newStatus);
event ProposalRegistered(uint proposalId);
event Voted (address voter, uint proposalId);

/* Liste des adresses des electeurs */
mapping(address => bool) whitelist;

/* Liste des propositions */
mapping(uint => bool) proposals;

/* Variable status  */
WorkflowStatus public Status;

enum WorkflowStatus {
    RegisteringVoters,
    ProposalsRegistrationStarted,
    ProposalsRegistrationEnded,
    VotingSessionStarted,
    VotingSessionEnded,
    VotesTallied
}

struct Voter {
    bool isRegistered;
    bool hasVoted;
    uint votedProposalId;
}

struct Proposal {
    string description;
    uint voteCount;
    uint proposalId;
}




function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
}

    function registerVoter(address id) public onlyOwner {
        whitelist[id] = true;
    }

    function registerProposal(uint id) public onlyOwner {
        proposals[id] = true;
    }
 
     function voteProposal(uint id) public  {
         require(whitelist[msg.sender] == true, "Le voter ne fais pas partie e la whitelist !");
         //TODO
    }

    function startVotingSession(address id) public onlyOwner {
        //TODO
    }

    function endVotingSession(uint id) public onlyOwner {
        //TODO
    }

}
