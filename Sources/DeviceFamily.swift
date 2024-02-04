import Foundation



public enum DeviceFamily : String, Sendable {
	
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
	
	/* Unknown or newer than implementation time… */
	case unknown = "Unknown"
	
}
