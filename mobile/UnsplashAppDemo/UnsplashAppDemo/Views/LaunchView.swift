//
//  LaunchView.swift
//  UnsplashAppDemo
//
//  Created by Nestor Hernandez on 09/03/22.
//

import SwiftUI

struct LaunchView: View {
	let launchViewModel: LaunchViewModel
    var body: some View {
		Text("Launching View").font(.title)
			.onAppear {
				launchViewModel.fetchUserSession()
			}
	}

}

//struct LaunchView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchView()
//    }
//}
