import Foundation



internal enum Utils {
	
	static func getStringSysctl(path: [Int32]) throws -> String {
		var path = path
		var bufferSize: size_t = 0
		let pathSize = u_int(path.count)
		
		guard sysctl(&path, pathSize, /*currentValueBuffer: */nil, &bufferSize, /*newValueBuffer: */nil, /*newValueBufferSize: */0) == 0 else {
			throw Err.sysctlFailed(errno: errno)
		}
		
		var buffer = malloc(MemoryLayout<CChar>.size * (bufferSize + 1))
		guard buffer != nil else {throw Err.cannotAllocateMemory}
		defer {free(buffer)}
		
		guard sysctl(&path, pathSize, buffer, &bufferSize, /*newValueBuffer: */nil, /*newValueBufferSize: */0) == 0 else {
			throw Err.sysctlFailed(errno: errno)
		}
		
		/* Let’s make sure we have a null-terminated string. */
		unsafeBitCast(buffer?.advanced(by: bufferSize), to: UnsafeMutablePointer<CChar>.self).pointee = 0
		guard let ret = String(validatingUTF8: unsafeBitCast(buffer, to: UnsafePointer<CChar>.self)) else {
			throw Err.cannotConvertCStringToUTF8
		}
		return ret
	}
	
}
