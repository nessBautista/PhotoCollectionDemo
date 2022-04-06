//
//  ViewController.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 31/03/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .blue
		let button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
		button.setTitle("Go Forward", for: .normal)
			
		button.addTarget(self,
						 action: #selector(goForward),
						 for: .touchUpInside)
		self.navigationController?.view.addSubview(button)
	}

	@objc
	func goForward() {
		print("go")
		let host = UIHostingController(rootView: TestView(dismiss: dismiss))
		self.navigationController?.pushViewController(host, animated: true)
	}
	func dismiss(){
		self.navigationController?.popViewController(animated: true)
	}

}

