//
//  FavoriteRow.swift
//  tourism
//
//  Created by Ihwan ID on 24/11/20.
//

import Foundation
import SwiftUI
import TourismPlace

struct FavoriteRow: View {

    var place: PlaceDomainModel

    var body: some View {
        VStack(alignment: .center)  {
            Text(place.name)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .lineLimit(3)
                .foregroundColor(.white)

        }.padding(.top, 20)
        .padding(.all, 20)
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 160,
               maxHeight: .infinity,
               alignment: .topLeading)
        .background(
            RemoteImage(url: place.image).opacity(0.8)                .aspectRatio(contentMode: .fill)
        )
        
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
    }

}
