// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

struct Candidate {
    uint id;
    string photoUrl;
    string name;
    string politicalParty;
    uint number;
}

struct Voting {
    string description;
    uint maxDate; //salva a data máxima da votação.
    uint[] candidatesId;
    uint[] votes;
}

struct Vote {
    uint candidateId;
    uint date;
}

contract Web3Vote {
    address owner; //guarda o endereço do dono do contrato.balance;
    uint public currentVoting = 0; //id da votação atual
    uint nextCandidateId = 0;
    Voting[] public votings;
    Candidate[] public candidates;
    mapping(uint => mapping(address => Vote)) public votes; //Cria uma matriz de voto, assim pego votes[idVoting][address]

    constructor() { //Assim como em classe o constructor é chamado apenas na criação do projeto.
        owner = msg.sender; //msg.sender trás o endereço de quem registrou o contrato
        //salvando o endereço de quem registrou o contrato no owner. Temos o endereço do administrador salvo.
    }

    function createVoting(uint timeToVote, string memory description) public {
        require(msg.sender == owner, "usuario sem permissao");
        if (votings.length != 0) currentVoting++;

        Voting memory newVoting;
        newVoting.description = description;
        newVoting.maxDate = timeToVote + block.timestamp;
        newVoting.candidatesId = new uint[](0);
        votings.push(newVoting);
    }

    function getVoting() public view returns (Voting memory) {
        return votings[currentVoting];
    }

    function getVoting(uint index) public view returns (Voting memory) {
        if(index >= votings.length) revert("Eleicao invalida, escolha uma opcao valida.");
        return votings[index];
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    function getCandidate(uint id) public view returns (Candidate memory) {
        if(id > candidates.length) revert("Candidato invalido, escolha uma opcao valida.");
        return candidates[id];
    }

    function createCandidate(string memory name, string memory photoUrl, string memory politicalParty, uint number) public {
        require(msg.sender == owner, "usuario sem permissao");
        Candidate memory newCandidate;
        newCandidate.name = name;
        newCandidate.photoUrl = photoUrl;
        newCandidate.politicalParty = politicalParty;
        newCandidate.number = number;
        newCandidate.id = nextCandidateId;
        candidates.push(newCandidate);
        nextCandidateId++;
    }

    function addCandidateInVoting(uint candidateId, uint votingIndex) public {
        if(votingIndex >= votings.length) revert("Eleicao invalida, escolha uma opcao valida.");
        require(msg.sender == owner, "usuario sem permissao");
        for (uint i=0; i < votings[votingIndex].candidatesId.length; i++) {
            if(candidates[votings[votingIndex].candidatesId[i]].number == candidates[candidateId].number) revert("Ja existe um candidato com esse numero para essa votacao.");
        }
        votings[votingIndex].candidatesId.push(candidateId);
        votings[votingIndex].votes.push(0);
    }

    function addVote(uint candidateId, uint votingIndex) public {
        require(getVoting().maxDate > block.timestamp, "votacao encerrada");
        require(votes[votingIndex][msg.sender].date == 0, "usuario ja votou nessa votacao");
        int indexCandidate = -1;
        for (uint i=0; i < votings[votingIndex].candidatesId.length; i++) {
            if(votings[votingIndex].candidatesId[i] == candidateId) indexCandidate = int(i);
        }
        if(indexCandidate < 0) revert("candidato nao cadastrado para essa votacao");
        votings[votingIndex].votes[uint(indexCandidate)]++;
        votes[votingIndex][msg.sender].candidateId = candidateId;
        votes[votingIndex][msg.sender].date = block.timestamp;
    }
}