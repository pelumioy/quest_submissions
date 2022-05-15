// reference ontract 
pub contract References {

    pub var dictionariesOfFriends: @{Int: Friend}

    pub resource Friend {
        pub let name: String
        init(_name: String) {
            self.name = _name
        }
    }

    pub fun getReference(key: Int): &Friend {
        return &self.dictionariesOfFriends[key] as &Friend
    }

    init() {
        self.dictionariesOfFriends <- {
            2: <- create Friend(_name: "Sam"), 
            3: <- create Friend(_name: "Angie")
        }
    }
}

// reference script
import References from 0x04

pub fun main(): String {
  let ref = References.getReference(key: 3)
  return ref.name // returns "English"
}

// References save developers time and effort by making it easier to interact with structs and resources without having to always moving them around.
