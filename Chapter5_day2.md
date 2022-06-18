1. Standards are beneficial to the flow ecosystem because it creates a set of rules and requirements which not only make things easier, but also allow for interoperability when it comes to certain things like tokens and NFTs. As a result of standards, you can go to a marketplace on flow and it would pick up on the token you own and allow you to carry out various actions with it. All with the same codebase and functionalities. 

2. Plantains haha...

3. pub contract Test: ITest {
  pub var number: Int
  
  pub fun updateNumber(newNumber: Int) {
    self.number = newNumber
  }

  pub resource interface IStuff {
    pub var favouriteActivity: String
  }

  pub resource Stuff: ITest.IStuff {
    pub var favouriteActivity: String

    init() {
      self.favouriteActivity = "Playing League of Legends."
    }
  }

  init() {
    self.number = 0
  }
}
