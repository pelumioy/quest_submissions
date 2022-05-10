1) 3 reasons structs are different from resources:
- Structs are less secure than resources
- structs can be created outside of the contract, whereas, resources can only be created within the contract
- structs can be copied easily while resources cannot be copied

2) A situation where resources would be more suitable than structs would be when dealing with tokens, both fungible and non fungible token. 
They hold value and so you would want to make sure they are as secure as possible.

3)Create

4)No it can't. It can only be created within a contract.

5)Type public

pub contract Test {
    pub resource Jacob {
        pub let rocks: Bool
        init() {
            self.rocks = true
        }
    }

    pub fun createJacob(): @Jacob { // there is 1 here
        let myJacob <- create Jacob() // there are 2 here
        return <- myJacob // there is 1 here
    }
}
