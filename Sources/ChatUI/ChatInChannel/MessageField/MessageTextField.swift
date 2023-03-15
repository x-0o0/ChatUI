//
//  MessageTextField.swift
//  
//
//  Created by Jaesung Lee on 2023/02/09.
//

import UIKit
import SwiftUI

struct MessageTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var height: CGFloat
    
    @State private var isEditing: Bool = false
    let placeholder: String = String.MessageField.placeholder
    let characterLimit: Int?
    
    func makeUIView(context: UIViewRepresentableContext<MessageTextField>) -> UITextView {
        let view = UITextView()
        view.backgroundColor = .clear
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        view.text = placeholder
        view.textColor = UIColor.tertiaryLabel
        view.delegate = context.coordinator
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MessageTextField>) {
        if text.isEmpty {
            uiView.text = self.isEditing ? "" : placeholder
            uiView.textColor = self.isEditing ? UIColor.label : UIColor.tertiaryLabel
        } else {
            uiView.textColor = UIColor.label
        }
        
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
            uiView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        MessageTextField.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MessageTextField
        
        init(parent: MessageTextField) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                textView.text = self.parent.text
                self.parent.isEditing = true
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.isEditing = false
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            if let characterLimit = parent.characterLimit, textView.text.count > characterLimit {
                let start = textView.text.index(textView.text.startIndex, offsetBy: 0)
                let end = textView.text.index(textView.text.startIndex, offsetBy: 300)
                textView.text = String(textView.text[start..<end])
            }
            
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.text = textView.text
            }
        }
    }
}
