//
//  MainViewController.swift
//  PerformanceVisibility
//
//  Created by Nestor Hernandez on 13/04/22.
//

import UIKit

class MainViewController: NiblessViewController {
	let viewModel: MainViewModel
	
	public init(viewModel: MainViewModel){
		self.viewModel = viewModel
		super.init()
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .blue
		viewModel.bubbleSortBenchMark()
		viewModel.bubbleSortBenchMark()
		viewModel.bubbleSortBenchMark()
		viewModel.bubbleSortBenchMark()
		
    }

}
