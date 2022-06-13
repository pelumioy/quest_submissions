1. An event is a way for the smart contract to give updates to the outside world based on an action taken or modification made on the blockchain (i.e an NFT being minted).
the whole point of an event is so that other clients or frontend users can use this information to do other things on the frontend of the DAPP.


2.  pub contract Test {

  pub event PokemonNamed(name: String)

  pub resource NamePokemon {
    pub var name: String
    
    pub fun updateName(namee: String) {
    pre {
      namee.length > 0 : "Please type a proper name"
    }
    post {
      namee.length == 5 : "seems you typed in a 5 letter name"
    }
      self.name = namee
    }

    init() {
      self.name = ""

      emit PokemonNamed(name: self.name)
    }

  }

}



4. pub contract Test {

  // TODO
  // Tell me whether or not this function will log the name.
  // name: 'Jacob'
  pub fun numberOne(name: String) {
    pre {
      name.length == 5: "This name is not cool enough."
    }
    log(name)
  }
  // Yes the function will log Jacob because it passes the condition of being of 5 characters
  
  
  

  // TODO
  // Tell me whether or not this function will return a value.
  // name: 'Jacob'
  pub fun numberTwo(name: String): String {
    pre {
      name.length >= 0: "You must input a valid name."
    }
    post {
      result == "Jacob Tucker"
    }
    return name.concat(" Tucker")
  }
  // Yes it will return Jacob Tucker because it passes both conditions of having more than 1 character and also matching the name Jacob Tucker after being concatenated.
  
  
  

  pub resource TestResource {
    pub var number: Int

    // TODO
    // Tell me whether or not this function will log the updated number.
    // Also, tell me the value of `self.number` after it's run.
    pub fun numberThree(): Int {
      post {
        // This will fail because the result will be equals to 1 which isn't the original number before the function. It is meant to be "result - 1" 
        //  to check that the number before the function is run is one less than the new number after it is run.
        before(self.number) == result + 1
      }
      self.number = self.number + 1
      return self.number
    }
    init() {
      self.number = 0
    }

  }

}
