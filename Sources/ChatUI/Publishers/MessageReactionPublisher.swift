//
//  MessageReactionPublisher.swift
//  
//
//  Created by Jaesung Lee on 2023/03/05.
//

import Combine

/**
 The publisher that send reaction item and message ID.
 - IMPORTANT: The first parameter is the reaction item.
 */
public var messageReactionPublisher = PassthroughSubject<(String, String), Never>()

