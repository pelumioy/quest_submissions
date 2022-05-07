// quest 1
pub fun main() {
    var friends: [String] = ["Casey", "Kamsi", "Muna"]
    log(friends)
}

// quest 2
pub fun main() {
    var socials: {String: UInt64} = {"Facebook": 1, "Instagram": 1, "Twitter": 1, "YouTube": 1, 
    "Reddit": 0, "LinkedIn": 1}
}

// Quest 3
// The force-unwrap operator unwraps an optional type and checks if it is nil or has the right type assigned to it. 
// If nil the script will panic and end, if not then it carries on. Example below:
pub fun main() {
    var num: Int? = 34
    var unwrappedNum: Int = num!
    log(unwrappedNum)
}

// Quest 4
// The error means that there is a mismatch between the expected output and what was actually gotten (kinda like expecting an apple but get a pear)
// The error is there because by default, the value returned from a dictionary is a optional type, and what is expected is a string. 
// To fix this, all we have to do is add the force-unwrap operator "!" to the end of the return function. Doing this will unwrap it, check for the value (if nill or not) and then removes the optional type.
