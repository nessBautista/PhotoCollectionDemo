//
//  BubbleSort.swift
//  PerformanceVisibility
//
//  Created by Nestor Hernandez on 13/04/22.
//

import Foundation

class BubbleSort: Identifiable {
	var id: UUID = UUID()
	func sort(_ array:inout [Int]) {
		let N = array.count
		for _ in 0..<N {
			//Bubble Up the highest Value
			for j in 1..<N {
				if array[j-1]>array[j]{
					array.swapAt(j-1, j)
				}
			}
		}
	}
}


