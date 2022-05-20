//
//  SignedInView.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 18/04/22.
//

import SwiftUI

struct SignedInView: View {
	@StateObject var viewModel: SignedInViewModel
	
    var body: some View {
        Text("User is Logged In")
		Text("Hello: \(viewModel.userSession.profile.name)")
		TextField("try change the userName:", text: $viewModel.userSession.profile.name)
    }
}

//struct SignedInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignedInView()
//    }
//}
