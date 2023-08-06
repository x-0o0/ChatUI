//
//  Color.ChatUI.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI

extension EnvironmentValues {
    public var appearance: Appearance {
        get { self[AppearanceKey.self] }
        set { self[AppearanceKey.self]  = newValue }
    }
}

private struct AppearanceKey: EnvironmentKey {
    static var defaultValue: Appearance = Appearance()
}

/**
 The set of predefined appearances used in the app's user interface such as colors and fonts.
 
 Use these colors to maintain consistency and familiarity in the user interface.
 For example, use
 - the ``Appearance/tint`` color for the main colors,
 - the ``Appearance/background`` color for the view's background,
 - the ``Appearance/prominent`` color for text on prominent buttons.
 
 **Example Usage**
 
 ```swift
 @Environment(\.appearance) var appearance
 
 var body: some View {
    Text("New Chat")
        .font(appearance.title)
        .foregroundColor(appearance.primary)
 }
 ```
 */
public struct Appearance {
    
    // MARK: Predefined Colors
    /// The main colors used in views provided by ``ChatUI``. The default is `Color(.systemBlue)`
    public let tint: Color
    /// The primary label color.
    public let primary: Color
    /// The secondary label color.
    public let secondary: Color
    /// The background color.
    public let background: Color
    /// The secondary background color.
    public let secondaryBackground: Color
    /// The background color for local user's message body.
    public let localMessageBackground: Color
    /// The background color for remote user's message body.
    public let remoteMessageBackground: Color
    /// The color used in image placehoder.
    public let imagePlaceholder: Color
    /// The color used in border. The default is `secondaryBackground`
    public let border: Color
    /// The color used for disabled states. The default is `Color.secondary`
    public let disabled: Color
    /// The color used for error states. The default is `Color(.systemRed)`
    public let error: Color
    /// The prominent color. This color is used for text on prominent buttons. The default is `Color.white`.
    public let prominent: Color
    /// The link color. The default is `Color(uiColor: .link)`.
    public let link: Color
    /// The link color that is used in prominent views such as *local* message body. The default is `Color(uiColor: .systemYellow)`.
    public let prominentLink: Color
    
    /// The font used in message's body
    public let body: Font
    /// The font used in additional minor information such as date
    public let caption: Font
    /// The font used in additional major information such as sender's name.
    public let footnote: Font
    /// The font used in the title such as the title of the channel in ``ChannelInfoView``
    public let title: Font
    /// The font used in the subtitle such as the subtitle of the channel in ``ChannelInfoView``
    public let subtitle: Font
    /// Format of the time shown next to a message, default is 12 hour time hh:mm
    public let messageTimeFormat: String
    
    /// Images used throughout, these are defaulted and can be overridden for both light and dark modes
    public let images: ImageAppearanceScheme
    
    public init(
        tint: Color = Color(.tintColor),
        primary: Color = Color.primary,
        secondary: Color = Color.secondary,
        background: Color = Color(.systemBackground),
        secondaryBackground: Color = Color(.secondarySystemBackground),
        localMessageBackground: Color = Color(.tintColor),
        remoteMessageBackground: Color = Color(.secondarySystemBackground),
        imagePlaceholder: Color = Color(.secondarySystemBackground),
        border: Color = Color(.secondarySystemBackground),
        disabled: Color = Color.secondary,
        error: Color = Color(.systemRed),
        prominent: Color = Color.white,
        link: Color = Color(uiColor: .link),
        prominentLink: Color = Color(uiColor: .systemYellow),
        body: Font = .subheadline,
        caption: Font = .caption,
        footnote: Font = .footnote,
        title: Font = .headline,
        subtitle: Font = .footnote,
        lightImages: ImageAppearance = ImageAppearance(),
        darkImages: ImageAppearance = ImageAppearance(),
        messageTimeFormat: String = "hh:mm"
    ) {
        self.tint = tint
        self.primary = primary
        self.secondary = secondary
        self.background = background
        self.secondaryBackground = secondaryBackground
        self.localMessageBackground = localMessageBackground
        self.remoteMessageBackground = remoteMessageBackground
        self.imagePlaceholder = imagePlaceholder
        self.border = border
        self.disabled = disabled
        self.error = error
        self.prominent = prominent
        self.link = link
        self.prominentLink = prominentLink
        self.messageTimeFormat = messageTimeFormat
        
        // Font
        self.body = body
        self.caption = caption
        self.footnote = footnote
        self.title = title
        self.subtitle = subtitle
    
        // Image
        self.images = ImageAppearanceScheme(darkAppearance: darkImages,
            lightAppearance: lightImages)
    }
}
