//
//  MainViewModel.swift
//  PerformanceVisibility
//
//  Created by Nestor Hernandez on 13/04/22.
//

import Foundation

class MainViewModel {
	func bubbleSortBenchMark(){
		let sorter = BubbleSort()
		AppLogger.shared.log(log: "\(sorter.id)-\("started")")
		var array = (0..<10).map({$0}).shuffled()
		sorter.sort(&array)
		AppLogger.shared.log(log: "\(sorter.id)-\("finished")")
	}
}
