//
//  LoginView.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 08/04/22.
//

import SwiftUI
import WebKit
struct LoginView: View {
	let viewModel: LoginViewModel	
	var body: some View {
		VStack {
			LoginWebView(viewModel: viewModel)
		}
		.background(Color.orange)
		.onAppear {
			
		}
	}
}
struct LoginWebView: UIViewRepresentable {
	
	let viewModel: LoginViewModel
	let request: URLRequest
	let webView: WKWebView
	
	init(viewModel:LoginViewModel) {
		self.viewModel = viewModel
		self.request = viewModel.getAuthorizeEndPoint().request
		let webConfiguration = WKWebViewConfiguration()
		let webView = WKWebView(frame: .zero, configuration: webConfiguration)
		webView.navigationDelegate = viewModel
		self.webView = webView
	}
	
	func makeUIView(context: Context) -> WKWebView {
		loadWebView()
		return webView
	}
	
	func updateUIView(_ uiView: WKWebView, context: Context) {
	
	}
	
	func loadWebView(){
		self.webView.load(request)
	}
}


