1. We added a collection to the contract to allow for multiple items to be stored in the same storage path.

2. You would have to use the destroy function to destroy those nested resources.

3. - Set some conditions so not just anyone will be able to mint
   - Put nft data into a struct rather than a resource
