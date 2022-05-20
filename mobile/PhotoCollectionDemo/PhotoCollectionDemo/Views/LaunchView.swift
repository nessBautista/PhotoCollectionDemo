//
//  LaunchView.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 06/04/22.
//

import SwiftUI

struct LaunchView: View {
	let viewModel: LaunchViewModel
    var body: some View {
		VStack {
			Text("This is the launchView")
				.font(.title)
		}
		.background(Color.blue)
		.onAppear {
			viewModel.loadUserSession()
		}
        
    }
}

//struct LaunchView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchView()
//    }
//}
