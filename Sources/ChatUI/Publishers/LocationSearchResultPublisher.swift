//
//  LocationSearchResultPublisher.swift
//  
//
//  Created by Jaesung Lee on 2023/02/11.
//

import Combine
import MapKit

/**
 The publisher that send events when the new `MKMapItem`objects are found as the search results.
 */
public var locationSearchResultPublisher = PassthroughSubject<[MKMapItem], Never>()
