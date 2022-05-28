1. What lives in an account are as follows: 
    - Contract code: This is the smart contract you have deployed with the said account.
    - Account storage: This is where all your data is stored and it contains 3 different paths to get certain data.

2. Difference between the 3 paths:
    - /storage/: Only the owner of the account can access whatever data is stored here
    - /public/: This is for data that anyone can have access to.
    - /private/: This is for data that only the owner has access to(duh) but can also give access to other people if they want to.

3.  - .save() is used to save data to the account storage and can only be done by the owner (signer). whateer is saved here is saved to a /storage/ path.
    - .load() is used to extract data from the account storage
    - .borrow() is used inline with a reference to basically borrow some data from the account. This way, the data can be viewed but also restricts some access to it.

4. This is because saving data to the account storage requires a transaction due to the fact that it modifies the blockchain and you cannot perform transactions in a script.

5. You cannot save to another person's account because you do not have that person's authaccount used for signing and giving approval to perform such actions.

6. Contract:
    pub contract Test {

      pub resource Food {
        pub var name: String
        init() {
          self.name = "Pasta"
        }
      }

      pub fun createFood(): @Food {
        return <- create Food()
      }

    }
    
 i) import Test from 0x02
    transaction() {
      prepare(signer: AuthAccount) {
        let foodResource <- Test.createFood()
        signer.save(<- foodResource, to: /storage/MyFoodResource) 
        let testResources <- signer.load<@Test.Food>(from: /storage/MyFoodResource)
                              ?? panic("A `@Test.Food` resource does not live here.")
        log(testResources.name) // "Jacob"

        destroy testResources
      }

      execute {

      }
    }
    
 
 ii) import Test from 0x02
      transaction() {
        prepare(signer: AuthAccount) {
          let foodResource <- Test.createFood()
          signer.save(<- foodResource, to: /storage/MyFoodResource) 
          let testResources = signer.borrow<&Test.Food>(from: /storage/MyFoodResource)
                                ?? panic("A `@Test.Food` resource does not live here.")
          log(testResources.name) // "Jacob"

        }

        execute {

        }
      }
