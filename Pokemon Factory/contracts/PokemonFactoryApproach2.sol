// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Hability{
    string name;
    string description;
  }

  struct Pokemon {
    uint id;
    string name;
    Hability[] habilities; //
  }

    event eventNewPokemon(address owner, string name, uint id);
        
    Pokemon[] private pokemons; //Lista de pokemones
    Hability[] private hability_List; //Lista de Habilidades

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    

    modifier nonzero(uint id) {
        if(id > 0)
            _;
        else
            revert("El Id debe ser mayor a 0");
    }

    modifier namelength(uint namelngt){
      if (namelngt>1)
      _;
      else
        revert("El nombre debe contener al menos dos caracteres");
    }
  
    function create_Hability(string memory _nombre, string memory _desc) public namelength(bytes (_nombre).length){
      hability_List.push(Hability(_nombre, _desc));
    }

    function show_Hability_List() public view returns (Hability[] memory){
      return hability_List;
    }

     function createPokemon (string calldata _name, uint _id, uint[] calldata _habilidades) public nonzero(_id) namelength(bytes(_name).length){

       Hability[] memory pokemon_habilities = new Hability[](_habilidades.length);
       for (uint i =0; i<_habilidades.length; i++){
         pokemon_habilities[i] = hability_List[_habilidades[i]];
       }

        pokemons.push(Pokemon(_id, _name, pokemon_habilities));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(msg.sender, "Se ha creado el pokemon",_id);
    }

    function get_Pokemon(uint _pokemonID) public view returns (Pokemon memory){
      return pokemons[_pokemonID];
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

/*
    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }
*/
}

//No funciona este aproach porque al parecer solidity no permite inicializar tipos de datos complejos como una estructura dentro de otra estructura