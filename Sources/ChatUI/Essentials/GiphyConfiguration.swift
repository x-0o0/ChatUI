import GiphyUISDK

public struct GiphyConfiguration {

    public let dimBackground: Bool
    public let showConfirmationScreen: Bool
    public let shouldLocalizeSearch: Bool
    public let mediaTypeConfig: [GiphyUISDK.GPHContentType]
    public let presentationDetents: CGFloat
    
    /// When moving from beta key to production key 'Giphy' asks to clearly display "Powered By GIPHY" attribution marks where the API is utilized.
    /// setting this value to true will show the attribution mark on the giphy select display.
    public let showsAttributionMark: Bool

    public init(
            dimBackground: Bool = false,
            showConfirmationScreen: Bool = false,
            shouldLocalizeSearch: Bool = false,
            mediaTypeConfig: [GiphyUISDK.GPHContentType] = [.gifs, .stickers, .recents],
            presentationDetents: CGFloat = 0.9,
            showsAttributionMark: Bool = false
    ) {
        self.dimBackground = dimBackground
        self.showConfirmationScreen = showConfirmationScreen
        self.shouldLocalizeSearch = shouldLocalizeSearch
        self.mediaTypeConfig = mediaTypeConfig
        self.presentationDetents = presentationDetents
        self.showsAttributionMark = showsAttributionMark
    }
}
