// contract
pub contract BookStore {

    pub var books: {UInt64: Book}
    
    pub struct Book {
        pub let bookId: UInt64
        pub let author: String
        pub let bookName: String
        pub let desc: String

        init(_bookId: UInt64, _author: String, _bookName: String, _desc: String) {
            self.bookId = _bookId
            self.author = _author
            self.bookName = _bookName
            self.desc = _desc
        }
    }

    pub fun addBook(bookId: UInt64, author: String, bookName: String, desc: String) {
        let newBook = Book(_bookId: bookId, _author: author, _bookName: bookName, _desc:desc)
        self.books[bookId] = newBook
    }

    init() {
        self.books = {}
    }

}


// transaction
import BookStore from 0x02

transaction(bookId: UInt64, author: String, bookName: String, desc: String) {

    prepare(signer: AuthAccount) {}

    execute {
        BookStore.addBook(bookId: bookId, author: author, bookName: bookName, desc: desc)
        log("We're done.")
    }
}



// script
import BookStore from 0x02

pub fun main(bookId: UInt64): BookStore.Book {
    return BookStore.books[bookId]!
}

