//
//  ScrolledToEndPublisher.swift
//  
//
//  Created by Jaesung Lee on 2023/03/19.
//

import Combine

// TODO: Unstable

/**
 The publisher that sends event when the list is scrolled to the end.
 
 ```swift
 // How to publish
 scrolledToEndPublisher.send(true)
 ```
 ```swift
 // How to subscribe
 .onReceive(scrolledToEndPublisher) { isEnded in
    if isEnded {
        loadMoreMessages()
    }
 }
 ```
 
 - Important: This publisher is the beta feature.
 */
public var scrolledToEndPublisher = PassthroughSubject<Bool, Never>()
