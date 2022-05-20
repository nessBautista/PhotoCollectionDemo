//
//  AppLoger.swift
//  PerformanceVisibility
//
//  Created by Nestor Hernandez on 13/04/22.
//

import os
import CoreFoundation
class AppLogger {
	static let shared: AppLogger = AppLogger()
	private(set) var internalLogger = Logger(subsystem: "com.performance.app",
											 category: "AppPerformance")
	
	public func log(log: String, timeStamp: CFAbsoluteTime = CFAbsoluteTimeGetCurrent()) {
		internalLogger.log("PerformanceVisibility.App - \(log)")
	}
}
