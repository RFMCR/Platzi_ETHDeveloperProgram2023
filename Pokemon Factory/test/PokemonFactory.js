const { expect } = require("chai"); //Gestor de pruebas en JS
const { ethers } = require("hardhat"); //Libreria para smart contracts con Solidity

//Descripcion de la prueba
describe("Pokemon Factory Contract", () => {
  //Descripcion de lo que hace el método
  it("Should create 2 new Habilities", async () => {
    //Para interactuar con contratos inteligentes ocupamos la libreria ethers
    //GetContractFactory se usa para generar el contrato
    const PokemonFactoryContract = await ethers.getContractFactory("PokemonFactory");
    //Desplegar el contrato para probarlo
    //Deploy llama al constructor del contrato
    const contract = await PokemonFactoryContract.deploy();
    
    //Llamar al metodo de crear Habilidades
    await contract.create_Hability("Habilidad 1","Lanza Habilidad 1 al oponente");
    
    await contract.create_Hability("Habilidad 2","Lanza Habilidad 2 al oponente");
    
    //Inocamos el metodo para incrementar el contador
    const habilities = await contract.show_Hability_List();

    //Realizamos la prueba con Chai de que el valor este correcto
    //Basicamente es un assertion
    expect(habilities.length).to.equal(2);
  });

  it("Should create two new Types", async () => {
    const PokemonFactoryContract = await ethers.getContractFactory("PokemonFactory");
    const pokemonfactorydeploy = await PokemonFactoryContract.deploy();

    await pokemonfactorydeploy.create_Type("Type 1","Pokemon Tipo 1");
    await pokemonfactorydeploy.create_Type("Type 2","Pokemon Tipo 2");

    const habilities = await pokemonfactorydeploy.show_Type_List();
    
    expect(habilities.length).to.equal(2);
  });
  
  it("Should create two new Pokemon", async () => {

    const PokemonFactoryContract = await ethers.getContractFactory("PokemonFactory");
    const pokemonfactorydeploy = await PokemonFactoryContract.deploy();

    await pokemonfactorydeploy.createPokemon("Pokemon 1",1,[0],[0,1],[2]);
    await pokemonfactorydeploy.createPokemon("Pokemon 2",2,[1,2],[0],[0,2]);

    const pokemon = await pokemonfactorydeploy.getAllPokemons();

    expect(pokemon.length).to.equal(2);
  });
  
});
