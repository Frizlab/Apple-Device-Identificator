import Foundation



public enum AppleDeviceIdentificatorError : Error {
	
	case cannotAllocateMemory
	case sysctlFailed(errno: errno_t)
	case cannotConvertCStringToUTF8
	
}
typealias Err = AppleDeviceIdentificatorError
