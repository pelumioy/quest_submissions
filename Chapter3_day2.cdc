// Resources & Arrays

pub contract Practice {
    pub var arrayOfFriends: @[Friend]

    pub resource Friend {
        pub let name: String
        init() {
            self.name = "Jacob"
        }
    }

    pub fun addFriend (friend: @Friend) {
        self.arrayOfFriends.append(<- friend)
    }

    pub fun removeFriend (index: Int): @Friend {
        return <- self.arrayOfFriends.remove(at: index)
    }
    
    init() {
        self.arrayOfFriends <- []
    }
 
}

// Resouces & Dictionaries

pub contract Dictionary {
    pub var dictionariesOfFriends: @{Int: Friend}

    pub resource Friend {
        pub let age: Int
        init() {
            self.age = 20
        }
    }

    pub fun addFriend (friend: @Friend) {
        let key = friend.age
        
        let oldFriend <- self.dictionariesOfFriends[key] <- friend
        destroy oldFriend
    }

    pub fun removeFriend (key: Int): @Friend {
        let friend <- self.dictionariesOfFriends.remove(key: key) ?? panic("You're not friends with this person!")
        return <- friend
    }

    init() {
        self.dictionariesOfFriends <- {}
    }
 
}
