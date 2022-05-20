//
//  HomeViewController.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 25/04/22.
//

import Foundation
class HomeViewController: SwiftUIViewController<HomeView>{
	let viewModel: HomeViewModel
	
	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		super.init(rootView: HomeView(viewModel: viewModel))
	}
	
	@MainActor @objc required dynamic public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	
}
