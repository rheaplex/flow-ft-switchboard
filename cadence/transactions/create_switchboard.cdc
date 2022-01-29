import FungibleToken from 0xFUNGIBLETOKENADDRESS
import FungibleTokenSwitchboard from 0xSWITCHBOARDADDRESS

transaction() {

    prepare(acct: AuthAccount) {

        // Return early if the account already stores a Swiotchboard
        // FIXME: this should check to see if *anything* is at the path, rather than the correct type
        if acct.borrow<&FungibleTokenSwitchboard.Switchboard>(from: FungibleTokenSwitchboard.SwitchboardStoragePath) != nil {
            return
        }

        let switchboard <- FungibleTokenSwitchboard.createNewSwitchboard()
        acct.save(<-switchboard, to: FungibleTokenSwitchboard.SwitchboardStoragePath)

        acct.link<&FungibleTokenSwitchboard.Switchboard{FungibleToken.Receiver, FungibleTokenSwitchboard.SwitchboardPublic}>(
            FungibleTokenSwitchboard.SwitchboardPublicPath,
            target: FungibleTokenSwitchboard.SwitchboardStoragePath
        )
    }
}
