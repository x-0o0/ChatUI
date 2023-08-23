/// Defines images used in ``ChatUI``.
///
/// Use these image names to display icons, avatars, and other images in the chat user interface.
///
/// Example usage:
/// ```
/// ChatSymbols.send
///     .resizable()
///     .frame(width: 100, height: 100)
///     .clipShape(Circle())
/// ```

import Foundation
import SwiftUI

public struct ChatSymbols {

    /// circle.grid.2x2.fill
    public let menu: Image

    /// camera.fill
    public let camera: Image

    /// photo
    public let photoLibrary: Image

    /// mic.fill
    public let mic: Image

    /// face.smiling.fill
    public let giphy: Image

    /// paperplane.fill
    public let send: Image

    /// chevron.right
    public let buttonHidden: Image

    /// chevron.down
    public let directionDown: Image

    /// location.fill
    public let location: Image

    /// paperclip
    public let document: Image

    /// music.note
    public let music: Image

    /// circle.dotted
    public let sending: Image

    /// checkmark.circle
    public let sent: Image

    /// checkmark.circle.fill
    public let delivered: Image

    /// exclamationmark.circle
    public let failed: Image

    /// icloud.slash
    public let downloadFailed: Image

    /// xmark.circle.fill
    public let close: Image

    /// arrow.triangle.2.circlepath
    public let flip: Image

    /// trash
    public let delete: Image

    /// pause.circle.fill
    public let pause: Image

    /// play.circle.fill
    public let play: Image

    /// person.crop.circle.fill
    public let person: Image

    /// Creates a new ``ChatSymbols``.
    public init(
            menu: Image = Image(systemName: "circle.grid.2x2.fill"),
            camera: Image = Image(systemName: "camera.fill"),
            photoLibrary: Image = Image(systemName: "photo"),
            mic: Image = Image(systemName: "mic.fill"),
            giphy: Image = Image(systemName: "face.smiling.fill"),
            send: Image = Image(systemName: "paperplane.fill"),
            buttonHidden: Image = Image(systemName: "chevron.right"),
            directionDown: Image = Image(systemName: "chevron.down"),
            location: Image = Image(systemName: "location.fill"),
            document: Image = Image(systemName: "paperclip"),
            music: Image = Image(systemName: "music.note"),
            sending: Image = Image(systemName: "circle.dotted"),
            sent: Image = Image(systemName: "checkmark.circle"),
            delivered: Image = Image(systemName: "checkmark.circle.fill"),
            failed: Image = Image(systemName: "exclamationmark.circle"),
            downloadFailed: Image = Image(systemName: "icloud.slash"),
            close: Image = Image(systemName: "xmark.circle.fill"),
            flip: Image = Image(systemName: "arrow.triangle.2.circlepath"),
            delete: Image = Image(systemName: "trash"),
            pause: Image = Image(systemName: "pause.circle.fill"),
            play: Image = Image(systemName: "play.circle.fill"),
            person: Image = Image(systemName: "person.crop.circle.fill")
    ) {
        self.menu = menu
        self.camera = camera
        self.photoLibrary = photoLibrary
        self.mic = mic
        self.giphy = giphy
        self.send = send
        self.buttonHidden = buttonHidden
        self.directionDown = directionDown
        self.location = location
        self.document = document
        self.music = music
        self.sending = sending
        self.sent = sent
        self.delivered = delivered
        self.failed = failed
        self.downloadFailed = downloadFailed
        self.close = close
        self.flip = flip
        self.delete = delete
        self.pause = pause
        self.play = play
        self.person = person
    }
}
