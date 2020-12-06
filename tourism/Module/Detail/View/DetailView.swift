//
//  DetailView.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import SwiftUI
import MapKit

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter

    var body: some View {
        ZStack {
            if presenter.loadingState {
                ProgressView()
            } else {
                ScrollView(.vertical) {
                    VStack {
                        RemoteImage(url: presenter.place.image)
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 0,
                                   maxWidth: .infinity,
                                   minHeight: 120,
                                   maxHeight: .infinity,
                                   alignment: .topLeading)
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Address")
                                .font(.headline)
                                .padding([.top, .bottom])
                            Text(self.presenter.place.address)
                                .font(.system(size: 15))

                            Text("Description")
                                .font(.headline)
                                .padding([.top, .bottom])
                            Text(self.presenter.place.desc)
                                .font(.system(size: 15))
                        }

                    }.padding()
                }
            }
        }.navigationBarTitle(Text(self.presenter.place.name), displayMode: .large)
        .navigationBarItems(trailing: Image(systemName: presenter.place.favorite ? "heart.fill" : "heart")
                                .font(.system(size: 28))
                                .foregroundColor(.orange).onTapGesture { self.presenter.updateFavoritePlace() })
    }
}
