import Foundation



public struct AppleDevice : Sendable {
	
	public static let current: AppleDevice? = {
//		_ = try? print(Utils.getStringSysctl(path: [CTL_HW, HW_MACHINE])) /* Deprecated sysctl */
//		_ = try? print(Utils.getStringSysctl(path: [CTL_HW, HW_MODEL]))   /* Deprecated sysctl */
//		_ = try? print(Utils.getStringSysctl(path: [CTL_HW, HW_PRODUCT]))
//		_ = try? print(Utils.getStringSysctl(path: [CTL_HW, HW_TARGET]))
		/* On a Mac:
		 * HW_MACHINE -> arm64
		 * HW_MODEL   -> Mac15,9
		 * HW_PRODUCT -> Mac15,9
		 * HW_TARGET  -> J516cAP
		 *
		 * On an iPhone:
		 * HW_MACHINE -> iPhone12,8
		 * HW_MODEL   -> D79AP
		 * HW_PRODUCT -> iPhone12,8
		 * HW_TARGET  -> D79AP
		 */
		guard let firmwareID             = try? Utils.getStringSysctl(path: [CTL_HW, HW_PRODUCT]),
				let boardConfigurationName = try? Utils.getStringSysctl(path: [CTL_HW, HW_TARGET])
		else {
			return nil
		}
		return .init(firmwareID: firmwareID, boardConfigurationName: boardConfigurationName)
	}()
	
	public let firmwareID: String
	public let boardConfigurationName: String
	
	public init(firmwareID: String, boardConfigurationName: String) {
		self.firmwareID = firmwareID
		self.boardConfigurationName = boardConfigurationName
	}
	
	public var deviceFamily: DeviceFamily {
		return Self.firmwareIDToDeviceFamily[firmwareID] ?? .unknown
	}
	
}
