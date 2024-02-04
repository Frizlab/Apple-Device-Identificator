import Foundation



public struct AppleDevice : Sendable {
	
	public static let current: AppleDevice? = {
		guard let productName = try? Utils.getStringSysctl(path: [CTL_HW, HW_MACHINE]),
				let  targetName = try? Utils.getStringSysctl(path: [CTL_HW, HW_TARGET])
		else {
			return nil
		}
		return .init(hwProduct: productName, hwTarget: targetName)
	}()
	
//	public let hwMachine: String
//	public let hwModel: String
	public let hwProduct: String
	public let hwTarget: String
	
	public init(hwProduct: String, hwTarget: String) {
		self.hwProduct = hwProduct
		self.hwTarget = hwTarget
	}
	
	public var deviceFamily: DeviceFamily {
		return Self.deviceIDToFamily[hwProduct] ?? .unknown
	}
	
}
