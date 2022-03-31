//
//  MainView.swift
//  UnsplashAppDemo
//
//  Created by Nestor Hernandez on 09/03/22.
//

import SwiftUI

struct MainView: View {
	
	@StateObject var mainViewModel: MainViewModel
	var launchViewFactory: ()->LaunchView
	
    var body: some View {
		switch self.mainViewModel.navigationState {
		case .launching:
			launchViewFactory()
		case .loggedIn:
			Text("User Is LoggedIn")
				.font(.title)
		case .notLoggedIn:
			Text("User Is Not LoggedIn")
				.font(.title)
		}
    }
}


