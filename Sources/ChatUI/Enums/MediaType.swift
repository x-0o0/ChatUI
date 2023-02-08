//
//  MediaType.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import Foundation
import Contacts

/// The types of the media.
public enum MediaType: Hashable {
    /// Emoji.
    case emoji(_ id: String)
    /// GIF
    case gif(_ id: String)
    /// Taken photo with the *Camera* or chosen photo from the *Gallery*.
    case photo(_ data: Data)
    /// Taken video with the *Camera* or chosen video from the *Phone*.
    case video(_ date: Data)
    /// Document file from the *Phone*
    case document(_ data: Data)
    /// Contact's information saved in the phone's *address book*.
    case contact(_ contact: CNContact)
    /// The user location or a nearby place.
    case location(_ latitude: Double, _ longitude: Double)
}
