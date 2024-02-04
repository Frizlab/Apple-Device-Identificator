#!/usr/bin/env -S swift-sh --
import Foundation
import RegexBuilder

import ArgumentParser /* @apple/swift-argument-parser ~> 1.2.0 */
import CLTLogger      /* @xcode-actions/clt-logger    ~> 0.3.6 */
import Logging        /* @apple/swift-log             ~> 1.4.2 */
import XPath          /* @Frizlab                     ~> 0.3.0 */



/* Let’s bootstrap the logger before anything else. */
LoggingSystem.bootstrap{ _ in CLTLogger() }
let logger: Logger = {
	var ret = Logger(label: "main")
	ret.logLevel = .debug
	return ret
}()


_ = await Task { await ScrapEverymac.main() }.value
struct ScrapEverymac : AsyncParsableCommand {
	
	static let dateFormatter = {
		var ret = DateFormatter()
		ret.locale = Locale(identifier: "en_US_POSIX")
		ret.timeZone = TimeZone(secondsFromGMT: 0)
		ret.dateFormat = "MMMM d, yyyy"
		return ret
	}()
	
	func run() async throws {
		let iPhonePageURL = URL(string: "https://everymac.com/systems/apple/iphone/index-iphone-specs.html")!
//		let iPhonePageURL = URL(string: "https://everymac.com/systems/apple/ipod/index-ipod-specs.html")!
//		let iPhonePageURL = URL(string: "https://everymac.com/systems/apple/ipad/index-ipad-specs.html")!
//		let iPhonePageURL = URL(string: "https://everymac.com/systems/apple/mac_mini/index-macmini.html")! <-- Does not work
//		let iPhonePageURL = URL(string: "https://everymac.com/systems/apple/apple-watch/index-apple-watch-specs.html")!
//		let iPhonePageURL = URL(string: "https://everymac.com/systems/apple/apple-tv/index-appletv.html")! <-- Does not work
		let (iPhonePageData, iPhonePageResponse) = try await URLSession.shared.data(from: iPhonePageURL)
		guard (iPhonePageResponse as? HTTPURLResponse)?.statusCode == 200 else {
			throw SimpleError("Cannot donwload iPhone specs page.")
		}
		
		for table in try XPath.performHTMLXPathQuery(#"/html/body//div[@class="switchgroup1"]/div/div[@id="contentcenter_specs_internalnav_2"]/table"#, withDocument: iPhonePageData) {
			guard case let .element(_, _, children) = table else {
				logger.warning("Found unknown element type matching XPath. Ignoring.", metadata: ["element": "\(table)"])
				continue
			}
			logger.info("Processing new iPhone model.")
			var infoEntries = ArraySlice(try children.compactMap{ child -> [String]? in
				guard case let .element(childName, _, subChildren) = child, childName == "tr" else {
					return nil
				}
				return try subChildren.compactMap{ child -> String? in
					guard case let .element(childName, _, subChildren) = child, childName == "td" else {
						return nil
					}
					return try XPath.textFrom(nodeList: subChildren, recursively: true)
				}
			}.flatMap{ $0 })
			while let entry = infoEntries.popFirst() {
				let normalized = normalizeField(entry)
				switch normalized {
					case "intro":
						guard let rawValue = infoEntries.popFirst() else {
							logger.warning("No value for intro field.")
							continue /* Or break; it would do the same thing here. */
						}
						guard let (date, unfetchedDetailsCount) = parseFieldValue(rawValue, Self.dateFormatter.date(from:)) else {
							logger.warning("Cannot parse intro field value as date.", metadata: ["raw-value": "\(rawValue)"])
							continue
						}
						logger.debug("Found iPhone introductory date.", metadata: ["value": "\(date.flatMap{ "\($0)" } ?? "nil")", "raw-value": "\(rawValue)", "unfetched-details-count": "\(unfetchedDetailsCount)"])
						
					case "disc":
						guard let rawValue = infoEntries.popFirst() else {
							logger.warning("No value for disc field.")
							continue /* Or break; it would do the same thing here. */
						}
						guard let (date, unfetchedDetailsCount) = parseFieldValue(rawValue, Self.dateFormatter.date(from:)) else {
							logger.warning("Cannot parse disc field value as date.", metadata: ["raw-value": "\(rawValue)"])
							continue
						}
						logger.debug("Found iPhone discontinuation date.", metadata: ["value": "\(date.flatMap{ "\($0)" } ?? "nil")", "raw-value": "\(rawValue)", "unfetched-details-count": "\(unfetchedDetailsCount)"])
						
					case "order":
						guard let rawValue = infoEntries.popFirst() else {
							logger.warning("No value for order field.")
							continue /* Or break; it would do the same thing here. */
						}
						guard let (value, unfetchedDetailsCount) = parseFieldValue(rawValue) else {
							logger.warning("Cannot parse order field value.", metadata: ["raw-value": "\(rawValue)"])
							continue
						}
						logger.debug("Found iPhone order number.", metadata: ["value": "\(value ?? "nil")", "unfetched-details-count": "\(unfetchedDetailsCount)"])
						
					case "model":
						guard let rawValue = infoEntries.popFirst() else {
							logger.warning("No value for model field.")
							continue /* Or break; it would do the same thing here. */
						}
						guard let model = HardwareModel(parsing: rawValue) else {
							logger.warning("Cannot parse model field value as a HardwareModel.", metadata: ["raw-value": "\(rawValue)"])
							continue
						}
						logger.debug("Found iPhone model.", metadata: ["value": "\(model)", "raw-value": "\(rawValue)"])
						
					case "family":
						guard let rawValue = infoEntries.popFirst() else {
							logger.warning("No value for family field.")
							continue /* Or break; it would do the same thing here. */
						}
						guard let (value, unfetchedDetailsCount) = parseFieldValue(rawValue) else {
							logger.warning("Cannot parse family field value.", metadata: ["raw-value": "\(rawValue)"])
							continue
						}
						logger.debug("Found iPhone family.", metadata: ["value": "\(value ?? "nil")", "unfetched-details-count": "\(unfetchedDetailsCount)"])
						
					case "id":
						guard let rawValue = infoEntries.popFirst() else {
							logger.warning("No value for id field.")
							continue /* Or break; it would do the same thing here. */
						}
						guard let (value, unfetchedDetailsCount) = parseFieldValue(rawValue) else {
							logger.warning("Cannot parse id field value.", metadata: ["raw-value": "\(rawValue)"])
							continue
						}
						logger.debug("Found iPhone ID.", metadata: ["value": "\(value ?? "nil")", "unfetched-details-count": "\(unfetchedDetailsCount)"])
						
					case "voiceuse":
						guard let rawValue = infoEntries.popFirst() else {
							logger.warning("No value for voiceuse field.")
							continue /* Or break; it would do the same thing here. */
						}
						/* TODO: Parse this value. */
						guard let (value, unfetchedDetailsCount) = parseFieldValue(rawValue) else {
							logger.warning("Cannot parse voiceuse field value.", metadata: ["raw-value": "\(rawValue)"])
							continue
						}
						logger.debug("Found iPhone voice usage duration.", metadata: ["value": "\(value ?? "nil")", "unfetched-details-count": "\(unfetchedDetailsCount)"])
						
					case "musicuse":
						guard let rawValue = infoEntries.popFirst() else {
							logger.warning("No value for musicuse field.")
							continue /* Or break; it would do the same thing here. */
						}
						/* TODO: Parse this value. */
						guard let (value, unfetchedDetailsCount) = parseFieldValue(rawValue) else {
							logger.warning("Cannot parse musicuse field value.", metadata: ["raw-value": "\(rawValue)"])
							continue
						}
						logger.debug("Found iPhone music usage duration.", metadata: ["value": "\(value ?? "nil")", "unfetched-details-count": "\(unfetchedDetailsCount)"])
						
					case "batterylife":
						guard let rawValue = infoEntries.popFirst() else {
							logger.warning("No value for batterylife field.")
							continue /* Or break; it would do the same thing here. */
						}
						/* TODO: Parse this value. */
						guard let (value, unfetchedDetailsCount) = parseFieldValue(rawValue) else {
							logger.warning("Cannot parse batterylife field value.", metadata: ["raw-value": "\(rawValue)"])
							continue
						}
						logger.debug("Found battery life info.", metadata: ["value": "\(value ?? "nil")", "unfetched-details-count": "\(unfetchedDetailsCount)"])
						
					case "songs":
						guard let rawValue = infoEntries.popFirst() else {
							logger.warning("No value for songs field.")
							continue /* Or break; it would do the same thing here. */
						}
						/* TODO: Parse this value. */
						guard let (value, unfetchedDetailsCount) = parseFieldValue(rawValue) else {
							logger.warning("Cannot parse songs field value.", metadata: ["raw-value": "\(rawValue)"])
							continue
						}
						logger.debug("Found songs count info.", metadata: ["value": "\(value ?? "nil")", "unfetched-details-count": "\(unfetchedDetailsCount)"])
						
					case "photos":
						guard let rawValue = infoEntries.popFirst() else {
							logger.warning("No value for photos field.")
							continue /* Or break; it would do the same thing here. */
						}
						/* TODO: Parse this value. */
						guard let (value, unfetchedDetailsCount) = parseFieldValue(rawValue) else {
							logger.warning("Cannot parse photos field value.", metadata: ["raw-value": "\(rawValue)"])
							continue
						}
						logger.debug("Found photos count info.", metadata: ["value": "\(value ?? "nil")", "unfetched-details-count": "\(unfetchedDetailsCount)"])
						
					case "network":
						guard let rawValue = infoEntries.popFirst() else {
							logger.warning("No value for network field.")
							continue /* Or break; it would do the same thing here. */
						}
						/* TODO: Parse this value? */
						guard let (value, unfetchedDetailsCount) = parseFieldValue(rawValue) else {
							logger.warning("Cannot parse network field value.", metadata: ["raw-value": "\(rawValue)"])
							continue
						}
						logger.debug("Found network info.", metadata: ["value": "\(value ?? "nil")", "unfetched-details-count": "\(unfetchedDetailsCount)"])
						
					case "storage":
						guard let rawValue = infoEntries.popFirst() else {
							logger.warning("No value for storage field.")
							continue /* Or break; it would do the same thing here. */
						}
						/* TODO: Parse this value. */
						guard let (value, unfetchedDetailsCount) = parseFieldValue(rawValue) else {
							logger.warning("Cannot parse storage field value.", metadata: ["raw-value": "\(rawValue)"])
							continue
						}
						logger.debug("Found storage info.", metadata: ["value": "\(value ?? "nil")", "unfetched-details-count": "\(unfetchedDetailsCount)"])
						
					case let str where str.hasPrefix("complete") && str.hasSuffix("specs"):
						logger.debug("Skipping over complete specs link.")
						
					default:
						logger.notice("Ignoring unknown field.", metadata: ["field": "\(entry)", "normalized-field": "\(normalized)"])
				}
			}
		}
	}
	
