import FungibleTokenSwitchboard from "../contracts/FungibleTokenSwitchboard.cdc"

pub fun main(account: Address): [Type] {
    let acct = getAccount(account)
    let switchboardRef = acct.getCapability(FungibleTokenSwitchboard.SwitchboardPublicPath)
        .borrow<&FungibleTokenSwitchboard.Switchboard{FungibleTokenSwitchboard.SwitchboardPublic}>()
        ?? panic("Could not borrow Public reference to the Switchboard")

    return switchboardRef.acceptsVaultTypes()
}
