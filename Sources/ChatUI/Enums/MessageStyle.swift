//
//  MessageStyle.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import Foundation
import SwiftUI

/// The Styles of the message.
///
/// The user can send a several styles of the messages such as text only, photos, videos, files, locations or voice messages. This enumeration defines cases of the messages' styles
public enum MessageStyle: Hashable {
    /// General text message
    case text(_ text: String)
    /// The media message such as photo, video, document, contact and so on.
    case media(_ mediaType: MediaType)
    /// The voice message which is recorded by microphone in the chat screen.
    case voice(_ data: Data)
}
