//
//  WelcomeView.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 08/04/22.
//

import SwiftUI

struct WelcomeView: View {
	let goToLogInResponder: GoToLoginResponder
	let goToSignUpResponder: GoToSignUpResponder
	
    var body: some View {
		VStack(alignment: .center) {
			Text("This is the Welcome View")
				.font(.title)
			
			Button("Go To Log In") {
				self.goToLogInResponder.goToLogin()
			}
			
			Button("Go Sign Up") {
				self.goToSignUpResponder.goToSignUp()
			}
		}
        
    }
}
//
//struct WelcomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        WelcomeView()
//    }
//}
