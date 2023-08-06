import Foundation
import SwiftUI

public struct ImageAppearanceScheme {
    
    private let darkAppearance: ImageAppearance
    private let lightAppearance: ImageAppearance
    
    @Environment(\.colorScheme) private var colorScheme
    
    public var menu: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.menu
            : lightAppearance.menu
        }
    }
    
    public var camera: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.camera
            : lightAppearance.camera
        }
    }
    
    public var photoLibrary: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.photoLibrary
            : lightAppearance.photoLibrary
        }
    }
    
    public var mic: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.mic
            : lightAppearance.mic
        }
    }
    
    public var giphy: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.giphy
            : lightAppearance.giphy
        }
    }
    
    public var send: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.send
            : lightAppearance.send
        }
    }
    
    public var buttonHidden: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.buttonHidden
            : lightAppearance.buttonHidden
        }
    }
    
    public var directionDown: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.directionDown
            : lightAppearance.directionDown
        }
    }
    
    public var location: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.location
            : lightAppearance.location
        }
    }
    
    public var document: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.document
            : lightAppearance.document
        }
    }
    
    public var music: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.music
            : lightAppearance.music
        }
    }
    
    public var sending: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.sending
            : lightAppearance.sending
        }
    }
    
    public var sent: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.sent
            : lightAppearance.sent
        }
    }
    
    public var delivered: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.delivered
            : lightAppearance.delivered
        }
    }
    
    public var failed: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.failed
            : lightAppearance.failed
        }
    }
    
    public var downloadFailed: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.downloadFailed
            : lightAppearance.downloadFailed
        }
    }
    
    public var close: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.close
            : lightAppearance.close
        }
    }
    
    public var flip: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.flip
            : lightAppearance.flip
        }
    }
    
    public var delete: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.delete
            : lightAppearance.delete
        }
    }
    
    public var pause: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.pause
            : lightAppearance.pause
        }
    }
    
    public var play: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.play
            : lightAppearance.play
        }
    }
    
    public var person: Image {
        get {
            return colorScheme == .dark
            ? darkAppearance.person
            : lightAppearance.person
        }
    }
    
    init(darkAppearance: ImageAppearance,
         lightAppearance: ImageAppearance) {
        self.darkAppearance = darkAppearance
        self.lightAppearance = lightAppearance
    }
    
}
