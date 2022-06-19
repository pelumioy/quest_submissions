1. What does "force casting" with as! do? Why is it useful in our Collection?

force casting with as! is used to take a more generic type and make it more specific by downcasting it and it's useful because it prevents people from depositing just any NFT into our collection. Let's imagine you store apples but not just any apples, only red apples. You wouldn;t want anyone dropping in any kind of apples even tho they're all under the same "apple" standard, you would need to specify the kind of apples that YOU collect, which in this case are red apples.

2. What does auth do? When do we use it?
   
 auth is used as a reference to allow downcasting of other more generic references.

3.

import NonFungibleToken from 0x02
pub contract CryptoPoops: NonFungibleToken {
    pub var totalSupply: UInt64

    pub event ContractInitialized()
    pub event Withdraw(id: UInt64, from: Address?)
    pub event Deposit(id: UInt64, to: Address?)

    pub resource NFT: NonFungibleToken.INFT {
        pub let id: UInt64

        pub let name: String
        pub let favouriteFood: String
        pub let luckyNumber: Int

        init(_name: String, _favouriteFood: String, _luckyNumber: Int) {
        self.id = self.uuid

        self.name = _name
        self.favouriteFood = _favouriteFood
        self.luckyNumber = _luckyNumber
        }
    }

    pub resource interface CollectionPublic {
        pub fun deposit(token: @NonFungibleToken.NFT)
        pub fun getIDs(): [UInt64]
        pub fun borrowNFT(id: UInt64): &NonFungibleToken.NFT
        pub fun borrowAuthNFT(id: UInt64): &NFT
    }

    pub resource Collection: NonFungibleToken.Provider, NonFungibleToken.Receiver, NonFungibleToken.CollectionPublic, CollectionPublic {
        pub var ownedNFTs: @{UInt64: NonFungibleToken.NFT}

        pub fun withdraw(withdrawID: UInt64): @NonFungibleToken.NFT {
        let nft <- self.ownedNFTs.remove(key: withdrawID) 
                ?? panic("This NFT does not exist in this Collection.")
        emit Withdraw(id: nft.id, from: self.owner?.address)
        return <- nft
        }

        pub fun deposit(token: @NonFungibleToken.NFT) {
        let nft <- token as! @NFT
        emit Deposit(id: nft.id, to: self.owner?.address)
        self.ownedNFTs[nft.id] <-! nft
        }

        pub fun getIDs(): [UInt64] {
        return self.ownedNFTs.keys
        }

        pub fun borrowNFT(id: UInt64): &NonFungibleToken.NFT {
        return &self.ownedNFTs[id] as &NonFungibleToken.NFT
        }

        pub fun borrowAuthNFT(id: UInt64): &NFT {
            let ref = &self.ownedNFTs[id] as auth &NonFungibleToken.NFT
            return ref as! &NFT
        }

        init() {
        self.ownedNFTs <- {}
        }

        destroy() {
        destroy self.ownedNFTs
        }
    }

    pub fun createEmptyCollection(): @NonFungibleToken.Collection {
        return <- create Collection()
    }

    pub resource Minter {

        pub fun createNFT(name: String, favouriteFood: String, luckyNumber: Int): @NFT {
        return <- create NFT(_name: name, _favouriteFood: favouriteFood, _luckyNumber: luckyNumber)
        }

        pub fun createMinter(): @Minter {
        return <- create Minter()
        }

    }

    init() {
        self.totalSupply = 0
        emit ContractInitialized()
        self.account.save(<- create Minter(), to: /storage/Minter)
    }
}

Transaction
import CryptoPoops from 0x02

transaction() {

    prepare(signer: AuthAccount) {
        let newCollection <- CryptoPoops.createEmptyCollection()
        signer.save(<- newCollection, to: /storage/MyCollection)

        signer.link<&CryptoPoops.Collection{CryptoPoops.CollectionPublic}>(/public/MyCollection, target: /storage/MyCollection)
    }
}


Mint and transfer
import CryptoPoops from 0x02

transaction(recipient: Address) {

    prepare(signer: AuthAccount) {
        let minter = signer.borrow<&CryptoPoops.Minter>(from: /storage/Minter) ?? panic("This signer is not the one who deployed the contract.")

        let recipientsCollection = getAccount(recipient).getCapability(/public/MyCollection).borrow<&CryptoPoops.Collection{CryptoPoops.CollectionPublic}>() ?? panic("the user does not have a collection")

        let nft <- minter.createNFT(name: "pelz", favouriteFood: "plantain", luckyNumber: 6)

        recipientsCollection.deposit(token: <- nft)
    }
}


Get ID
import CryptoPoops from 0x02

pub fun main(address: Address): [UInt64] {
    let recipientsCollection = getAccount(address).getCapability(/public/MyCollection).borrow<&CryptoPoops.Collection{CryptoPoops.CollectionPublic}>() ?? panic("the user does not have a collection")

    return recipientsCollection.getIDs()
}


import CryptoPoops from 0x02

pub fun main(address: Address): String {
    let recipientsCollection = getAccount(address).getCapability(/public/MyCollection).borrow<&CryptoPoops.Collection{CryptoPoops.CollectionPublic}>() ?? panic("the user does not have a collection")

    let recipientsNFT = recipientsCollection.borrowAuthNFT(id: 2)
    return "Name: ".concat(recipientsNFT.name).concat(", 
    my favourite food is ").concat(recipientsNFT.favouriteFood).concat(", 
    lucky number is ").concat(recipientsNFT.luckyNumber.toString())
}




