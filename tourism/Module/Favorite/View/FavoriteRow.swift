//
//  FavoriteRow.swift
//  tourism
//
//  Created by Ihwan ID on 24/11/20.
//

import Foundation
import SwiftUI

struct FavoriteRow: View {

  var place: Place

  var body: some View {
    VStack {
      HStack(alignment: .top) {
        imageCategory
        content
        Spacer()
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 8)

      Divider()
        .padding(.leading)
    }
  }

}

extension FavoriteRow {

  var imageCategory: some View {
    RemoteImage(url: place.image)
        .aspectRatio(contentMode: .fit)
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 160,
               maxHeight: .infinity,
               alignment: .topLeading)
  }

  var content: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(place.name)
        .font(.system(size: 20, weight: .semibold, design: .rounded))
        .lineLimit(3)

        Text(place.address)
        .font(.system(size: 16))
        .lineLimit(2)

        if !place.address.isEmpty {
            Text("From \(place.address)")
          .font(.system(size: 14))
          .lineLimit(2)
      }

    }.padding(
      EdgeInsets(
        top: 0,
        leading: 16,
        bottom: 16,
        trailing: 16
      )
    )
  }

}
