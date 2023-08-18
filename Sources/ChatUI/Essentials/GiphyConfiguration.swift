import GiphyUISDK

public struct GiphyConfiguration {

    public let dimBackground: Bool
    public let showConfirmationScreen: Bool
    public let shouldLocalizeSearch: Bool
    public let mediaTypeConfig: [GiphyUISDK.GPHContentType]
    public let presentationDetents: CGFloat
    public let showAttributionMark: Bool

    public init(
            dimBackground: Bool = false,
            showConfirmationScreen: Bool = false,
            shouldLocalizeSearch: Bool = false,
            mediaTypeConfig: [GiphyUISDK.GPHContentType] = [.gifs, .stickers, .recents],
            presentationDetents: CGFloat = 0.9,
            showAttributionMark: Bool = false
    ) {
        self.dimBackground = dimBackground
        self.showConfirmationScreen = showConfirmationScreen
        self.shouldLocalizeSearch = shouldLocalizeSearch
        self.mediaTypeConfig = mediaTypeConfig
        self.presentationDetents = presentationDetents
        self.showAttributionMark = showAttributionMark
    }
}
