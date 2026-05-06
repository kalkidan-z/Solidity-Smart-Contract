// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {

    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
        bool executed;
    }

    Proposal[] public proposals;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    mapping(address => bool) public isMember;

    constructor(address[] memory members) {
        isMember[msg.sender] = true;

        for (uint i = 0; i < members.length; i++) {
            isMember[members[i]] = true;
        }
    }

    function newProposal(address target, bytes calldata data) external {
        require(isMember[msg.sender], "Not a member");

        proposals.push(Proposal({
            target: target,
            data: data,
            yesCount: 0,
            noCount: 0,
            executed: false
        }));

        emit ProposalCreated(proposals.length - 1);
    }

    mapping(uint => mapping(address => bool)) public hasVoted;
    mapping(uint => mapping(address => bool)) public voteChoice;

    function castVote(uint proposalId, bool support) external {
        require(isMember[msg.sender], "Not a member");

        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Already executed");

        if (hasVoted[proposalId][msg.sender]) {
            bool previousChoice = voteChoice[proposalId][msg.sender];

            if (previousChoice) {
                proposal.yesCount--;
            } else {
                proposal.noCount--;
            }
        }

        if (!hasVoted[proposalId][msg.sender]) {
            hasVoted[proposalId][msg.sender] = true;
        }

        voteChoice[proposalId][msg.sender] = support;

        if (support) {
            proposal.yesCount++;
        } else {
            proposal.noCount++;
        }

        emit VoteCast(proposalId, msg.sender);

        //  EXECUTION 
        if (!proposal.executed && proposal.yesCount >= 10) {
            proposal.executed = true;

            (bool success, ) = proposal.target.call(proposal.data);
            require(success, "Execution failed");
        }
    }
}