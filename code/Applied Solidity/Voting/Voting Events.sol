pragma solidity ^0.8.20;

contract Voting {

    
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;

  
    mapping(uint => mapping(address => bool)) public hasVoted;
    mapping(uint => mapping(address => bool)) public voteChoice;

   
    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

   
    function newProposal(address _target, bytes calldata _data) external {

        proposals.push(
            Proposal({
                target: _target,
                data: _data,
                yesCount: 0,
                noCount: 0
            })
        );

        emit ProposalCreated(proposals.length - 1);
    }

   
    function castVote(uint proposalId, bool support) external {

        Proposal storage p = proposals[proposalId];

        // If already voted → remove old vote
        if (hasVoted[proposalId][msg.sender]) {
            bool previousVote = voteChoice[proposalId][msg.sender];

            if (previousVote) {
                p.yesCount -= 1;
            } else {
                p.noCount -= 1;
            }
        }

        // store new vote
        hasVoted[proposalId][msg.sender] = true;
        voteChoice[proposalId][msg.sender] = support;

        // apply new vote
        if (support) {
            p.yesCount += 1;
        } else {
            p.noCount += 1;
        }

        emit VoteCast(proposalId, msg.sender);
    }
}