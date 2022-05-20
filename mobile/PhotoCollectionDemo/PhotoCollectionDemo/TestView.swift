//
//  TestView.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 31/03/22.
//

import SwiftUI

struct TestView: View {
	var dismiss:(()->Void)?
    var body: some View {
        Text("Test View")
			.onTapGesture {
				dismiss?()
			}
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
