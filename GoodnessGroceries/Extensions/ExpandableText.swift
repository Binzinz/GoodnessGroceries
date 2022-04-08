//
// ExpandableText.swift
//
//
//  Created by 이웅재 on 2021/10/12.
//
import SwiftUI

public struct ExpandableText: View {
    var text : String
    @EnvironmentObject var UserSettings: UserSettings
    var font: Font = .body
    var lineLimit : Int = 4
    var foregroundColor : Color = .primary
    private var expandButtonText: String {
            if !truncated {
                return ""
            } else {
                return self.expand ? NSLocalizedString("READ_LESS", lang: UserSettings.language) : NSLocalizedString("READ_MORE", lang: UserSettings.language)
            }
        }
    var expandButtonColor : Color = .blue
    
    var uiFont: UIFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    @State private var expand : Bool = false
    @State private var truncated : Bool = false
    @State private var size : CGFloat = 0
    
    
    public init(text: String) {
        self.text = text
    }
    public var body: some View {
        VStack(alignment: .leading){
            Text(text)
                .font(font)
                .foregroundColor(foregroundColor)
                .lineLimit(expand == true ? nil : lineLimit)
                
                .background(
                    Text(text).lineLimit(lineLimit)
                        .background(GeometryReader { visibleTextGeometry in
                            ZStack { //large size zstack to contain any size of text
                                Text(self.text)
                                    .background(GeometryReader { fullTextGeometry in
                                        Color.clear.onAppear {
                                            self.truncated = fullTextGeometry.size.height > visibleTextGeometry.size.height
                                        }
                                    })
                            }
                            .frame(height: .greatestFiniteMagnitude)
                        })
                        .hidden() //keep hidden
                )
            if truncated {
                           Button(action: {
                               withAnimation {
                                   expand.toggle()
                               }
                           }, label: {
                               Text(expandButtonText)
                           })
                       }
        }
        .background(
            Text(text)
                .lineLimit(lineLimit)
                .background(GeometryReader { geo in
                    Color.clear.onAppear() {
                        let size = CGSize(width: geo.size.width, height: .greatestFiniteMagnitude)
                        
                        let attributes:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font: uiFont]
                        let attributedText = NSAttributedString(string: text, attributes: attributes)
                        
                        let textSize = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                        
                        if textSize.size.height > geo.size.height {
                            truncated = true
                            
                            self.size = textSize.size.height
                        }
                    }
                })
                .hidden()
        )
    }
}
