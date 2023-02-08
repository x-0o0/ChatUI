//
//  Image.ChatUI.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

/// Defines images used in ``ChatUI``.
///
/// Use these image names to display icons, avatars, and other images in the chat user interface.
///
/// Example usage:
/// ```
/// Image.send
///     .resizable()
///     .frame(width: 100, height: 100)
///     .clipShape(Circle())
/// ```

import SwiftUI

extension Image {
    /// circle.grid.2x2.fill
    public static var menu: Image = Image(systemName: "circle.grid.2x2.fill")
    
    /// camera.fill
    public static var camera: Image = Image(systemName: "camera.fill")
    
    /// photo
    public static var photoLibrary: Image = Image(systemName: "photo")
    
    /// mic.fill
    public static var mic: Image = Image(systemName: "mic.fill")
    
    /// face.smiling.fill
    public static var giphy: Image = Image(systemName: "face.smiling.fill")
    
    /// paperplane.fill
    public static var send: Image = Image(systemName: "paperplane.fill")
    
    /// chevron.right
    public static var buttonHidden: Image = Image(systemName: "chevron.right")
    
    /// chevron.down
    public static var directionDown: Image = Image(systemName: "chevron.down")
    
    /// location.fill
    public static var location: Image = Image(systemName: "location.fill")
    
    /// paperclip
    public static var document: Image = Image(systemName: "paperclip")
    
    /// music.note
    public static var music: Image = Image(systemName: "music.note")
    
    /// circle.dotted
    public static var sending: Image = Image(systemName: "circle.dotted")
    
    /// checkmark.circle
    public static var sent: Image = Image(systemName: "checkmark.circle")
    
    /// checkmark.circle.fill
    public static var delivered: Image = Image(systemName: "checkmark.circle.fill")
    
    /// exclamationmark.circle
    public static var failed: Image = Image(systemName: "exclamationmark.circle")
    
    /// icloud.slash
    public static var downloadFailed: Image = Image(systemName: "icloud.slash")
    
    /// xmark.circle.fill
    public static var close: Image = Image(systemName: "xmark.circle.fill")
    
    /// arrow.triangle.2.circlepath
    public static var flip: Image = Image(systemName: "arrow.triangle.2.circlepath")
    
    /// trash
    public static var delete: Image = Image(systemName: "trash")
    
    /// pause.circle.fill
    public static var pause: Image = Image(systemName: "pause.circle.fill")
    
    /// play.circle.fill
    public static var play: Image = Image(systemName: "play.circle.fill")
    
    /// person.crop.circle.fill
    public static var person: Image = Image(systemName: "person.crop.circle.fill")
}
