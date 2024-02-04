import Foundation



internal extension AppleDevice {
	
	/* Source: <https://www.everymac.com>. */
	static let firmwareIDToDeviceFamily: [String: DeviceFamily] = [
		/* iPhones */
		"iPhone1,1":  .iPhone,
		"iPhone1,2":  .iPhone3G,     /* Also, iPhone 3G,  China only (no Wi-Fi) */
		"iPhone2,1":  .iPhone3GS,    /* Also, iPhone 3GS, China only (no Wi-Fi) */
		"iPhone3,1":  .iPhone4GSM,
		"iPhone3,2":  .iPhone4GSM,   /* Wikipedia has this model, but not found on everymac */
		"iPhone3,3":  .iPhone4CDMA,  /* (Verizon, Sprint) */
		"iPhone4,1":  .iPhone4S,     /* GSM and CDMA. Also, iPhone 4S, China only (Wi-Fi replaced by its Chinese equivalent: WAPI) */
		"iPhone5,1":  .iPhone5GSM,   /* Multiple versions of this iPhone exists, each supporting different communication bands; all GSM though */
		"iPhone5,2":  .iPhone5CDMA,  /* Also, iPhone 5 CDMA China only (no LTE, but UIM and Wi-Fi replaced by its Chinese equivalent: WAPI) */
		"iPhone5,3":  .iPhone5C,     /* GSM and CDMA */
		"iPhone5,4":  .iPhone5C,     /* GSM and CDMA; other countries than previous model. */
		"iPhone6,1":  .iPhone5S,     /* GSM and CDMA */
		"iPhone6,2":  .iPhone5S,     /* GSM and CDMA; other countries than previous model. */
		"iPhone8,4":  .iPhoneSE,
		"iPhone7,1":  .iPhone6Plus,  /* GSM, CDMA & Global */
		"iPhone7,2":  .iPhone6,      /* GSM, CDMA & Global */
		"iPhone8,1":  .iPhone6S,     /* ATA&T/Sim Free, Global & Mainland China */
		"iPhone8,2":  .iPhone6SPlus, /* ATA&T/Sim Free, Global & Mainland China */
		"iPhone9,1":  .iPhone7,      /* A1660, A1779, A1780 */
		"iPhone9,3":  .iPhone7,      /* A1778 */
		"iPhone9,2":  .iPhone7Plus,  /* A1661, A1785, A1786 */
		"iPhone9,4":  .iPhone7Plus,  /* A1784 */
		"iPhone10,1": .iPhone8,      /* A1863, A1906  */
		"iPhone10,4": .iPhone8,      /* A1905 */
		"iPhone10,2": .iPhone8Plus,  /* A1864, A1898 */
		"iPhone10,5": .iPhone8Plus,  /* A1897 */
		"iPhone10,3": .iPhoneX,      /* A1865, A1902 */
		"iPhone10,6": .iPhoneX,      /* A1901 */
		
		/* iPods */
		"iPod1,1": .iPodTouch,
		"iPod2,1": .iPodTouch2, /* 2009 & 2010 */
		"iPod3,1": .iPodTouch3,
		"iPod4,1": .iPodTouch4, /* 2011 & 2012, with and without FaceTime */
		"iPod5,1": .iPodTouch5,
		"iPod7,1": .iPodTouch6,
		
		/* iPads */
		"iPad1,1":  .iPad, /* With and without 3G/GPS */
		"iPad2,1":  .iPad2WiFi,
		"iPad2,2":  .iPad2GSM,
		"iPad2,3":  .iPad2CDMA,
		"iPad2,4":  .iPad2WiFi, /* Don't know the difference with iPad2,1… */
		"iPad3,1":  .iPad3WiFi,
		"iPad3,2":  .iPad3Verizon,
		"iPad3,3":  .iPad3ATT,
		"iPad3,4":  .iPad4WiFi,
		"iPad3,5":  .iPad4ATT,
		"iPad3,6":  .iPad4Verizon,
		"iPad6,11": .iPad5Wifi,
		"iPad6,12": .iPad5Cellular,
		
		/* iPad Airs */
		"iPad4,1": .iPadAirWiFi,
		"iPad4,2": .iPadAirCellular,
		"iPad4,3": .iPadAirTDLTE, /* China */
		"iPad5,3": .iPadAir2WiFi,
		"iPad5,4": .iPadAir2Cellular,
		
		/* iPad Pros */
		"iPad6,3": .iPadPro97WiFi,
		"iPad6,4": .iPadPro97Cellular,
		"iPad6,7": .iPadPro129WiFi,
		"iPad6,8": .iPadPro129Cellular,
		"iPad7,3": .iPadPro105Wifi,
		"iPad7,4": .iPadPro105Cellular,
		"iPad7,1": .iPadPro129WiFi2ndGen,
		"iPad7,2": .iPadPro129Cellular2ndGen,
		
		/* iPad Minis */
		"iPad2,5": .iPadMiniWiFi,
		"iPad2,6": .iPadMiniATT,
		"iPad2,7": .iPadMiniVerizon,
		"iPad4,4": .iPadMini2Wifi,
		"iPad4,5": .iPadMini2Cellular,
		"iPad4,6": .iPadMini2China,
		"iPad4,7": .iPadMini3Wifi,
		"iPad4,8": .iPadMini3Cellular,
		"iPad4,9": .iPadMini3China,
		"iPad5,1": .iPadMini4Wifi,
		"iPad5,2": .iPadMini4Cellular,
		
		/* Simulators */
		"i386":   .simulatorIntelI386,
		"x86_64": .simulatorIntelX86_64
	]
	
}
