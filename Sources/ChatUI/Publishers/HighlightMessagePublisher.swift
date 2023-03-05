//
//  HighlightMessagePublisher.swift
//  
//
//  Created by Jaesung Lee on 2023/03/05.
//

import Combine

/**
 The publisher that send highlight message.
 */
public var highlightMessagePublisher = PassthroughSubject<any MessageProtocol, Never>()
