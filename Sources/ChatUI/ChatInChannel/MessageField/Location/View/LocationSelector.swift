//
//  LocationSelector.swift
//
//
//  Created by Jaesung Lee on 2023/02/11.
//

import MapKit
import SwiftUI
import Combine
import CoreLocationUI

public struct LocationSelector: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.appearance) var appearance
    
    @StateObject var dataModel = LocationModel()
    @Binding var isPresented: Bool
    
    let fade =  Gradient(colors: [Color.black, Color.clear])
    
    public var body: some View {
        switch dataModel.locationTrackingStatus {
        case .none:
            EmptyView()
        case .tracked:
            VStack(spacing: 0) {
                ZStack {
                    Map(coordinateRegion: $dataModel.coordinateRegion)
                    
                    SendLocationButton(action: send)
                    
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(appearance.tint)
                }
                
                // Search results
                if !dataModel.searchedResults.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(dataModel.searchedResults, id: \.self) { resultItem in
                                Button {
                                    dataModel.coordinateRegion.center = resultItem.placemark.coordinate
                                } label: {
                                    VStack(alignment: .leading) {
                                        Text(resultItem.name ?? "")
                                            .foregroundColor(.primary)
                                            .font(.subheadline)
                                        
                                        Text(
                                            resultItem.placemark.subLocality
                                            ?? resultItem.placemark.locality
                                            ?? resultItem.placemark.administrativeArea
                                            ?? ""
                                        )
                                        .font(appearance.caption)
                                        .foregroundColor(appearance.secondary)
                                    }
                                }
                                .padding(.horizontal, 12)
                                
                                Divider()
                            }
                        }
                        .padding(8)
                    }
                    .frame(height: 40)
                    .padding(.top, 8)
                }
                
                // Dimiss button & Search bar
                HStack {
                    Button(action: dismiss) {

                        appearance.images.close(colorScheme).medium

                    }
                    .tint(appearance.tint)
                    .frame(width: 36, height: 36)
                    
                    TextField("Search location...", text: $dataModel.searchText)
                        .frame(height: 36)
                        .padding(.horizontal, 18)
                        .background {
                            appearance.secondaryBackground
                                .clipShape(Capsule())
                        }
                }
                .padding(.top, dataModel.searchedResults.isEmpty ? 16 : 8)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .background { appearance.background }
        case .notAllowed, .tracking:
            VStack(spacing: 8) {
                ZStack(alignment: .bottom) {
                    ZStack {
                        Map(coordinateRegion: .constant(dataModel.fixedRegion))
                            .disabled(true)
                            .mask(LinearGradient(gradient: fade, startPoint: .top, endPoint: .bottom))
                        
                        appearance.images.location(colorScheme).medium

                            .foregroundColor(appearance.prominent)
                            .padding()
                            .background {
                                Circle()
                                    .foregroundColor(appearance.tint)
                            }
                            .padding()
                            .background {
                                Circle()
                                    .foregroundColor(appearance.tint.opacity(0.2))
                            }
                            .padding()
                            .background {
                                Circle()
                                    .foregroundColor(appearance.tint.opacity(0.1))
                            }
                    }
                    
                    Text(
                        dataModel.locationTrackingStatus == .notAllowed
                        ? "Enable your location"
                        : "Send your location"
                    )
                    .font(appearance.title)
                    .foregroundColor(appearance.primary)
                }
                .frame(height: 200)
                
                if dataModel.locationTrackingStatus == .notAllowed {
                    Text("This app requires that location services are\nturned on your device and for this app.\nYou must enable them in Settings before using this app")
                        .multilineTextAlignment(.center)
                        .font(appearance.subtitle)
                        .foregroundColor(appearance.secondary)
                        .padding(.bottom, 12)
                    
                    LocationButton(action: dataModel.requestLocation)
                        .foregroundColor(appearance.prominent)
                        .tint(appearance.tint)
                        .clipShape(Capsule())
                    
                    Button(action: dismiss) {
                        Text("Cancel")
                            .font(appearance.footnote)
                    }
                    .tint(appearance.tint)
                    .padding(16)
                } else {
                    Text("Loading ...")
                        .font(appearance.footnote)
                        .foregroundColor(appearance.secondary)
                        .padding(.bottom, 12)
                }
            }
            .background { appearance.background }
        }
    }
    
    func send() {
        let coordinate = dataModel.coordinateRegion.center
        
        let _ = Empty<Void, Never>()
            .sink(
                receiveCompletion: { _ in
                    let style = MessageStyle.media(
                        .location(
                            coordinate.latitude,
                            coordinate.longitude
                        )
                    )
                    sendMessagePublisher.send(style)
            },
                receiveValue: { _ in }
            )
        isPresented = false
    }
    
    func dismiss() {
        withAnimation {
            isPresented = false
        }
    }
    
    public init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
}
