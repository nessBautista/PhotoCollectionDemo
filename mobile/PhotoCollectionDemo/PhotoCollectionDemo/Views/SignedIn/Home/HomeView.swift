//
//  HomeView.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 25/04/22.
//

import SwiftUI

struct HomeView: View {
	@StateObject var viewModel: HomeViewModel
    var body: some View {
		ScrollView {
			LazyVStack {
				ForEach($viewModel.homeFeedItems) { item in
					FeedItemView(item: item)
						.task {
							self.viewModel.loadImage(homeFeedItem: item.wrappedValue)
						}
						.onDisappear {
							
						}
				}
			}
		}
		.task {
			viewModel.loadFeed()
		}
    }
}

struct FeedItemView: View {
	@Binding var item: HomeFeedItem
	var body: some View {
		VStack{
			Text("\(item.id)")
			if let image = item.image {
				Image(uiImage: image)
					.resizable()
					.scaledToFit()
			}
		}
		.frame(height: 400)
		.background(Color.blue)
	}
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
