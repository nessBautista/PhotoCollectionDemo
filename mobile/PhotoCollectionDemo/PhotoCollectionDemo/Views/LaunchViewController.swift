//
//  LaunchViewController.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 07/04/22.
//

import UIKit

class LaunchViewController: SwiftUIViewController<LaunchView> {
	let viewModel: LaunchViewModel
	
	public init(viewModel:LaunchViewModel){
		self.viewModel = viewModel
		super.init(rootView: LaunchView(viewModel: viewModel))
	}
	
	@MainActor @objc required dynamic public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
