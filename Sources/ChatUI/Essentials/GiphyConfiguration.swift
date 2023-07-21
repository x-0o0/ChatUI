import Foundation
import GiphyUISDK
import SwiftUI

public class GiphyConfiguration {

    let dimBackground: Bool
    let showConfirmationScreen: Bool
    let shouldLocalizeSearch: Bool
    let mediaTypeConfig: [GiphyUISDK.GPHContentType]
    let presentationDetents: CGFloat

    public init(
            dimBackground: Bool = false,
            showConfirmationScreen: Bool = false,
            shouldLocalizeSearch: Bool = false,
            mediaTypeConfig: [GiphyUISDK.GPHContentType] = [.gifs, .stickers, .recents],
            presentationDetents: CGFloat = 0.9
    ) {
        self.dimBackground = dimBackground
        self.showConfirmationScreen = showConfirmationScreen
        self.shouldLocalizeSearch = shouldLocalizeSearch
        self.mediaTypeConfig = mediaTypeConfig
        self.presentationDetents = presentationDetents
    }


}