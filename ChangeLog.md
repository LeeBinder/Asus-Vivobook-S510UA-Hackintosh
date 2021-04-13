## [Release v.11.1, Apr. 14 2021](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/releases/tag/11.1) (pending)
- **MSR E2** ("_CFG Lock_") unlocking:
  - **Clover**: dropped `CFGLock.efi` and switched to `ControlMsrE2.efi` (now packaged with Clover)
  - **OC**: updated `ControlMsrE2.efi`
- **Adopted changes from [whatnameisit's VivoBook repo](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh)**:
  - **Sleep, Wake-from-Sleep, Shutdown Optimization**: added custom SSDT + 3 ACPI patches ¹. Added SSDT:
    - **OC**: ACPI/SSDT-PTSWAK-RP01_PEGP.aml
    - **Clover**: ACPI/patched/SSDT-PTSWAK-RP01_PEGP.aml

    _**Lots of KUDOS to whatnameisit for [his efforts](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/tree/main/docs/SSDT-PTSWAK-RP01_PEGP) which should also make this work on VivoBooks with Nvidia GeForce 940MX and tentatively other Nvidia Optimus dGPUs!**_
  - **Trackpad**: switched from polling to more energy friendly interrupts mode because UEFI BIOS 310 for x510UAR no longer appears to have flaws in the GPIO. Make sure you run your VivoBook with the latest BIOS! ¹
    &nbsp;&nbsp;&nbsp;&nbsp;_¡**Current repo users**: before you add below file, make sure you disable `SSDT-I2C1_USTP.aml`!_
  **Added file**:
    - **OC**: ACPI/SSDT-Trackpad_interrupts.aml
    - **Clover**: ACPI/patched/SSDT-Trackpad_interrupts.aml
- (re-)enabled **TRIM for SSD:**
  - **OC**: `Kernel/ Quirks/ ThirdPartyDrives`
  - **Clover**: `Kernel and Kext Patches/ KextsToPatch` ¹
- **Kexts**: apart from updating many kexts:
  - updated Sinetek's old SD-card reader **Sinetek-rtsx.kext** to latest release from [current fork by cholonam](https://github.com/cholonam/Sinetek-rtsx/releases)
  - as per recommendations/ agreements, **VoodooInput** now as separate kext and thus deactivated in both, VoodooPS2Controller and VoodooI2C
- **Refinements** in repo and ReadMe

### Bootloader specific:

**OC**:
- updated to **[v.0.6.8](https://github.com/acidanthera/OpenCorePkg/releases/tag/0.6.8)** incl. [required changes to config.plist](https://www.tonymacx86.com/threads/guide-new-voodooi2c-asus-vivobook-s15-x510uar-10-13.245445/page-63#post-2240234)
- added latest **Resources folder** from [OcBinaryData](https://github.com/acidanthera/OcBinaryData/tree/master) for v.0.6.8 graphical UI compatibility, having to force-overwrite blackosx' better readable custom framd with stock OC Helvetica font due to (hopefully temporary) OpenCanopy boot picker restrictions

**Clover**:
- updated to **[r5133](https://github.com/CloverHackyColor/CloverBootloader/releases/tag/5133)** incl. `ControlMsrE2.efi`

**Current repo users:** follow the [**update instructions**](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh#instructions-to-update-from-a-previous-version-of-this-repo)

--<br>
¹ For config.plist changes against repo release v.11.0.2 see [OC diff.plist](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/blob/main/OpenCore/diff.plist) and/or [Clover diff.plist](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/blob/main/Clover/diff.plist).

### 2021-03-13:
-  Added [**MSR E2 register unlock** info to ***ReadMe***](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/#unlock-the-msr-e2-register), ***Tool*** **entries** to OC and Clover config.plists, and ***Tools*** **folder** to OC and Clover EFI folders

### 2021-03-06:
- **ReadMe**: added Knowledge Base section with item `Quirks`; **Clover config.plist**: updated comment about Quirks

## [Release v.11.0.1, Mar. 04 2021](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/releases/tag/11.0.1)

Minor non-functional fine-tuning suggested by whatnameisit/ Syncing with [his VivoBook repo](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh):

- **OC & Clover**: `AppleCpuPmCfgLock` considered unnecessary thus toggled to `false`
- **Clover**: hardware specific dGPU ACPI table `SSDT-RP01_PEGP.aml` is now blocked more OC-like using DisabledAML in config.plist (instead moving a file in the file system); reflection of that change in ReadMe.md
- **General structure**: relocation of ACPI Battery folder into the more appropriate 'Docs' folder

## [Release v.11.0, Feb. 28 2021](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/releases/tag/11.0)

- added Big Sur compatible OpenCore EFI (credits to whatnameisit)
- added Big Sur compatible Clover EFI based on whatnameisit's OC EFI
- updated all kexts and drivers
- overall overhaul, improvements and refinements to the entire repo
- added cool cosmic theme for OC and Clover boot GUI
- moved repo over from [tctien342 (saintno)/Asus-Vivobook-S510UA-Hackintosh](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh) (now [archived](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/releases)) to my GitHub corner

____________________

### 2020-04-10:
- assigned real country code (US) across all config plist files to Boot/Arguments/brcmfx-country so Wi-Fi networks get detected even w/o any edit (user is still encouraged to set desired country code)


## [Release v.10.0, Feb. 24 2020](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/releases/tag/v10.0) <font style="font-size:14px; font-weight:normal">(archived)</font>

It contains (among others) the following changes:

### Fixes & Improvements:

- [[SOLVED] lag in authentication dialogs (as well as a delayed login screen)/ more appropriate SMBIOS product model](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/40)
- [[SOLVED] sporadic black screen on wake from sleep](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/41)
- [[SOLVED] keyboard backlight across all current macOS 10.13/14/15](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/44)
- [[OPTION] Touchpad: possibly smoother more reliable overall experience with custom polling mode SSDT](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/43)
- [[IMPROVED/ OPTION] Touchpad: smoother more reliable 2-finger operations with custom VoodooI2C v.2.0.3](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/42)
- [[IMPROVED] SSDT-less USB ports approach for better Bluetooth compatibility](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/45)
- [IMPROVED] Clover config, Kernel and Kext Patches: deactivated 'Kernel LAPIC' and 'Kernel PM', enabled 'TRIM for SSD' (for details read through [EFI pre-v.10.0 for Asus Vivobook S15](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/issues/46))

### Also see:

- [[STICKY]: TOUCHPAD » consolidated links to related issues](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/issues/48)

### Optional:

- [[SOLVED] VivoBook doesn't go to sleep properly on low battery but rather crashes](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/issues/39)


[](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/#unlock-the-msr-e2-register)