	private func normalizeField(_ field: String) -> String {
		return String(field.lowercased().filter("abcdefghijklmnopqrstuvwxyz".contains))
	}
	
	private func parseFieldValue<T>(_ value: String, _ converter: (String) -> T? = { $0 }) -> (T?, unfetchedDetailsCount: Int)? {
		var value = Substring(value)
		var detailsCount = 0
		while value.last == "*" {
			_ = value.popLast()
			detailsCount += 1
		}
		guard value.lowercased() != "n/a" else {
			return (nil, detailsCount)
		}
		return converter(String(value)).flatMap{ ($0, detailsCount) }
	}
	
}

struct HardwareModel {
	
	var base: ( String,   unfetchedDetailsCount: Int)
	var emc:  ([String]?, unfetchedDetailsCount: Int)
	
	init?(parsing str: String) {
		let baseRef = Reference(Substring.self)
		let baseDetailsCountRef = Reference(Substring.self)
		let emcRef = Reference(Substring.self)
		let emcDetailsCountRef = Reference(Substring.self)
		
		let regex = Regex{
			ZeroOrMore{ .horizontalWhitespace }
			Capture(as: baseRef){ OneOrMore{ .word } }
			Capture(as: baseDetailsCountRef){ ZeroOrMore{ "*" } }
			OneOrMore{ .horizontalWhitespace }
			"(EMC"
			OneOrMore{ .horizontalWhitespace }
			Capture(as: emcRef){ ChoiceOf{ OneOrMore{ ChoiceOf{ .word; "/" } } } }
			Capture(as: emcDetailsCountRef){ ZeroOrMore{ "*" } }
			")"
			ZeroOrMore{ .horizontalWhitespace }
		}
		guard let match = try? regex.wholeMatch(in: str) else {
			return nil
		}
		
		self.base = (String(match[baseRef]), String(match[baseDetailsCountRef]).count)
		
		let emcBase = String(match[emcRef])
		let emcDetailsCount = String(match[emcDetailsCountRef]).count
		if emcBase.lowercased() == "n/a" {self.emc = (nil, emcDetailsCount)}
		else                             {self.emc = (emcBase.split(separator: "/").map(String.init), emcDetailsCount)}
	}
	
}

struct SimpleError : Error {
	var message: String
	init(_ msg: String) {self.message = msg}
}
