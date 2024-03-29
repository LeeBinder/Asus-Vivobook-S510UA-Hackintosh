# _Wi-Fi & Bluetooth_

For the **Apple BCM94360CS2** and the **Fenvi BCM94360NG**, no extra kexts should be necessary - you should even be able to remove *AirportBrcmFixup.kext*. For more details read [whatnameisit's findings about it](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/issues/46#issuecomment-592947028), bullet '2.' of his comment.

Below instructions apply to the **DW1560** and the **FRU 04X6020**:

### Catalina, Big Sur, Monterey:
- AirportBrcmFixup.kext, BrcmFirmwareData.kext, **BrcmBluetoothInjector.kext**, BrcmPatchRAM**3**.kext,

### Notes:

1. Recommended: set your country code in config.plist (and any other config you might use): `Boot/Arguments/brcmfx-country=` to your country. Example: `DE` for Germany

2. Neither the **DW1560** nor the F**RU 04X6020** need:

- BT4LEContinuityFixup.kext
- FakePCIID.kext
- FakePCIID\_Broadcom_Wifi.kext

**Infos credits**: whatnameisit, acidanthera, ReHabMan, Lee Binder

________________

### Excerpts from/ digest of https://github.com/acidanthera/BrcmPatchRAM

#### System Requirements:

- **BrcmPatchRAM3.kext**: 10.15+

	* if this kext is used, any accompanying kext()s (one of the BrcmPatchRAM; BrcmBluetoothInjector) ***must*** be installed to L/E, too, for optial reliability!
- **BrcmBluetoothInjector.kext**: 10.11 or later. Do NOT use BrcmPatchRAM or BrcmPatchRAM2 with this kext - they MUST be removed!
- BrcmPatchRAM.kext: 10.10 or earlier | BrcmPatchRAM2.kext: 10.11 - 10.14

#### Details:

The **BrcmBluetoothInjector**.kext is a codeless kernel extension which injects the BT hardware data using a plist; it does not contain a firmware uploader. You might want to try this kext as stand-alone first if you wish to see if your device will work without a firmware uploader.

#### Instructions for macOS Catalina and higher:

If you need to use **BrcmPatchRAM3**.kext (for macOS Catalina only), it requires **BrcmBluetoothInjector**.kext in addition, as changes in 10.15.x require the use of a separate injector kext. This is due to the removal of the following IOCatalogue methods:

*IOCatalogue::addDrivers, IOCatalogue::removeDrivers* and *IOCatalogue::startMatching*

Consequently, to have the native BT driver load for the device (BroadcomBluetoothHostControllerUSBTransport), we inject using a plist with a slightly lower IOProbeScore than BrcmPatchRAM3 so it doesn't probe before the firmware upload.
