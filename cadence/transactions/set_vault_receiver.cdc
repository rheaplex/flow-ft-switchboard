import FungibleToken from "../contracts/FungibleToken.cdc"
import FungibleTokenSwitchboard from "../contracts/FungibleTokenSwitchboard.cdc"

// NOTE: This is for the simple case where the Vault Type is the same as the Vault Capability.
//       Circumstances where this may not be the case include using a forwarder.
//       You will need to create a transaction to handle this case, but do be aware it exists.

transaction(recipientPath: PublicPath) {

    let switchboardRef: &FungibleTokenSwitchboard.Switchboard
    let recipientCapability: Capability<&{FungibleToken.Receiver}>
    let vaultType: Type

    prepare(acct: AuthAccount) {
        self.switchboardRef = acct.borrow<&FungibleTokenSwitchboard.Switchboard>(from: FungibleTokenSwitchboard.SwitchboardStoragePath)
			?? panic("Could not borrow reference to the Switchboard!")

        self.recipientCapability = acct.getCapability<&{FungibleToken.Receiver}>(recipientPath)

        // Note that we don't ?? a nice message if the capability cannot be borrowed
        // This could be added if desired
        self.vaultType = self.recipientCapability.borrow()!.getType()
    }

    execute {
        self.switchboardRef.setVaultRecipient(self.recipientCapability, vaultType: self.vaultType)
    }
}
