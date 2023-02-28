//
//  LocationModel.swift
//  
//
//  Created by Jaesung Lee on 2023/02/11.
//

import MapKit
import SwiftUI
import Combine

class LocationModel: NSObject, ObservableObject {
    let manager = CLLocationManager()
    
    enum TrackStatus {
        case none
        case notAllowed
        case tracking
        case tracked
    }
    
    @Published var locationTrackingStatus: TrackStatus = .none
    @Published var coordinateRegion: MKCoordinateRegion = .init(
        center: .init(latitude: 37.57827, longitude: 126.97695),
        span: .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )
    
    // MARK: Search
    @Published var searchText: String = ""
    @Published var searchedResults: [MKMapItem] = []
    var searchPublisher: AnyCancellable?
    var searchResultPublisher: AnyCancellable?
    
    let fixedRegion = MKCoordinateRegion(
        center: .init(latitude: 37.57827, longitude: 126.97695),
        span: .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )
    
    override init() {
        super.init()
        
        manager.delegate = self
        subscribeSearchPublisher()
        subscribesSearchResultPublisher()
    }
    
    deinit {
        searchPublisher?.cancel()
        searchResultPublisher?.cancel()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationModel: CLLocationManagerDelegate {
    func requestLocation() {
        withAnimation {
            locationTrackingStatus = .tracking
        }
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Set up region once.
        guard locationTrackingStatus != .tracked else { return }
        guard let location = locations.first?.coordinate else { return }
        coordinateRegion = .init(
            center: location,
            span: .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
        locationTrackingStatus = .tracked
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("🧭 [Location] error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            requestLocation()
        } else {
            locationTrackingStatus = .notAllowed
        }
    }
}

extension LocationModel {
    func subscribeSearchPublisher() {
        searchPublisher = $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .compactMap { $0 }
            .sink(receiveValue: { [weak self] (searchText) in
                self?.searchedResults = []
                self?.search(searchText)
            })
    }
    
    func subscribesSearchResultPublisher() {
        searchResultPublisher = locationSearchResultPublisher
            .sink(receiveValue: { [weak self]  items in
                self?.searchedResults = items
            })
    }
    
    func search(_ text: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = [.pointOfInterest]
        request.region = coordinateRegion
        let search = MKLocalSearch(request: request)
        
        search.start { (response, _) in
            guard let response = response else { return }
            locationSearchResultPublisher.send(response.mapItems)
        }
    }
}
