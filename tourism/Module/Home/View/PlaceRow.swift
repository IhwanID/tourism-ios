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
        VStack(alignment: .center, spacing: 4.0) {
            Spacer()
            Text(place.name)
                .font(.title3).bold()
                .foregroundColor(.white)
                .shadow(color: .black, radius: 5)
        }
        .padding(16)
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 160,
               maxHeight: .infinity,
               alignment: .topLeading
        )
        .background(
            RemoteImage(url: place.image)
                .opacity(0.8).aspectRatio(contentMode: .fill)
        )
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: Color(.white).opacity(0.3), radius: 20, x: 0, y: 10)
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
