//
//  NiblessNavigationController.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 08/04/22.
//
import UIKit

open class NiblessNavigationController: UINavigationController {

  // MARK: - Methods
  public init() {
	super.init(nibName: nil, bundle: nil)
  }
	public override init(rootViewController: UIViewController){
		super.init(rootViewController: rootViewController)
	}

  @available(*, unavailable,
	message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
  )
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
	super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  @available(*, unavailable,
	message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
  )
  public required init?(coder aDecoder: NSCoder) {
	fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
  }
}
