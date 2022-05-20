//
//  CustomUIHostingController.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 07/04/22.
//
import Foundation
import SwiftUI
import Combine

open class CustomUIHostingController<Content:View>: UIHostingController<Content> {
	
	/// references to event subscribers
	//private var subscribers = [AnyCancellable]()
	private(set) var viewModel: LaunchViewModel?
	
	override init(rootView: Content) {
		super.init(rootView: rootView)
	}
	
	convenience init(viewModel: LaunchViewModel) {		
		self.init(rootView: LaunchView(viewModel: viewModel) as! Content)
		self.viewModel = viewModel
	}
	
	@MainActor @objc required dynamic public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
//	override func viewDidLayoutSubviews() {
//		super.viewDidLayoutSubviews()
//		view.setNeedsUpdateConstraints()
//	}
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//	}
	/// required initializer
//	@objc required dynamic init?(coder aDecoder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
}
