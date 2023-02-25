//
//  CapturedItemPublisher.swift
//  
//
//  Created by Jaesung Lee on 2023/02/12.
//

import Combine

/**
 The publisher that send events when the camera captured photo or video. The parameter provides a data of the captured item.
 */
public var capturedItemPublisher = PassthroughSubject<CapturedItemView.CaptureType, Never>()
