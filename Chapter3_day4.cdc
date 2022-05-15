// 1. Interfaces can be used for 2 things:
// - They can be used to set the requirements for when they are to be used
// - They allows you to restrict access to different elements of your resources or struct and only show or give access to what you want


// 2.
pub contract Stuff {

    pub resource interface IPerson {
      pub var name: String
      pub var age: Int
    }

    pub resource Person: IPerson {
      pub var name: String
      pub var age: Int

      pub fun updateAge(newAge: Int): Int {
        self.age = newAge
        return self.age // returns the new number
      }

      init() {
        self.name = "Jacob"
        self.age = 1
      }
    }
    
    // This works
    pub fun noInterface() {
      let test: @Person <- create Person()
      test.updateAge(newAge: 20)
      log(test.age) // 5

      destroy test
    }

    //This doesn't work
    pub fun yesInterface() {
      let test: @Person{IPerson} <- create Person()
      let newAge = test.updateAge(newAge: 5) // ERROR: `member of restricted type is not accessible: updateNumber`
      log(newAge)

      destroy test
    }
}

//3.
pub contract Stuff {

    pub struct interface ITest {
      pub var greeting: String
      pub var favouriteFruit: String
      pub fun changeGreeting(newGreeting: String): String
      pub fun changeFruit(newFruit: String): String
    }

    // ERROR:
    // `structure Stuff.Test does not conform 
    // to structure interface Stuff.ITest`
    pub struct Test: ITest {
      pub var greeting: String
      pub var favouriteFruit: String

      pub fun changeGreeting(newGreeting: String): String {
        self.greeting = newGreeting
        return self.greeting // returns the new greeting
      }
      pub fun changeFruit(newFruit: String): String {
        self.favouriteFruit = newFruit
        return self.favouriteFruit // returns the new fruit
      }

      init() {
        self.greeting = "Hello!"
        self.favouriteFruit = "orange"
      }
    }

    pub fun fixThis() {
      let test: Test{ITest} = Test()
      let newGreeting = test.changeGreeting(newGreeting: "Bonjour!")
      let newFruit = test.changeFruit(newFruit: "Apple!") 
      log(newGreeting)
      log(newFruit)
    }
}
