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
    @State var coordinateRegion: MKCoordinateRegion = {
        var region = MKCoordinateRegion()
        region.center.latitude = -0.789275
        region.center.longitude = 113.921327
        region.span.latitudeDelta = 50
        region.span.longitudeDelta = 50
        return region
    }()
    

    var body: some View {
        ZStack {
            if presenter.loadingState {
                ProgressView()
            } else {
                ScrollView(.vertical) {
                    VStack {
                        RemoteImage(url: presenter.place.image)
                            .frame(minWidth: 0,
                                   maxWidth: .infinity,
                                   minHeight: 120,
                                   maxHeight: .infinity,
                                   alignment: .topLeading)
                            .aspectRatio(contentMode: .fill)

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
                                .lineLimit(nil)
                        }
                        Map(coordinateRegion: $coordinateRegion, annotationItems: [ AnnotationItem(coordinate: CLLocationCoordinate2D(latitude: self.presenter.place.latitude, longitude: self.presenter.place.longitude))]){item in
                            MapPin(coordinate: item.coordinate)
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
