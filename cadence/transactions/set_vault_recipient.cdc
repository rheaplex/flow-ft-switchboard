import FungibleToken from 0xFUNGIBLETOKENADDRESS
import FungibleTokenSwitchboard from 0xSWITCHBOARDADDRESS

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
        self.switchboardRef.setVaultRecipient(self.recipientCapability, tokenType: self.vaultType)
    }
}
