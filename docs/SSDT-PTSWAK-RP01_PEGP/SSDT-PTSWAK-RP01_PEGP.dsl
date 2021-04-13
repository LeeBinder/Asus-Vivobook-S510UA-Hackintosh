// by whatnameisit https://github.com/whatnameisit/Asus-Vivobook-X510UA-BQ490-Hackintosh/issues/29


// Looking into the original methods _PTS, _WAK, _REG,
// they are all NotSerialized.

// In config ACPI, _PTS to ZPTS(1,N)
// Find:     5F50545301
// Replace:  5A50545301
// In config ACPI, _WAK to ZWAK(1,N)
// Find:     5F57414B01
// Replace:  5A57414B01
// Above binary patch copied from Daliansky's OC-Little

// In config ACPI, _REG to XREG(2,N) and tailing bytes
// Find:     5F52454702A00B
// Replace:  5852454702A00B
// Above binary patch copied from hieplpvip's ASUS-Zenbook-Hackintosh

DefinitionBlock ("", "SSDT", 2, "what", "SHSLWAK", 0x00000000)
{
    External (_SB_.PCI0.HGOF, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.XREG, MethodObj)    // 2 Arguments
    External (_SB_.PCI0.RP01.PEGP, DeviceObj)
    External (_SB_.PCI0.RP01.PEGP._OFF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP01.PEGP._ON_, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.XHC_.PMEE, FieldUnitObj)
    External (ZPTS, MethodObj)    // 1 Arguments
    External (ZWAK, MethodObj)    // 1 Arguments

    // _PTS needs to be patched because there is said to be issues with muxed dGPU on sleep.
    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        If (_OSI ("Darwin")) // If the booted OS is macOS
        {
            If (CondRefOf (\_SB.PCI0.RP01.PEGP._ON)) // and if the method to turn on muxed dGPU exists
            {
                \_SB.PCI0.RP01.PEGP._ON () // execute it.
            }
        }
        
        ZPTS (Arg0) // Execute original _PTS because P in _PTS means prepare. Whatever it means.
                    // Don't throw it out just because you want :) If you still think you're OK with not having it,
                    // replace OEM DSDT table with an empty table and see if it has any effect.
                    // You can't boot? Too bad. But isn't that expected?
                    
        If ((0x05 == Arg0)) // The usual code to fix restart instead of shutdown issue when a USB device is plugged in.
        {
            \_SB.PCI0.XHC.PMEE = Zero
        }
    }
    // _WAK needs to be patched because there is said to be issues with muxed dGPU on wake.
    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        If (_OSI ("Darwin")) // If the booted OS is macOS
        {
            If (CondRefOf (\_SB.PCI0.RP01.PEGP._OFF)) // and if the method to turn off muxed dGPU exists
            {
                \_SB.PCI0.RP01.PEGP._OFF () // execute it.
            }
        }
        
        Return (ZWAK (Arg0)) // Execute original _WAK and return the result. Don't throw this out either for no reason :)
                             // Try it and the laptop probably won't wake up.
    }

    // Turn off dGPU fan because dGPU isn't being used.
    Scope (_SB.PCI0.LPCB.EC0)
    {
        OperationRegion (RME3, EmbeddedControl, Zero, 0xFF) // OperationRegion needs to be declared for _REG to be correctly executed
        Method (_REG, 2, NotSerialized)  // _REG: Region Availability
        {
            XREG (Arg0, Arg1) // Execute original _REG. If you throw this out you will likely brick EC firmware :)
                              // Try it and EC may need be reset.
            If (_OSI ("Darwin")) // If the booted OS is macOS
            {
                If (((0x03 == Arg0) && (One == Arg1))) // and if EC is ready
                {
                    If (CondRefOf (\_SB.PCI0.HGOF)) // and if the method to turn off dGPU fan exists
                    {
                        \_SB.PCI0.HGOF (Arg0) // execute it.
                    }
                }
            }
        }
    }
}

