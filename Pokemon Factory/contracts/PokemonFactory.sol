// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
 
  struct Hability{
    string name;
    string description;
  }

  struct Type{
    string name;
    string description;
  }

  struct Pokemon {
    uint id;
    string name;
    uint[] habilities;     
    uint[] types; 
    uint[] types_weakness;
  }

    event eventNewPokemon(address owner, string name, uint id);
        
    Pokemon[] private pokemons; //Lista de pokemones
    Hability[] private hability_List; //Lista de Habilidades
    Type[] private type_List; //Lista de Tipos
    
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

    function create_Type(string memory _nombre, string memory _desc) public namelength(bytes (_nombre).length){
      type_List.push(Type(_nombre, _desc));
    }

    function show_Type_List() public view returns (Type[] memory){
      return type_List;
    }

    function createPokemon (string calldata _name, uint _id, uint[] calldata _habilidades,  uint[] calldata _tipos,  uint[] calldata _debilidad_tipos) public nonzero(_id) namelength(bytes(_name).length){
        pokemons.push(Pokemon(_id, _name, _habilidades,_tipos,_debilidad_tipos));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(msg.sender, "Se ha creado el pokemon",_id);
    }

    function get_Pokemon_Habilities(uint _pokemonID) public view returns (Hability[] memory){
      Hability[] memory pokemon_habilities= new Hability[](pokemons[_pokemonID].habilities.length);
      for (uint i =0; i<pokemons[_pokemonID].habilities.length; i++){
        pokemon_habilities[i] = hability_List[pokemons[_pokemonID].habilities[i]];
      }
      return pokemon_habilities;
    }

    function get_Pokemon_Types(uint _pokemonID) public view returns (Type[] memory){
      Type[] memory pokemon_types= new Type[](pokemons[_pokemonID].types.length);
      for (uint i =0; i<pokemons[_pokemonID].types.length; i++){
        pokemon_types[i] = type_List[pokemons[_pokemonID].types[i]];
      }
      return pokemon_types;
    }

    function get_Pokemon_Weakness_Types(uint _pokemonID) public view returns (Type[] memory){
      Type[] memory pokemon_weakness_types= new Type[](pokemons[_pokemonID].types_weakness.length);
      for (uint i =0; i<pokemons[_pokemonID].types_weakness.length; i++){
        pokemon_weakness_types[i] = type_List[pokemons[_pokemonID].types_weakness[i]];
      }
      return pokemon_weakness_types;
    }


    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }


    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}
