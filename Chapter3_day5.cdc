access(all) contract SomeContract {
    pub var testStruct: SomeStruct

    pub struct SomeStruct {

        //
        // 4 Variables
        //

        pub(set) var a: String

        pub var b: String

        access(contract) var c: String

        access(self) var d: String

        //
        // 3 Functions
        //

        pub fun publicFunc() {}
        //Function Access Scope - can be called from anywhere
        
        access(contract) fun contractFunc() {}
        //Function Access Scope - Current, Inner & Containing Contract 
        // can be called on functions #1 (structFunc()), #2 (resourceFunc()), & #3 (questsAreFun)

        access(self) fun privateFunc() {}
        //Function Access Scope - Current & Inner
        // can only be called on function #1 (structFunc())


        pub fun structFunc() {
             
             //Variable A
             //Read Scope - All
             //Write Scope - All
             
             //Variable B
             //Read Scope - All
             //Write Scope - All
             
             //Variable C
             //Read Scope - All
             //Write Scope - All
             
             //Variable D
             //Read Scope - All
             //Write Scope - All
        }

        init() {
            self.a = "a"
            self.b = "b"
            self.c = "c"
            self.d = "d"
        }
    }

    pub resource SomeResource {
        pub var e: Int

        pub fun resourceFunc() {
             //Variable A
             //Read Scope - All
             //Write Scope - All
             
             //Variable B
             //Read Scope - All
             //Write Scope - can't write
             
             //Variable C
             //Read Scope - All
             //Write Scope - can't write
             
             //Variable D
             //Read Scope - can't read
             //Write Scope - can't write
        }

        init() {
            self.e = 17
        }
    }

    pub fun createSomeResource(): @SomeResource {
        return <- create SomeResource()
    }

    pub fun questsAreFun() {
             //Variable A
             //Read Scope - All
             //Write Scope - All
             
             //Variable B
             //Read Scope - All
             //Write Scope - can't write
             //Variable C
             //Read Scope - All
             //Write Scope - can't write
             
             //Variable D
             //Read Scope - can't read
             //Write Scope - can't write
    }

    init() {
        self.testStruct = SomeStruct()
    }
}


//Te script
import SomeContract from 0x01

pub fun main() {
             //Variable A
             //Read Scope - All
             //Write Scope - All
             
             //Variable B
             //Read Scope - All
             //Write Scope - Can't write
             
             //Variable C
             //Read Scope - Can't read
             //Write Scope - Can't write
             
             //Variable D
             //Read Scope - Can't read
             //Write Scope - Can't write
}
