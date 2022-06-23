/* 1. .link() is responsible for linking and providing access, a resource located in the storage of a user's account to either a public path (meaning everyone will have access to this, or private path (meaning only selected people will have access). It takes in 2 parameters; the private or public path and the target path (account storage, only accessible by the owner) */


/* 2. A resource interface works by restricting access to the main resource, acting somewhat like an extension of the main resource and only allowing the end user to see and interact with it in the way the owner has set. This will be acheived by linking the location of the main resource (/storage/) to the path you want; either /private/ or /public/. */


3.  // Smart contract
pub contract Pokedex {

  pub resource interface IPokemon {
    pub var name: String
  }

  // `Test` now implements `ITest`
  pub resource Pokemon: IPokemon {
    pub var name: String
    pub var type: String

    pub fun changeName(newName: String) {
      self.name = newName
    }

    pub fun changeType(newType: String) {
      self.type = newType  
    }

    init() {
      self.name = "Charizard"
      self.type = "fire"

    }
  }

  pub fun createPokemon(): @Pokemon {
    return <- create Pokemon()
  }

}


// transaction to save and link the resource

import Pokedex from 0x01
transaction() {
  prepare(signer: AuthAccount) {
    // Save the resource to account storage
    signer.save(<- Pokedex.createPokemon(), to: /storage/MyPokesource)

    signer.link<&Pokedex.Pokemon{Pokedex.IPokemon}>(/public/MyPokedexResource, target: /storage/MyTestResource)
  }

  execute {

  }
}


// Transaction trying to access what wasn't made available
import Pokedex from 0x01
transaction(address: Address) {

  prepare(signer: AuthAccount) {

  }

  execute {
    let publicCapability: Capability<&Pokedex.Pokemon{Pokedex.IPokemon}> =
      getAccount(address).getCapability<&Pokedex.Pokemon{Pokedex.IPokemon}>(/public/MyPokedexResource)
    let testResource: &Pokedex.Pokemon{Pokedex.IPokemon} = publicCapability.borrow() ?? panic("The capability doesn't exist or you did not specify the right type when you got the capability.")

    testResource.changeName(newName: "Sarah")
  }
}




// Script accessing what is available
import Pokedex from 0x01
pub fun main(address: Address): String {
    let publicCapability: Capability<&Pokedex.Pokemon{Pokedex.IPokemon}> =
      getAccount(address).getCapability<&Pokedex.Pokemon{Pokedex.IPokemon}>(/public/MyPokedexResource)
    let testResource: &Pokedex.Pokemon{Pokedex.IPokemon} = publicCapability.borrow() ?? panic("The capability doesn't exist or you did not specify the right type when you got the capability.")

    return testResource.name
 
}






