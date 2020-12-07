//
//  AnnotationItem.swift
//  tourism
//
//  Created by Ihwan ID on 07/12/20.
//

import Foundation
import MapKit

struct AnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}
