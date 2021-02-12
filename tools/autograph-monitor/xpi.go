package main

import (
	"log"

	"go.mozilla.org/autograph/signer/xpi"
)

func verifyXPISignature(sig string) error {
	xpiSig, err := xpi.Unmarshal(sig, []byte(inputdata))
	if err != nil {
		log.Fatal(err)
	}
	err = xpiSig.VerifyWithChain(conf.truststore)
	if err == nil {
		return nil
	}
	log.Printf("Got error %s verifying XPI signature with rel truststore trying dep truststore", err)
	return xpiSig.VerifyWithChain(conf.depTruststore)
}
