//
//  DetailView.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import SwiftUI
import MapKit
import Core
import TourismPlace

struct DetailView: View {

    @ObservedObject var presenter: PlacePresenter<Int, PlaceDomainModel, Interactor<Int, PlaceDomainModel, GetPlaceRepository<GetPlacesLocaleDataSource,  PlaceTransformer>>,Interactor<Int, PlaceDomainModel, UpdateFavoritePlacesRepository<GetPlacesLocaleDataSource,  PlaceTransformer>>>
    var place: PlaceDomainModel
    @State var coordinateRegion: MKCoordinateRegion = {
        var region = MKCoordinateRegion()
        region.center.latitude = -0.789275
        region.center.longitude = 113.921327
        region.span.latitudeDelta = 50
        region.span.longitudeDelta = 50
        return region
    }()
    

    var body: some View {
        ScrollView(.vertical) {
            if self.presenter.isLoading {
                ProgressView()
            } else {
                VStack {
                    RemoteImage(url: place.image)
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
                        Text(self.presenter.item?.address ?? "")
                            .font(.system(size: 15))

                        Text("Description")
                            .font(.headline)
                            .padding([.top, .bottom])
                        Text(self.presenter.item?.desc ?? "")
                            .font(.system(size: 15))
                            .lineLimit(nil)
                    }
                    Map(coordinateRegion: $coordinateRegion, annotationItems: [ AnnotationItem(coordinate: CLLocationCoordinate2D(latitude: self.presenter.item?.latitude ?? 0.0, longitude: self.presenter.item?.longitude ?? 0.0))]){item in
                        MapPin(coordinate: item.coordinate)
                    }
                }.padding()
            }
        }
        .navigationBarTitle(Text(place.name), displayMode: .large)
        .navigationBarItems(trailing:
                                Image(systemName: presenter.item?.favorite == true ? "heart.fill" : "heart")
                                .font(.system(size: 28))
                                .foregroundColor(.orange)
                                .onTapGesture { self.presenter.updateFavoritePlace(request: place.id)

                                }
        )
        .onAppear{
            if self.presenter.item == nil {
                self.presenter.getPlace(place: place.id)
            }

        }

    }
}
