import Foundation
import SwiftUI

public struct ImageAppearanceScheme {
    
    private let darkAppearance: ImageAppearance
    private let lightAppearance: ImageAppearance
    
    public func getMenu(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.menu
        : lightAppearance.menu
    }
    
    public func getCamera(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.camera
        : lightAppearance.camera
    }
    
    public func getPhotoLibrary(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.photoLibrary
        : lightAppearance.photoLibrary
    }
    
    public func getMic(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.mic
        : lightAppearance.mic
    }
    
    public func getGiphy(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.giphy
        : lightAppearance.giphy
    }
    
    public func getSend(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.send
        : lightAppearance.send
    }
    
    public func getButtonHidden(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.buttonHidden
        : lightAppearance.buttonHidden
    }
    
    public func getDirectionDown(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.directionDown
        : lightAppearance.directionDown
    }
    
    public func getLocation(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.location
        : lightAppearance.location
    }
    
    public func getDocument(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.document
        : lightAppearance.document
    }
    
    public func getMusic(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.music
        : lightAppearance.music
    }
    
    public func getSending(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.sending
        : lightAppearance.sending
    }
    
    public func getSent(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.sent
        : lightAppearance.sent
    }
    
    public func getDelivered(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.delivered
        : lightAppearance.delivered
    }
    
    public func getFailed(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.failed
        : lightAppearance.failed
    }
    
    public func getDownloadFailed(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.downloadFailed
        : lightAppearance.downloadFailed
    }
    
    public func getClose(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.close
        : lightAppearance.close
    }
    
    public func getFlip(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.flip
        : lightAppearance.flip
    }
    
    public func getDelete(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.delete
        : lightAppearance.delete
    }
    
    public func getPause(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.pause
        : lightAppearance.pause
    }
    
    public func getPlay(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.play
        : lightAppearance.play
    }
    
    public func getPerson(_ colorScheme: ColorScheme) -> Image {
        return colorScheme == .dark
        ? darkAppearance.person
        : lightAppearance.person
    }
    
    init(darkAppearance: ImageAppearance,
         lightAppearance: ImageAppearance) {
        self.darkAppearance = darkAppearance
        self.lightAppearance = lightAppearance
    }
    
}

