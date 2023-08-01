//
//  ChatConfiguration.swift
//  
//
//  Created by Jaesung Lee on 2023/02/09.
//

import SwiftUI
import GiphyUISDK

/**
 An object representing the configuration settings for a chat. The settings include the *user ID* and an optional *Giphy API key*.
 
 Use this object to configure the chat UI before starting a chat session.
 To create a ``ChatConfiguration`` object, call its initializer with the required user ID and an optional Giphy API key.
 By default, the ``ChatConfiguration/giphyKey`` property is set to `nil`, which means that Giphy integration is disabled. If you provide a valid Giphy API key, the ``ChatConfiguration/giphyKey`` property is set to that value and Giphy integration is enabled.
 After creating a ``ChatConfiguration`` object, pass it to the ``ChatUI`` views as an environment object.
 
 - Important: You must set the ``ChatConfiguration/userID`` property to a unique identifier for the user. This ID is used to identify the user in the chat session and must be unique across all users in the chat.
 
 **Example usage:**
 
 ```swift
 @StateObject var config = ChatConfiguration(userID: "user123", giphyKey: "your_giphy_api_key")
 
 var body: some View {
    ChatView()
        .environmentObject(config)
 }
 ```
 - Note: This object is an `ObservableObject` and can be *observed for changes* in its properties. Any changes to the ``ChatConfiguration/userID`` or ``ChatConfiguration/giphyKey`` properties will automatically update any views that depend on this object.
 */
open class ChatConfiguration: ObservableObject {

    /// User ID for chat
    public let userID: String
    /// Giphy API key
    public let giphyKey: String?
    /// Config for setting the giphyPicker appearance
    public let giphyConfig: GiphyConfiguration

    /**
    Initializes a new ``ChatConfiguration`` object with the specified *user ID* and *Giphy API key* (optional).

    - Parameters:
     - userID: A unique identifier for the user.
     - giphyKey: An optional Giphy API key. If provided, enables Giphy integration.
     - giphyConfig: An optional Giphy appearance config
    */
    public init(userID: String, giphyKey: String? = nil, giphyConfig: GiphyConfiguration = GiphyConfiguration()) {
        self.userID = userID
        self.giphyKey = giphyKey
        self.giphyConfig = giphyConfig

        // Giphy
        if let giphyKey = giphyKey {
            Giphy.configure(apiKey: giphyKey)
        }
    }
}
