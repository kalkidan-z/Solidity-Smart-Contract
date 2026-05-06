// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

contract Voting {

    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;

    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));
    }

    function castVote(uint proposalId, bool support) external {
        Proposal storage p = proposals[proposalId];

        if (support) {
            p.yesCount += 1;
        } else {
            p.noCount += 1;
        }
    }
}