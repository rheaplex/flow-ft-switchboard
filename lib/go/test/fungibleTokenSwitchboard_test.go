package test

// go test -timeout 30s . -run ^TestNFTStorefront -v

import (
	"testing"
)

func TestSwitchboardDeployContracts(t *testing.T) {
	b := newEmulator()
	switchboardDeployContracts(t, b)
}

func TestSwitchboardInstallSwitchboard(t *testing.T) {
	b := newEmulator()

	contracts := switchboardDeployContracts(t, b)

	userAddress, userSigner := createAccount(t, b)
	installSwitchboard(t, b, userAddress, userSigner, contracts)
}
