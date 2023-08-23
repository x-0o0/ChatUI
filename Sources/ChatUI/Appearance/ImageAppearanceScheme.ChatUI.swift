/// Provides images from ``ChatSymbols`` with the specific color scheme.
///
/// The initializer allows to set up the ``ChatSymbols`` for both light and dark mode.
///
/// Example usage:
/// ```
/// // To get ``ChatSymbols.send`` for dark mode
/// ImageAsset.send(.dark)
/// // To get ``ChatSybmols.camera`` for light mode
/// ImageAsset.camera(.light)
/// ```

import Foundation
import SwiftUI

public struct ImageAsset {
    
    private let darkSymbol: ChatSymbols
    private let lightSymbol: ChatSymbols
    
    public func menu(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.menu
        : lightSymbol.menu
    }
    
    public func camera(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.camera
        : lightSymbol.camera
    }
    
    public func photoLibrary(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.photoLibrary
        : lightSymbol.photoLibrary
    }
    
    public func mic(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.mic
        : lightSymbol.mic
    }
    
    public func giphy(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.giphy
        : lightSymbol.giphy
    }
    
    public func send(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.send
        : lightSymbol.send
    }
    
    public func buttonHidden(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.buttonHidden
        : lightSymbol.buttonHidden
    }
    
    public func directionDown(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.directionDown
        : lightSymbol.directionDown
    }
    
    public func location(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.location
        : lightSymbol.location
    }
    
    public func document(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.document
        : lightSymbol.document
    }
    
    public func music(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.music
        : lightSymbol.music
    }
    
    public func sending(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.sending
        : lightSymbol.sending
    }
    
    public func sent(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.sent
        : lightSymbol.sent
    }
    
    public func delivered(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.delivered
        : lightSymbol.delivered
    }
    
    public func failed(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.failed
        : lightSymbol.failed
    }
    
    public func downloadFailed(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.downloadFailed
        : lightSymbol.downloadFailed
    }
    
    public func close(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.close
        : lightSymbol.close
    }
    
    public func flip(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.flip
        : lightSymbol.flip
    }
    
    public func delete(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.delete
        : lightSymbol.delete
    }
    
    public func pause(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.pause
        : lightSymbol.pause
    }
    
    public func play(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.play
        : lightSymbol.play
    }
    
    public func person(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkSymbol.person
        : lightSymbol.person
    }
    
    /// Creates a new ``ImageAsset`` with ``ChatSymbols`` objects.
    /// - Parameters:
    ///    - lightSybmol: ``ChatSymbols`` object that is used for the light mode.
    ///    - darkSymbol: ``ChatSymbols`` object that is used for the dark mode.
    public init(lightSymbol: ChatSymbols,
         darkSymbol: ChatSymbols) {
        self.lightSymbol = lightSymbol
        self.darkSymbol = darkSymbol
    }
    
}

