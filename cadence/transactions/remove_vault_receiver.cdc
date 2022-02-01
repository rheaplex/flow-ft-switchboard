import FungibleTokenSwitchboard from "../contracts/FungibleTokenSwitchboard.cdc"

transaction(vaultType: Type) {

    let switchboardRef: &FungibleTokenSwitchboard.Switchboard

    prepare(acct: AuthAccount) {
        self.switchboardRef = acct.borrow<&FungibleTokenSwitchboard.Switchboard>(from: FungibleTokenSwitchboard.SwitchboardStoragePath)
			?? panic("Could not borrow reference to the Switchboard!")
    }

    execute {
        self.switchboardRef.removeVaultRecipient(vaultType: vaultType)
    }
}
