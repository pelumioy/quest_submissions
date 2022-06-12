pub contract CryptoPoops {
  pub var totalSupply: UInt64

  // This is an NFT resource that contains a name,
  // favouriteFood, and luckyNumber
  pub resource NFT {
    pub let id: UInt64

    pub let name: String
    pub let favouriteFood: String
    pub let luckyNumber: Int
  
    // Initialise the Nft upon deployment
    init(_name: String, _favouriteFood: String, _luckyNumber: Int) {
      self.id = self.uuid

      self.name = _name
      self.favouriteFood = _favouriteFood
      self.luckyNumber = _luckyNumber
    }
  }

  // This is a resource interface that gives us access and allows us to deposit, get the id of and borrow an NFT.
  pub resource interface CollectionPublic {
    pub fun deposit(token: @NFT)
    pub fun getIDs(): [UInt64]
    pub fun borrowNFT(id: UInt64): &NFT
  }

  // This is a collection which allows for the storage of multiple nfts to the same account storage path
  pub resource Collection: CollectionPublic {
    pub var ownedNFTs: @{UInt64: NFT}
  
    // function that deposits or adds an nft to a collection
    pub fun deposit(token: @NFT) {
      self.ownedNFTs[token.id] <-! token
    }
    
    // function that withdraws an nft with a specific ID from the collection
    pub fun withdraw(withdrawID: UInt64): @NFT {
      let nft <- self.ownedNFTs.remove(key: withdrawID) 
              ?? panic("This NFT does not exist in this Collection.")
      return <- nft
    }
    
    // use to get all the NFTs owned by a user
    pub fun getIDs(): [UInt64] {
      return self.ownedNFTs.keys
    }
    
    // returns a reference to a Specific NFT by ID
    pub fun borrowNFT(id: UInt64): &NFT {
      return &self.ownedNFTs[id] as &NFT
    }
     // Initialise and empty collection
    init() {
      self.ownedNFTs <- {}
    }
    
    
    // destroy any nested resources
    destroy() {
      destroy self.ownedNFTs
    }
  }
  
  
  // created an empty collection where nfts will be stored
  pub fun createEmptyCollection(): @Collection {
    return <- create Collection()
  }
  
  
  // Minter resource to allow owner to create a minter and mint an NFT
  pub resource Minter {
     
     // Mint NFT
    pub fun createNFT(name: String, favouriteFood: String, luckyNumber: Int): @NFT {
      return <- create NFT(_name: name, _favouriteFood: favouriteFood, _luckyNumber: luckyNumber)
    }
    
    
    // Create new Minter
    pub fun createMinter(): @Minter {
      return <- create Minter()
    }

  }

  // initialise contract, set total supply to 0 and save the minter resource to the account that deploys the contract
  init() {
    self.totalSupply = 0
    self.account.save(<- create Minter(), to: /storage/Minter)
  }
}
