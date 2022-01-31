package test

import (
	"github.com/onflow/flow-go-sdk"
)

const (
	switchboardRootPath     = "../../../cadence"
	switchboardContractPath = switchboardRootPath + "/contracts/FungibleTokenSwitchboard.cdc"

	switchboardTransactionsPath = switchboardRootPath + "/transactions"
	installSwitchboardPath      = switchboardTransactionsPath + "/install_switchboard.cdc"
	removeVaultReceiverPath     = switchboardTransactionsPath + "/remove_vault_receiver.cdc"
	setVaultReceiverPath        = switchboardTransactionsPath + "/set_vault_receiver.cdc"

	switchboardScriptsPath   = switchboardRootPath + "/scripts"
	getAcceptsVaultTypesPath = switchboardScriptsPath + "/get_accepts_vault_types.cdc"
)

func replaceAddresses(codeBytes []byte, contracts Contracts) []byte {
	code := string(codeBytes)

	code = ftAddressPlaceholder.ReplaceAllString(code, "0x"+ftAddress.String())
	//code = flowTokenAddressPlaceHolder.ReplaceAllString(code, "0x"+flowTokenAddress.String())
	code = switchboardAddressPlaceholder.ReplaceAllString(code, "0x"+contracts.SwitchboardAddress.String())

	return []byte(code)
}

func loadSwitchboard(ftAddr flow.Address) []byte {
	code := string(readFile(switchboardContractPath))

	code = ftAddressPlaceholder.ReplaceAllString(code, "0x"+ftAddr.String())

	return []byte(code)
}

func switchboardGenerateInstallSwitchboardScript(contracts Contracts) []byte {
	return replaceAddresses(
		readFile(installSwitchboardPath),
		contracts,
	)
}

func switchboardGenerateRemoveVaultReceiverScript(contracts Contracts) []byte {
	return replaceAddresses(
		readFile(removeVaultReceiverPath),
		contracts,
	)
}

func switchboardGenerateSetVaultReceiverScript(contracts Contracts) []byte {
	return replaceAddresses(
		readFile(setVaultReceiverPath),
		contracts,
	)
}

func switchboardGenerateGetAcceptsVaultTypesPathScript(contracts Contracts) []byte {
	return replaceAddresses(
		readFile(getAcceptsVaultTypesPath),
		contracts,
	)
}
