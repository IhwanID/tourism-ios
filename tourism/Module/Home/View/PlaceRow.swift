//
//  PlaceRow.swift
//  tourism
//
//  Created by Ihwan ID on 22/11/20.
//

import SwiftUI

struct PlaceRow: View {
    var place: Place

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 12) {
                Text(place.name)
                    .font(.title3).bold()
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5)
                Text("\(place.description.substring(to: 200)) . . .")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .opacity(0.8)
                    .shadow(color: .black, radius: 5)
            }
            Spacer()
            Text(place.address)
                .font(Font.subheadline.smallCaps())
                .foregroundColor(.black)

        }
        .padding(.top, 20)
        .padding(.all, 20)
        .background(
            RemoteImage(url: place.image)
                .aspectRatio(contentMode: .fill).opacity(0.8)
        )
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
    }
}

//struct PlaceRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceRow(section: Place())
//    }
//}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
