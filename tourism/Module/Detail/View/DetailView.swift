//
//  DetailView.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter

    var body: some View {
        ZStack {
            if presenter.loadingState {
                loadingIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        RemoteImage(url: presenter.place.image)
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 0,
                                   maxWidth: .infinity,
                                   minHeight: 160,
                                   maxHeight: .infinity,
                                   alignment: .topLeading)
                        spacer
                        content
                        spacer
                        Button(action: {
                            self.presenter.updateFavoritePlace()
                        }, label: {
                            Text("Add to Favorites")
                        })
                    }.padding()
                }
            }
        }.navigationBarTitle(Text(self.presenter.place.name), displayMode: .large)
    }
}

extension DetailView {
    var spacer: some View {
        Spacer()
    }

    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
        }
    }


    var description: some View {
        Text(self.presenter.place.description)
            .font(.system(size: 15))
    }

    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
    }

    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerTitle("Description")
                .padding([.top, .bottom])
            description
        }
    }
}
