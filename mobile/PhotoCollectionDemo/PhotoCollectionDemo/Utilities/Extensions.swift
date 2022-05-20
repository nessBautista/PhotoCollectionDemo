//
//  Extensions.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 07/04/22.
//

import UIKit

extension Optional {
	var isEmpty: Bool {
		self == nil
	}
	var exists: Bool {
		self != nil
	}
}
extension UIViewController {
	public func addFullScreen(childViewController child: UIViewController){
		// check child doesn't have parents
		guard child.parent == nil else {return}
		
		// Proceed to add child
		addChild(child)
		view.addSubview(child.view)

		// Create constraints, Activate constraints, Add Constraints
		let constraints = [
			view.leadingAnchor.constraint(equalTo: child.view.leadingAnchor),
			view.trailingAnchor.constraint(equalTo: child.view.trailingAnchor),
			view.topAnchor.constraint(equalTo: child.view.topAnchor),
			view.bottomAnchor.constraint(equalTo: child.view.bottomAnchor)
		]
		child.view.translatesAutoresizingMaskIntoConstraints = false
		constraints.forEach({$0.isActive = true})
		view.addConstraints(constraints)
		// Broadcast Change from child
		child.didMove(toParent: self)
	}
	
	public func remove(childViewController child: UIViewController?){
		//Check we have a parent-child relationship
		guard let child = child else { return }
		guard child.parent.exists else { return }
		//Proceed to remove child from parent
		child.willMove(toParent: nil)
		child.view.removeFromSuperview()
		child.removeFromParent()
		
	}
}

extension URLRequest {
	func getQueryItems()->[URLQueryItem]? {
		if let url = self.url {
			return URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
		} else {
			return nil
		}		
	}
}
