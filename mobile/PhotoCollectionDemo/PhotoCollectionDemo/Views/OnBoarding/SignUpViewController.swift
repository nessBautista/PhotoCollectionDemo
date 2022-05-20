//
//  SignUpViewController.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 08/04/22.
//

import Foundation
class SignUpViewController: SwiftUIViewController<SignUpView>{
	init(){
		super.init(rootView: SignUpView())
	}
	
	@MainActor @objc required dynamic public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
