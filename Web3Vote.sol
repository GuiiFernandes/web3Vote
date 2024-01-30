// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

struct Candidate {
    string photoUrl;
    string name;
    string politicalParty;
    uint number;
    uint votes;
}

struct Voting {
    string description;
    uint maxDate; //salva a data máxima da votação.
}

struct Vote {
    uint candidateNumber;
    uint date;
}

contract Web3Vote {
    address owner; //guarda o endereço do dono do contrato.balance;
    uint public currentVoting = 0; //id da votação atual
    uint nextCandidateId = 0;
    // Voting[] public votings;
    mapping(uint => Voting) public votings;
    mapping(uint => Candidate) public candidates;
    mapping(uint => mapping(uint => Candidate)) public candidatesInVoting;
    // Candidate[] public candidates;
    mapping(uint => mapping(address => Vote)) public votes; //Cria uma matriz de voto, assim pego votes[idVoting][address]

    constructor() { //Assim como em classe o constructor é chamado apenas na criação do projeto.
        owner = msg.sender; //msg.sender trás o endereço de quem registrou o contrato
        //salvando o endereço de quem registrou o contrato no owner. Temos o endereço do administrador salvo.
    }

    function createVoting(uint timeToVote, string memory description) public {
        require(msg.sender == owner, "usuario sem permissao");
        if (votings[0].maxDate != 0) currentVoting++;

        Voting memory newVoting;
        newVoting.description = description;
        newVoting.maxDate = timeToVote + block.timestamp;
        votings[currentVoting] = newVoting;
    }

    function createCandidate(string memory name, string memory photoUrl, string memory politicalParty, uint number) public {
        require(msg.sender == owner, "usuario sem permissao");
        Candidate memory newCandidate;
        newCandidate.name = name;
        newCandidate.photoUrl = photoUrl;
        newCandidate.politicalParty = politicalParty;
        newCandidate.number = number;
        candidates[nextCandidateId] = newCandidate;
        nextCandidateId++;
    }

    function addCandidateInVoting(uint candidateId, uint votingIndex) public {
        require(msg.sender == owner, "usuario sem permissao");
        require(votings[votingIndex].maxDate != 0, "Eleicao invalida, escolha uma opcao valida.");
        require(candidates[candidateId].number != 0, "Candidato nao cadastrado");
        uint candidateNumber = candidates[candidateId].number;
        require(candidatesInVoting[votingIndex][candidateNumber].number != candidateNumber, "Ja existe um candidato com esse numero nessa votacao");
        
        candidatesInVoting[votingIndex][candidateNumber] = candidates[candidateId];
    }

    function addVote(uint candidateNumber, uint votingIndex) public {
        require(votings[votingIndex].maxDate != 0, "Votacao invalida");
        require(votings[votingIndex].maxDate > block.timestamp, "votacao encerrada");
        require(votes[votingIndex][msg.sender].date == 0, "usuario ja votou nessa votacao");
        require(candidatesInVoting[votingIndex][candidateNumber].number != 0, "Numero de candidato invalido para essa votacao");
        
        candidatesInVoting[votingIndex][candidateNumber].votes++;
        votes[votingIndex][msg.sender].candidateNumber = candidateNumber;
        votes[votingIndex][msg.sender].date = block.timestamp;
    }
}