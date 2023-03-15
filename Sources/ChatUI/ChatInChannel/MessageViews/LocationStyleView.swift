//
//  LocationStyleView.swift
//  
//
//  Created by Jaesung Lee on 2023/02/09.
//

import SwiftUI
import MapKit

public struct LocationStyleView: View {
    let latitude: Double
    let longitude: Double
    
    var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: .init(latitude: latitude, longitude: longitude),
            span: .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
    }
    
    public var body: some View {
        Map(
            coordinateRegion: .constant(region),
            interactionModes: [],
            annotationItems: [Location(coordinate: .init(latitude: latitude, longitude: longitude))]
        ) { location in
            MapMarker(coordinate: location.coordinate)
        }
        .frame(width: 220, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 21))
    }
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension LocationStyleView {
    struct Location: Identifiable {
        var id: String { "\(coordinate.latitude)-\(coordinate.longitude)"}
        let coordinate: CLLocationCoordinate2D
    }
}
