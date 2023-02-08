//
//  ScrollDownPublisher.swift
//  
//
//  Created by Jaesung Lee on 2023/02/09.
//

import Combine

/**
 The publisher that send events when the it needs to scroll to bottom.
 
 ```swift
 // How to publish
 let _ = Empty<Void, Never>()
    .sink(
        receiveCompletion: { _ in
            scrollDownPublisher.send(())
        },
        receiveValue: { _ in }
    )
 ```
 ```swift
 // How to subscribe
 .onReceive(scrollDownPublisher) { _ in
    withAnimation {
        scrollView.scrollTo(id, anchor: .bottom)
    }
 }
 ```
 */
public var scrollDownPublisher = PassthroughSubject<Void, Never>()
