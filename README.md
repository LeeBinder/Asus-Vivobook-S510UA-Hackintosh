# Asus VivoBook S15 S510UA/ F510UA series

This build enables you to run macOS on your VivoBook as long as it matches below System specifications as close as possible - verified with macOS Monterey 12.6.6 - Sonoma 14.1.1

🏳🚩**For macOS Monterey compatibility, see [macOS Monterey 12.x upgrade instructions for existing EFIs running pre-Monterey macOS](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/issues/11)** ✅

![Alt text](https://ivanov-audio.com/wp-content/uploads/2014/01/Hackintosh-Featured-Image.png)

# Table of contents
- [Repo Details](#repo-details)
- [Changelog/ Version History](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/blob/master/ChangeLog.md)
- [System specification & Introduction](#system-specification--introduction)
- [Unsupported Hardware & Features](#unsupported-hardware--features)
- [VivoBooks with an additional NVIDIA GeForce dGPU](#vivobooks-with-an-additional-dgpu-nvidia-geforce-940mx-mx150-etc)
- [Known Issues, weaknesses and oddities](#known-issues-weaknesses-and-oddities)
- [Tools & Guides to use](#tools--guides-to-use)
- [Steps to install macOS](#steps-to-install-macos)
- [Steps after installing macOS](#steps-after-installing-macos)
- [Unlock the MSR E2 register](#unlock-the-msr-e2-register)
- [Optional Wi-Fi Replacement](#optional-wi-fi-replacement)
- [ATTENTION: _be careful with Updates_!](#attention-be-careful-with-updates)
- [Recommendations](#recommendations)
- [Fine-tuning](#fine-tuning)
- [Instructions to update from a previous version of this repo](#instructions-to-update-from-a-previous-version-of-this-repo)
- [Troubleshooting](#troubleshooting)
- [Knowledge Base](#knowledge-base)
- [Credits](#special-credits-for-this-repo-to-these-fellow-hackintoshers)

# Repo Details

    Version:    	14.1.1 Beta 1
    Repo Date:      Nov. 12, 2023
    ReadMe Date: 	Nov. 12, 2023
    Repo-Status: 	Beta
    Release Status: Stable
    BIOS-Support:  	301-310
    Technology:	OpenCore and Clover with ACPI hotpatch by RehabMan
    OpenCore:    	v.0.9.6
    Clover:    	r5166
   (Changelog:   	outdated - see [Changelog.md](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/blob/master/ChangeLog.md)

# System specification & Introduction

    • Model Name:		Asus VivoBook S510UA BQ514T
    • CPU:			Intel Core i5-8250U Kaby Lake R 8th Gen. i5
    • Video Graphics:	Intel UHD 620
    • Wi-Fi & Bluetooth:	Intel Dual Band Wireless-AC 8265  // possible replacements see below
    • Card Reader:		Realtek (RTL8411B_RTS5226_RTS5227)
    • Camera:		ASUS UVC HD
    • Audio:		Conexant Audio CX8050
    • Touchpad:		ELAN 1300 I2C (ELAN 1200 supported, too)
    • Keyboard Backlight:	Yes
    • BIOS:			x510UAR 310 (X510UARAS310.zip)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style="font-family: Courier; font-size:30px; font-style:bold">T</font>his repo is based on now two archived repos:

1. Initially tctien342's [VivoBook S510UA-BQ414T repo](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/releases) which has been  discontinued because he upgraded to a different hackbook and gave his VivoBook away.
2. Consecutively whatnameisit's brilliant and cutting-edge [VivoBook X510UA-BQ490 repo](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh) based on OpenCore ("OC"). The two main differences are:

   * re-added keyboard backlight support
   * re-added a Clover EFI as *secondary* bootloader alternative by backporting OC's ACPI into Clover config.

Users with VivoBooks *without* keyboard backlight are advised to rather use [whatnameisit's OC-based repo](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh). He also has been tending it very actively until his VivoBook failed in Oct. 2021. Even if you can still download his [old archived Clover EFI](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh/blob/master/archives/CLOVER.zip), note that he stopped updating it on 2020-11-22 and merely keeps it for historical purposes.

 _In any case_ please _do_ read through his [ReadME](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh) because it contains a wealth of important info and links which also apply to this repo!

Of the two bootloaders offered in this repo, [OpenCore](https://github.com/acidanthera/OpenCorePkg) and [Clover](https://github.com/CloverHackyColor/CloverBootloader), OC can be considered the preferred one despite of still being beta by version number. As per whatnameisit and others, in contrast to OC, Clover at this point does not support OEMTableID, masking and many other sophisticated features. For a more detailed comparison, you could read [Why OpenCore over Clover and others](https://dortania.github.io/OpenCore-Install-Guide/why-oc.html#opencore-features).

<img src="https://raw.githubusercontent.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/master/OpenCore/Screenshot%20OC%20GUI.jpg" width="48%" height="" /> &nbsp; <img src="https://raw.githubusercontent.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/master/Clover/Screenshot%20Clover%20GUI.jpg" width="48%" height="" />

# Unsupported Hardware & Features

    • dGPU like NVIDIA GeForce 940MX, MX150 etc.
    • Fingerprint reader
    • FN + media controller key combo
    • Apple Safe Sleep ("Hibernate") - see additional note below
    • By now well supported: Intel Wi-Fi - full Mac-alike replacement options see below
The support for DRM contents is limited due to incompatible firmware. Please see the [DRM Compatibility Chart](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.Chart.md)

# VivoBooks with an additional dGPU (NVIDIA GeForce 940MX, MX150 etc.)

**OpenCore** via OpenCore Configurator:

- ACPI: enable `SSDT-RP01_PEGP.aml`
- NVRAM > 7C436110-AB2A-4BBB-A880-FE41995C9F82 > boot-args: add `-wegnoegpu`
- save & reboot

**Clover:** via Clover Configurator,

- Acpi > DisabledAML: remove `SSDT-RP01_PEGP.aml`
- Boot > Arguments: add `-wegnoegpu`
- save & reboot

If there is more than one boot-arg, make sure you separate them from each other with a space!

# Known Issues, weaknesses and oddities

1. The **Touchpad** is not perfect - you *might* encounter occasional hangs and possibly erratic movements because **a)** it's a weak piece of hardware to begin with (even under Windows), and **b)** the VoodooI2C driver for macOS is still work in progress. Some older info is archived at [TOUCHPAD » consolidated links to related issues](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/48).
<a name="Safe_Sleep"></a>
2. Apple **Safe Sleep** ("Hibernate", "Deep Sleep") has been disabled due to lack of compatibility. A similar functionality is planned to be integrated from whatnameisit's repo as soon as I find time to do so. For now, apply "*post macOS Installations/set hibernatemode to 0*" for the most reliable sleep experience.
3. **Battery life** isn't great to begin with, not even in Windows. On some VivoBooks it seems to be even worse in macOS. A S510UQ user ([Quhuy0410](https://www.tonymacx86.com/members/quhuy0410.2255980/)) claims longer battery life with model `MacBookAir8,2` chosen in the SMBIOS section (of Clover config.plist). Feel free to experiment. Mind that `CPUFriendDataProvider.kext` ***must*** match your chosen model. For that sake, navigate to `post macOS Installations/[Optional]/change CPU Performance`
4. **Sleep**: macOS tends to need up to 40 secs. to power down the VivoBook completely, and the fan spins up again before the system finally settles (power LED on the left blinking white, indicating sleep mode).
5. **Swapped `<` and `^` keys**: If you have a keyboard with a `<` key next to the left ⇧ and a `^` key below the `ESC` key ([image](https://i.ebayimg.com/images/g/3WUAAOSw9ixe-fAq/s-l1600.jpg)), these keys are reversed, and you neither want to use a tool like [Karabiner-Elements](https://karabiner-elements.pqrs.org/) nor know how to fix that via SSDT, simply stick to either [VoodooPS2Controller.kext v.2.2.7](https://github.com/acidanthera/VoodooPS2/releases/tag/2.2.7) or the older [VoodooPS2Controller.kext v.2.1.9](https://github.com/acidanthera/VoodooPS2/releases/tag/2.1.9) which are the only versions I know to map these keys correctly for such VivoBook S15 models like mine.

# Tools & Guides to use
* Your favorite macOS or hackintosh **USB installer maker**
* **Hackintool**: [Forum thread](https://www.insanelymac.com/forum/topic/335018-hackintool-v286/) | [GitHub](https://github.com/headkaze/Hackintool) incl. [Downloads](https://github.com/headkaze/Hackintool/releases)
* **Kext Updater**: [Homepage](https://www.sl-soft.de/en/kext-updater/) | [GitHub](https://github.com/MacThings/kextupdater/) | [Main forum thread](https://www.hackintosh-forum.de/forum/thread/32621-kext-updater-neue-version-3-x/) {German}
<a name="PlistEditors"></a>
* A good **XML property list editor**:
  - [ProperTree](https://github.com/corpnewt/ProperTree) (free) - recommended by OpenCore's Dortania Team
  - [Xplist](https://github.com/ic005k/Xplist) (ex. PlistEDPlus - free & cross-platform)
  - [PlistEdit Pro](https://www.fatcatsoftware.com/plisteditpro/) ($30)
  - [PrefEdit](https://www.bresink.com/osx/PrefEdit.html) $10)
  - Apple's [XCode](https://apps.apple.com/us/app/xcode/id497799835) development suite also comes with a plist editing module installed. It's free but "weighs" _many_ GB and is therefore only an alternative if you need it anyway for dev purposes
* A professional **cloning/ backup utility** like [Carbon Copy Cloner](https://bombich.com/download) or [SuperDuper!](https://www.shirt-pocket.com/SuperDuper/SuperDuperDescription.html)

 ### OpenCore:
 * [OpenCore Configurator](https://mackie100projects.altervista.org/download-opencore-configurator/)
 * OpenCore Auxiliary Tools (OCAT): [GitHub](https://github.com/ic005k/OCAuxiliaryTools) | [Guide by 5T33Z0](https://github.com/5T33Z0/OC-Little-Translated/blob/main/D_Updating_OpenCore/README.md) | [User's Guide by chriswayg](https://chriswayg.gitbook.io/opencore-visual-beginners-guide/step-by-step/oc-auxiliary-tools) | [Topic @InsanelyMac](https://www.insanelymac.com/forum/topic/344752-open-source-cross-platform-opencore-auxiliary-tools（ocat/) | [YT 2:18 Video by Olarila](https://www.youtube.com/watch?v=y8oeq7kMI7o) | [YT 9:43 Video by PandorasBox](https://www.youtube.com/watch?v=AGq5kbZ5IfM)
 * HackinDROM: [Homepage](https://hackindrom.zapto.org/) | [Topic @tonymacx86](https://www.tonymacx86.com/threads/hackindrom-app-for-opencore-efi-creation-and-update.312176/)
 * [Dortania guides](https://dortania.github.io/getting-started/) | [Online Reference Manual](https://raw.githubusercontent.com/acidanthera/OpenCorePkg/master/Docs/Configuration.pdf) (Pdf)


 ### Clover:
 * [Clover Configurator](https://mackie100projects.altervista.org/download-clover-configurator/)
 *  [Clover Crate (unofficial) Online Documentation](https://github.com/5T33Z0/Clover-Crate)

# Steps to install macOS

1. Enter the BIOS and set the following options:

	- Display memory: 64MB
	- Disable Fast Boot
	- Disable Secure Boot
	- recommended: set the EFI partition with OC as the first boot loader

2. Prepare a macOS installer on a USB flash drive or external hard disk

3. **Download this repo**, preferably as **.dmg package** from the [Releases](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/releases) section because **a)** each release was tested thoroughly and can be considered a stable mile stone for most users, and **b)** macOS native icons and labels are maintained.</p>  **Alternatively** you can download the repo at it's current "0-day" state if you see that a) it's significantly more recent than the latest release date, and b) contains one or more updates you are looking for. Download via the green "Clone or Download" button on the top right of the [repo's main page](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh), "[Download ZIP](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/archive/refs/heads/main.zip)".</p>Consider the non-release state as _**BETA**_, and note that GitHub does ***not*** (yet?) sustain macOS native icons and labels in its open repo!<p>To be able to boot from your macOS install USB, it needs either one of this repo's EFI folders (recommended: OC EFI) on its FAT (16 or 32) partition.

4. **Recommended**: connect a mouse via USB in case Trackpad does not work right away

4. Boot your USB macOS installer device into the hackintosh bootloader.<br>
**RECOMMENDED:** already fix CFG lock before install by [unlocking the MSR E2 register](#unlock-the-msr-e2-register), reboot.

5. Again boot into your USB installer and this time select the `macOS installer` entry

6. Follow macOS' installation instructions (you can find them in your favorite hackintosh forum) to set up and boot into macOS.

# Steps after installing macOS

1. If you haven't done already before macOS install, fix CFG lock by [unlocking the MSR E2 register](#unlock-the-msr-e2-register), reboot.

2. Open the folder "**post macOS Installations**" and install *all* from within its subfolders for Hibernate prevention, additional function keys, etc. Also (strongly recommended!) study and consider the content of the folder [Optional]!

3. **Fill your internal hard disk's EFI partition with the OC or Clover EFI folder**. You can use the matching Configurator to mount your system ESP (EFI System Partition). Next back up the existing System EFI folder and copy one of this release's EFI folders to your system's ESP.

4. **OpenCore Configurator**:
    * click onto **PlatformInfo** in the side bar on the left
    * on the right top, click onto the 1st tab 'DataHub - Generic - PlatformNVRAM'. You will see four text fields with `update this field`
    * *If you are a new user w/o a previous Clover config.plist*: while leaving the current instance open in the background, open a new empty instance of OC, navigate to the same tab, click onto the up/down arrow box next to `Check Coverage` and choose `MacBookPro15,4`
    * in the provided OC config.plist in the 1st window, fill ONLY the text fields reading `update this field` with the corresponding values from the 2nd window instance
    * *existing user*: if you have already been booting via Clover config.plist: copy the matching values over according to [these conversion translations](https://dortania.github.io/OpenCore-Install-Guide/clover-conversion/Clover-config.html#smbios)
    * save

    **Clover Configurator**:

    * *new user*: click onto **SMBIOS** in the side bar on the left. Under 'System', next to 'Serial Number', click onto the `Generate New` button. That will change both, system and board serial number.
    * *existing user*: use the [plist editor](#PlistEditors) of your choice to first remove the dummy SMBIOS section and replace it with your existing one
    * Save.

 Above steps are necessary to - amongst other things - hopefully enable the use of iCloud.

5. **Reboot and ENJOY :)**

# Unlock the MSR E2 register

from OpenCore Post-Install/[Fixing CFG Lock](https://dortania.github.io/OpenCore-Post-Install/misc/msr-lock.html) *(English slightly corrected)*:

> CFG-Lock is a setting in your BIOS that allows for a specific register (in this case the MSR 0xE2) to be written to. By default, most motherboards lock this variable with many even hiding the option outright in the GUI. And why we care about it is that **macOS actually wants to write to this variable**, and not just one part of macOS. Instead **both the Kernel(XNU) and AppleIntelPowerManagement want this register**.
>
> So to fix it we have 2 options:
>
> 1. depreciated: patch macOS to work with our hardware
>
>     This creates instability and unnecessary patching for many
>     The 2 patches we use for this:
>
>       * ~~AppleCpuPmCfgLock for AppleIntelPowerManagement.kext~~ *(not necessary for our VivoBooks)*<br>
>       * AppleXcpmCfgLock for the Kernel(XNU)
>
> 2. **recommended: patch our firmware to support MSR E2 write**
>
>     Very much preferred, as avoiding patching allows for greater flexibility regarding stability and OS upgrades.

**OpenCore:**

1. In OC's Boot GUI, launch the 2nd-to-last entry labeled `ControlMsrE2.efi`:<br>
   <img src="https://user-images.githubusercontent.com/39203497/111084597-704e8900-8513-11eb-9292-209a14dd6a66.jpg" width="260"><br>
   You should see:<br>
   <img src="https://user-images.githubusercontent.com/39203497/110465517-c7e49300-80d4-11eb-827f-38262c063382.jpg" width="620">
2. Confirm with `y` or the equivalent key on your keyboard if it's non-English (should be the key underneath the 6 and 7 keys). 
3. reboot 
4. OpenCore Configurator > Kernel: disable `AppleXcpmCfgLock`, save<br>   (note: optionally, before saving, you can also deactivate `Boot` > `Tools`:  `ControlMsrE2.efi`) 
5. reboot

<p id=msr-unlock-clover><strong>Clover:</strong></p>

1. Right after turning on or rebooting your VivoBook, press the ESC key to intercept booting and to enter the built-in Boot Menu. **THIS STEP IS MANDATORY** so `CFGLock.efi` can find the CFG variable if run as a tool from within Clover - DON'T SKIP IT! 
2. Choose your partition with Clover and boot it. 
3. In Clover's Boot GUI, navigate into the `Tools` section below the icons and launch `ControlMsrE2`:<br>
![CFGLock](https://user-images.githubusercontent.com/39203497/113349871-327d9d00-9328-11eb-8c0e-28fcc94761cb.jpg)<br>
You should see:<br>
<img src="https://user-images.githubusercontent.com/39203497/110780283-d2ce2d80-8264-11eb-928f-5eda2ae163ee.jpg" width="600" height=""> 
4. Confirm with `y` or the equivalent key on your keyboard if it's non-English (should be the key underneath the 6 and 7 keys). <br>_(Note: only if you get an error like "`Couldn't find any Variable with cfg in name`"), choose the next tool entry `CleanNvram`, reboot, and start again)_
5. reboot

**Compliments, you're DONE**! Now you should have correct CPU power management :)

- **IMPORTANT**: Every time you reset your BIOS by loading ("Optimized")  Defaults (F9) or install a different BIOS version, you will need to flip this bit again! Resetting or clearing NVRAM, however, should ***not*** re-lock the MSR E2 register.

Links: [OC Debug](https://github.com/utopia-team/opencore-debug/releases) (contains `ControlMsrE2.efi` - by utopia team) | [CFGLock.efi](https://www.insanelymac.com/forum/topic/344035-cfglock-unlock-msr-0xe2/) (legacy 2020-06 - by Brummbär) | [RU - CFG LOCK/Unlocking - Alternative method](https://www.reddit.com/r/hackintosh/comments/hz2rtm/cfg_lockunlocking_alternative_method/)

# Optional Wi-Fi Replacement

As of 2021-11-25, according to the OpenIntelWireless team, their macOS community drivers appear to be "working well and stable", which hopefully also applies to our VivoBooks' `Intel AC 8265 M.2`. The Wi-FI kernel extension does, however, require its own Wi-Fi Client to connect. Educate yourself about the current state at [OpenIntelWireless](https://github.com/OpenIntelWireless) ("OIW") and decide for yourself or simply test first, if you are happy with how your VivoBook's stock Wi-Fi and Bluetooth perform with OIW in macOS.

If you're not happy with OIW, neither want to use a USB Wi-Fi dongle but opt for a replacement of the internal Intel AC 8265 M.2, there are several options:

1. If you do _NOT_ run Windows, best replace it with a [Fenvi BCM94360NG](https://www.google.com/search?btnG=Search&q=Fenvi+BCM94360NG+M.2) M.2 because it has:
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a)  the same dimensions as the Intel module and is consequently a simple replacement
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b) generic but macOS native Wi-Fi and Bluetooth chipset and IDs. Even though they are old, they have proven to deliver a reliable Continuity experience.
<u>Disadvantage</u>: an incompatibility between the Fenvi BCM94360NG and _any/ all_ available drivers for Windows (same for 10 and 11) leads to a BSOD for most as soon as (or shortly after) Wi-Fi is connected to a network! Proven work-around has been to always have a USB device plugged in while connected via Wi-Fi. Decide if that's an option for you if you also run Windows and will use Wi-Fi. All details see [here](https://www.tonymacx86.com/threads/problem-with-bcm94360ng-on-xps-15-9570.299882/#post-2277277), and [here ff](https://github.com/osy/HaC-Mini/issues/197#issuecomment-644058743).<br><br>
2. If you also run Windows, need stable Wi-Fi in both, macOS _and_ Windows, don't mind an older ([2013](https://web.archive.org/web/20191003030122/http://wikidevi.com/wiki/Broadcom_BCM94360CS2)) yet original Apple Wi-Fi/ BT combo card, _and_ are capable of doing a bit of grinding on an adapter with a rotary tool, your best option might still be the following card + adapter combo:
   * **Apple BCM94360CS2 AirPort Extreme (NGFF)**: [eBay](https://www.ebay.com/sch/i.html?_from=R40&_trksid=p2334524.m570.l1313&_nkw=original+bcm94360cs2&_sacat=0&LH_TitleDesc=0&_odkw=Apple+BCM94360CS2+original&_osacat=0) | [AliExpress](https://www.aliexpress.com/wholesale?catId=0&initiative_id=SB_20211127124039&SearchText=original+bcm94360cs2) | [Amazon](https://www.amazon.com/s?k=original+bcm94360cs2&ref=nb_sb_noss)
   * **Dual Band NGFF M.2 A/E Key Adapter For 12+6 Pin Wireless Module**:
     * **N-12AE**: [eBay](https://www.ebay.com/sch/i.html?_from=R40&_sacat=0&LH_TitleDesc=0&_nkw=ngff+m2+key+a%2Fe+adapter+for+bcm94360cs2+bcm943224pciebt2+wireless+card&_blrs=spell_check) | [Amazon](https://www.amazon.com/dp/B073W8VKMB/) | [Amazon](https://www.amazon.com/dp/B073XHY68N/) (verified working)
     * **N-12AE** or **F-C30AP**, accdg. to images: [AliExpress](https://www.aliexpress.com/item/4001221386245.html)

🛑 ⚠ <ins>**IMPORTANT**</ins>: if you opt for the BCM94360CS2, it is <ins>crucial</ins> you _DO_ **follow my [installation instructions](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/blob/main/docs/BCM94360CS2/BCM94360CS2%20Wi-Fi:%20BT%20card%20%2B%20NGFF%20M.2%20Adapter%20Installation%20Instructions.md) step-by-step 100%**, otherwise you _WILL **brick**_ your VivoBook's motherboard! ⚠ 🛑

<ins>Links to facilitate your decision making process:</ins>
* [my comment @insanelymac](https://www.tonymacx86.com/threads/problem-with-bcm94360ng-on-xps-15-9570.299882/#post-2277277) and [IAmLe02's comment @reddit](https://www.reddit.com/r/thinkpad/comments/f7gkzi/is_broadcom_wifi_card_bcm94360ng_suitable_for/fibu84i/?utm_source=reddit&utm_medium=web2x&context=3/#UserInfoTooltip--t1_fibaqcl) re. _BCM94360NG Wi-Fi in Windows_
* [kushwavez' comment @insanelymac](https://www.insanelymac.com/forum/topic/346459-bcm94360ng-strange-behaviour-in-macos-speed-problems/?tab=comments#comment-2755949) re. _BCM94360NG/ BCM94360CS2 comparison_

**Windows**: first completely remove _any_ existing Wi-Fi and Bluetooth drivers via Programs -> Uninstall, plus any corresponding entries in Device Manager incl. their drivers, THEN power down to install the card and on reboot the latest available drivers (same for _both_ cards):
* Wi-Fi: [BCM43x v.7.77.119.0 (2020-04-21).txz.zip](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/files/7613210/BCM43x.v.7.77.119.0.2020-04-21.txz.zip) (2.3 MB)
* Bluetooth: [AppleBTBC v.6.0.6100.0 (2015-08-06).txz.zip](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/files/7613213/AppleBTBC.v.6.0.6100.0.2015-08-06.txz.zip)  (1.8 MB)

<a name="Wi-Fi-BT-depreciated"></a>Other alternative Wi-Fi/ BT combo cards like the [DW1560](https://www.google.com/search?btnG=Search&q=Dell+DW1560+M.2), [DW1830](https://www.google.com/search?btnG=Search&q=Dell+DW1830+M.2) (both Dell) or the [FRU 04X6020](https://www.google.com/search?btnG=Search&q=Lenovo+FRU+04X6020+M.2) (Lenovo) are not recommended due to compromised/ inferior Continuity.

If however you're using any of these, follow these steps in macOS, because this repo is now tailored for Apple native chipsets and does not come with extra Broadcom kexts and settings anymore:

- add required kexts (`AirportBrcmFixup`, `BrcmBluetoothInjector`, `BrcmFirmwareData`, `BrcmPatchRAM3`) into your EFI folder(s)
- add recommended entries (brcmfx-country=xy bpr_postresetdelay=400 bpr_initialdelay=400 bpr_probedelay=200) to your config.plist(s):

  - **OC:** NVRAM -> 7C436110-AB2A-4BBB-A880-FE41995C9F82 -> boot-args (for that you can remove they key `boot-args` and rename `#boot-args`to `boot-args`)
  - **Clover:** Boot > Arguments (add via the `+`)

  Adapt the boot argument `brcmfx-country=xy` to match your country code. Example: `brcmfx-country=DE` for Germany, `VN` for Vietnam etc.
- **OC**: enable above mentioned kexts in config.plist's Kernel section
- save and reboot

# ATTENTION: _be careful with Updates_!
1. **Clover only**: after updating `AirportBrcmFixup.kext` and/or `VoodooPS2Controller.kext` and (esp.) if you're running Big Sur, you ***have to*** (!!) run `/EFI/CLOVER/kexts/Other/remove problematic kexts after update` or Big Sur won't boot. See [here](https://github.com/CloverHackyColor/CloverBootloader/issues/350) for the sad and stubborn details...
2. **VirtualSMC**: The VirtualSMC version should match those of accompanying plugin kexts (**SMCProcessor**, **SMCBatteryManager**) to avoid touchpad and battery issues! Please make sure you download the most recent stable release of the **complete** SMC package [from its repo](https://github.com/acidanthera/VirtualSMC/releases) and replace ***each*** existing file with the matching new one.

# Recommendations
1. **OC (1st) + Clover (2nd)**: On your SSD's ESP, have OC's EFI folder so OC is your main bootloader; additionally create a separate FAT partition with at least 50+ MB, label it `Clover` and copy the Clover EFI folder onto it and onfigure it accdg. to above instructions. Make sure you use the same SMBIOS Platform Info in both config.plists so you don't experience oddities!
2. **Downscale monitor resolution to 1600 x 900** for two reasons: **a)** you will need to squint much less or ideally not at all because human eyes are simply not made for a 1920 x 1080 resolution on a 15,6" screen, period; and **b)** your monitor will use less energy = longer battery life!
3. **Sound quality** isn't great because the speakers are mediocre in general, and to make things even worse, Asus placed them into the bottom of the case, mostly facing down. For tips to improve the sound, please look at "[docs/BetterSound.html](https://htmlpreview.github.io/?https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/blob/master/docs/BetterSound.html)"

# Fine-tuning
- **Clover**: [how to create a GUI custom entry for Big Sur](https://github.com/CloverHackyColor/CloverBootloader/issues/300#issuecomment-768300847) rather than 'Boot Big Sur from PreBoot'
- When all is working fine for you and you prefer not to look at all the lines flashing by during boot, **remove the `-v` verbose mode** switch:<br>**OC**: NVRAM > 7C436110-AB2A-4BBB-A880-FE41995C9F82 > boot-args<br>**Clover**: Boot > Arguments
- Want to edit (or even backup) your VivoBook's **UEFI BIOS boot menu**? I know of three Windows tools you can use:
  - [DiskGenius](https://www.diskgenius.com/how-to/manage-uefi-boot-options.php) (freeware) - incl. UEFI boot entries backup & restores
  - [BootIce](https://www.softpedia.com/get/System/Boot-Manager-Disk/Bootice.shtml) (freeware) - old yet still working: [UEFI > Edit boot entries](https://www.google.com/search?q=BootIce+UEFI+Edit+boot+entries&tbm=isch&ved=2ahUKEwjPjeOrmovvAhUYG-wKHamZDVoQ2-cCegQIABAA&oq=BootIce+UEFI+Edit+boot+entries&gs_lcp=CgNpbWcQAzoECCMQJzoECAAQGDoECAAQHlCXlANYmpUEYK63BGgDcAB4AIABX4gBxg-SAQIyN5gBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=AdQ6YI-JMpi2sAeps7bQBQ&bih=908&biw=1680)
  - [EasyUEFI](https://www.easyuefi.com/index-us.html) (trial ware)

# Instructions to update from a previous version of this repo
**Recommended procedure:**
- **rename** your existing /EFI/EFI to something else, e.g. EFI_202y-mm-dd
- **copy** the new release's EFI folder as base to your /EFI volume
- **incorporate** your custom changes to the previous release into the new one via copy/ paste, either with a [plist editor](#PlistEditors) or with (OC or Clover) **Configurator** - most importantly your `SMBIOS` (Clover) respectively `PlatformInfo` (OC) section.

**Alternative procedure:** integrate new repo release changes into your EFI folder
- see [Changelog](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/blob/main/ChangeLog.md) for added, removed or renamed files
- for `config.plist` changes against the previous repo release see [OC diff.plist](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/blob/main/OpenCore/diff.plist) and/or [Clover diff.plist](https://github.com/LeeBinder/Asus-Vivobook-S510UA-Hackintosh/blob/main/Clover/diff.plist).

# Troubleshooting
**Many issues can be solved by performing a NVRAM Reset, then reboot**. If you have boot entries with custom names in your UEFI BIOS boot menu, you might want to use **_Clover's NVRAM reset_**, because it doesn't touch them but nicely keeps them intact: boot into its Boot menu, then press **F11**.
**<ins>Disadvantage</ins>**: Clover's NVRAM reset isn't as thorough as OC's, so if you still encounter any issue which might be NVRAM related, your next bet is OC's NVRAM reset. And if you don't have custom entries in your UEFI BIOS boot picker to begin with, you should run **_OC's NVRAM reset_** right away. You execute it either via the last entry in the boot menu picker, or via keyboard key combo <kbd>Windows + Alt + P + R</kbd>

**Further topics:**

- [[SOLVED] Sporadic black screen on wake from sleep](https://github.com/tctien342/Asus-Vivobook-S510UA-High-Sierra-10.13-Hackintosh/issues/41)
- [[SOLVED] VivoBook doesn't go to sleep properly on low battery but rather crashes](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/issues/39)
- [[SOLVED] VivoBook won't wake from sleep](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/issues/54#issuecomment-612618529)
- [[SOLVED] i5-8250U 1.60GHz CPU in 'About this Mac' & Sys Profiler displayed as i7 1.8GHz](https://github.com/acidanthera/bugtracker/issues/1515)

If your issue is not listed or persists, either post to the [VivoBook S15 X510UAR thread @tonymacx86](https://www.tonymacx86.com/threads/245445/), or open an [issue here](../../issues).

# Knowledge Base

* **Quirks:** Accdg. to [Clover Documentation](https://drovosek01.github.io/CloverHackyColor-WebVersion/) at the time of  writing this section (r5129), Clover does not interpret the following Quirks taken from the VivoBook OC config.plist: `SetApfsTrimTimeout`, `TscSyncTimeout`, `RequestBootVarRouting`. They might or might not be functional at some point and can be considered placeholders or reminders until they are either relevant or removed.<br>
OC's Quirk '`PanicNoKextDump`' is covered by Clover in `Kernel & Kext Patches` > `PanicNoKextDump`. `AppleXcpmCfgLock` is handled automatically and internally by Clover depending on if the `MSR 0xE2` register is locked or unlocked.

* **Battery threshold**: in general, a upper charging level limit is recommended for rechargeable lithium ion batteries. If you boot Windows and have the latest utilities and drivers from Asus installed, battery charging should halt at 83%. Hieplpvip adhered to that and included the same threshold in AsusSMC ever since v.1.4.0 which works in macOS 10.15+.
You are advised to keep it turned on, but f you need full 100% charge for longer off-the-grid usage, it can be disabled by turning off `Battery Health` in the `Energy Saver` 10.15+ System Preference. Also the battery should charge up to 100% if you power your VivoBook off, then connect the power adapter.

_________________________
## Special Credits for this repo to these fellow hackintoshers:
**whatnameisit**: main contributor; host of the [VivoBook X510UA-BQ490 repo](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh/) | **tctien342**: originator of this VivoBook S15 repo ([archived](https://github.com/tctien342/Asus-Vivobook-S510UA-Hackintosh/releases)) | **hieplpvip**: originator of the underlying/ upstream [ZenBook repo](https://github.com/hieplpvip/Asus-Zenbook-Hackintosh) and [AsusSMC](https://github.com/hieplpvip/AsusSMC); contributor | **[fewtarius](https://github.com/fewtarius)**: facilitator | To [many](https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh/blob/master/README.md#credits) *MANY* others .........
