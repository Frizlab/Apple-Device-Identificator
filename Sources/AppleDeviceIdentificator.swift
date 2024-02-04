import Foundation



/* Inspired by <https://github.com/eagle-dan1349/EDDeviceHardware> (especially PR #2). */
struct HardwareModel : Sendable {
	
	enum Platform : String, Sendable {
		/* iPhones */
		case iPhone       = "iPhone (EDGE)"
		case iPhone3G     = "iPhone 3G"
		case iPhone3GS    = "iPhone 3GS"
		case iPhone4GSM   = "iPhone 4 (GSM)"
		case iPhone4CDMA  = "iPhone 4 (CDMA)"
		case iPhone4S     = "iPhone 4S"
		case iPhone5GSM   = "iPhone 5 (GSM)"
		case iPhone5CDMA  = "iPhone 5 (CDMA)"
		case iPhone5C     = "iPhone 5C"
		case iPhone5S     = "iPhone 5S"
		case iPhoneSE     = "iPhone SE"
		case iPhone6      = "iPhone 6"
		case iPhone6Plus  = "iPhone 6 Plus"
		case iPhone6S     = "iPhone 6S"
		case iPhone6SPlus = "iPhone 6S Plus"
		case iPhone7      = "iPhone 7"
		case iPhone7Plus  = "iPhone 7 Plus"
		case iPhone8      = "iPhone 8"
		case iPhone8Plus  = "iPhone 8 Plus"
		case iPhoneX      = "iPhone X"
		
		/* iPods */
		case iPodTouch  = "iPod Touch"
		case iPodTouch2 = "iPod Touch 2"
		case iPodTouch3 = "iPod Touch 3"
		case iPodTouch4 = "iPod Touch 4"
		case iPodTouch5 = "iPod Touch 5"
		case iPodTouch6 = "iPod Touch 6"
		
		/* iPads */
		case iPad          = "iPad"
		case iPad2WiFi     = "iPad 2 WiFi"
		case iPad2GSM      = "iPad 2 GSM"
		case iPad2CDMA     = "iPad 2 CDMA"
		case iPad3WiFi     = "iPad 3 WiFi"
		case iPad3ATT      = "iPad 3 AT&T"
		case iPad3Verizon  = "iPad 3 Verizon"
		case iPad4WiFi     = "iPad 4 WiFi"
		case iPad4ATT      = "iPad 4 AT&T"
		case iPad4Verizon  = "iPad 4 Verizon"
		case iPad5Wifi     = "iPad 5 Wifi"
		case iPad5Cellular = "iPad 5 Cellular"
		
		/* iPad Airs */
		case iPadAirWiFi      = "iPad Air WiFi"
		case iPadAirCellular  = "iPad Air Cellular"
		case iPadAirTDLTE     = "iPad Air TD-LTE"
		case iPadAir2WiFi     = "iPad Air 2 WiFi"
		case iPadAir2Cellular = "iPad Air 2 Cellular"
		
		/* iPad Pros */
		case iPadPro129WiFi           = "iPad Pro 12.9 WiFi"
		case iPadPro129Cellular       = "iPad Pro 12.9 Cellular"
		case iPadPro97WiFi            = "iPad Pro 9.7 WiFi"
		case iPadPro97Cellular        = "iPad Pro 9.7 Cellular"
		case iPadPro105Wifi           = "iPad Pro 10.5 Wifi"
		case iPadPro105Cellular       = "iPad Pro 10.5 Cellular"
		case iPadPro129WiFi2ndGen     = "iPad Pro 12.9 Wifi 2nd Gen"
		case iPadPro129Cellular2ndGen = "iPad Pro 12.9 Cellular 2nd Gen"
		
		/* iPad Minis */
		case iPadMiniWiFi      = "iPad Mini WiFi"
		case iPadMiniATT       = "iPad Mini AT&T"
		case iPadMiniVerizon   = "iPad Mini Verizon"
		case iPadMini2Wifi     = "iPad Mini 2 Wifi"
		case iPadMini2Cellular = "iPad Mini 2 Cellular"
		case iPadMini2China    = "iPad Mini 2 China"
		case iPadMini3Wifi     = "iPad Mini 3 Wifi"
		case iPadMini3Cellular = "iPad Mini 3 Cellular"
		case iPadMini3China    = "iPad Mini 3 China"
		case iPadMini4Wifi     = "iPad Mini 4 Wifi"
		case iPadMini4Cellular = "iPad Mini 4 Cellular"
		
		/* Simulators */
		case simulatorIntelI386   = "Simulator (Intel i386)"
		case simulatorIntelX86_64 = "Simulator (Intel x86_64)"
		
		/* Unknown or newer than implementation time... */
		case unknown = "Unknown"
	}
	
	/* Source: <https://www.everymac.com>. */
	private static let mapping: [String: Platform] = [
		/* iPhone */
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
		"iPad2,4":  .iPad2WiFi, /* Don't know the difference with iPad2,1... */
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
	
	let platform: Platform
	let platformCode: String? /* nil if unknown */
	
	init(platformCode pc: String?) {
		platformCode = pc
		if let pc = pc {platform = HardwareModel.mapping[pc] ?? .unknown}
		else           {platform = .unknown}
	}
	
	/* lazy */
	static var currentDevice: HardwareModel = {
		var bufferSize: size_t = 0
		var infoName = [CTL_HW, HW_MACHINE]
		let infoSize = u_int(infoName.count)
		
		guard sysctl(&infoName, infoSize, nil, &bufferSize, nil, 0) == 0 else {
			return HardwareModel(platformCode: nil)
		}
		
		var buffer = malloc(MemoryLayout<CChar>.size * (bufferSize + 1))
		guard buffer != nil else {return HardwareModel(platformCode: nil)}
		defer {free(buffer)}
		
		guard sysctl(&infoName, infoSize, buffer, &bufferSize, nil, 0) == 0 else {
			return HardwareModel(platformCode: nil)
		}
		
		/* Let's make sure we have a null-terminated string. */
		unsafeBitCast(buffer?.advanced(by: bufferSize), to: UnsafeMutablePointer<CChar>.self).pointee = 0
		
		return HardwareModel(platformCode: String(validatingUTF8: unsafeBitCast(buffer, to: UnsafePointer<CChar>.self)))
	}()
	
}
