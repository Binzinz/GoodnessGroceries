import SwiftUI


struct PopupView<Content>: View where Content: View {
    
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            content()
        }
        .padding([.top, .horizontal])
        .padding(.bottom, 10)
        .background(Color.white)
        .cornerRadius(7)
        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
        .padding(.horizontal, 35)
    }
}

struct MessagePopup: View {
    
    @EnvironmentObject var PopupManager: PopupManager
    let title: String
    let text: String
    let buttonText: String? = nil
    
    var body: some View {
        PopupView {
            Text(title).font(.title)
            Text(text)
            BlueButton(label: buttonText ?? "Ok", action: {
                PopupManager.showPopup = false
            }).padding(.top, 8)
        }
    }
}

struct IndicatorPopup: View {
    
    let indicator: Indicator
    @EnvironmentObject var PopupManager: PopupManager
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        PopupView {
            
            VStack (alignment: .leading) {
                HStack {
                    Image(indicator.icon_name)
                    Text(NSLocalizedString(indicator.name, lang: UserSettings.language)).font(.system(size: 20)).fixedSize(horizontal: false, vertical: true)
                }
                Text(NSLocalizedString(indicator.general_description, lang: UserSettings.language))
                BlueButton(label: "Ok", action: {
                    PopupManager.showPopup = false
                }).padding(.top, 8)
            }
        }
    }
}

struct ProductIndicatorPopup: View {
    
    let productIndicator: ProductIndicator
    @EnvironmentObject var PopupManager: PopupManager
    @EnvironmentObject var UserSettings: UserSettings
    @Environment(\.openURL) var openURL
    var body: some View {
        PopupView {
            if let indicator = productIndicator.getIndicator() {
                VStack (alignment: .leading) {
                    HStack {
                        Image(indicator.icon_name)
                        Text(NSLocalizedString(indicator.name, lang: UserSettings.language)).font(.system(size: 20)).fixedSize(horizontal: false, vertical: true)
                    }
                    ScrollView(.vertical, showsIndicators: false) {
                    VStack (alignment: .leading, spacing: 15) {
                        Text(NSLocalizedString(productIndicator.description, lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                        
                        /*ForEach(productIndicator.sub_indicators, id: \.self) { productSubIndicator in
                            VStack (alignment: .leading, spacing: 0) {
                                Text(NSLocalizedString(productSubIndicator.name, lang: UserSettings.language)).font(.headline)
                                //Text(NSLocalizedString(productSubIndicator.description, lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                                ExpandableText(text: NSLocalizedString(productSubIndicator.description, lang: UserSettings.language))
                                            .lineLimit(4)//optional
                                            .animation(.easeOut)//optional
                                            .padding(.horizontal, 24)//optional
                                if !((productSubIndicator.file ?? "").isEmpty) {
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                        DispatchQueue.main.async {
                                            openURL(URL(string: productSubIndicator.file ?? "")!)
                                        }
                                        }, label: {
                                            Text(NSLocalizedString("MORE_PDF", lang: UserSettings.language))
                                        }).padding(20)
                                    }
                                }
                            }
                            if productSubIndicator.self != productIndicator.sub_indicators.last {
                                Divider()
                            }
                        }*/
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .topLeading
                      )
                    }
                    BlueButton(label: "Ok", action: {
                        PopupManager.showPopup = false
                    }).padding(.top, 8)
                }
            }
        }
    }
}

struct CategoryPopup: View {
    
    let category: Category
    @EnvironmentObject var PopupManager: PopupManager
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        PopupView {
            VStack (alignment: .leading) {
                HStack {
                    Image(category.icon_name)
                    Text(NSLocalizedString(category.name, lang: UserSettings.language)).font(.headline)
                }
                Text(NSLocalizedString(category.description, lang: UserSettings.language))
                BlueButton(label: "Ok", action: {
                    PopupManager.showPopup = false
                }).padding(.top, 8)
            }
        }
    }
}


struct ProductCategoryPopup: View {
    
    let Productcategory: ProductCategory
    let screenHeight = UIScreen.main.bounds.size.height
    @EnvironmentObject var PopupManager: PopupManager
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        PopupView {
            VStack (alignment: .leading) {
                HStack {
                    Image("GG_\(Productcategory.rawValue)")
                    Text(NSLocalizedString(Productcategory.name, lang: UserSettings.language)).font(.headline)
                }
                if ((NSLocalizedString(Productcategory.description, lang: UserSettings.language).count + NSLocalizedString(Productcategory.description2, lang: UserSettings.language).count) > 700 && screenHeight < 700)
                {
                    ScrollView(.vertical, showsIndicators: false) {
                        Text(NSLocalizedString(Productcategory.description, lang: UserSettings.language))
                        Text("")
                        Text(NSLocalizedString(Productcategory.description2, lang: UserSettings.language))
                    }
                }
                else {
                    Text(NSLocalizedString(Productcategory.description, lang: UserSettings.language))
                    Text("")
                    Text(NSLocalizedString(Productcategory.description2, lang: UserSettings.language))
                }
                BlueButton(label: "Ok", action: {
                    PopupManager.showPopup = false
                }).padding(.top, 8)
            }
        }
    }
}


struct NetworkErrorPopup: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    
    var body: some View {
        PopupView {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                Text(NSLocalizedString("POPUP_NETWORK_ERROR_TITLE", lang: UserSettings.language)).font(.title)
            }
            Text(NSLocalizedString("POPUP_NETWORK_ERROR_TEXT", lang: UserSettings.language))
            BlueButton(label: "Ok", action: {
                PopupManager.showPopup = false
            }).padding(.top, 8)
        }.onAppear {
            notificationFeedback(.error)
        }
    }
}

struct GeneralErrorPopup: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    
    var body: some View {
        PopupView {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                Text("Oops..").font(.title)
            }
            Text(NSLocalizedString("POPUP_GENERAL_ERROR_TEXT", lang: UserSettings.language))
            BlueButton(label: "Ok", action: {
                PopupManager.showPopup = false
            }).padding(.top, 8)
        }.onAppear {
            notificationFeedback(.error)
        }
    }
}

struct LanguagePopup: View {
    
    @EnvironmentObject var PopupManager: PopupManager
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        PopupView {
            VStack (alignment: .leading) {
                Text(NSLocalizedString("LANGUAGE", lang: UserSettings.language)).font(.title)
                HStack {
                    Spacer()
                    Button(action: {
                        UserSettings.language = "fr"
                        impactFeedback(.soft)
                    }, label: {
                        Image("fr").resizable().aspectRatio(contentMode: .fit).frame(width: 70).border(UserSettings.language == "fr" ? Color.black : Color.white, width: 2.5)
                    })
                    Spacer()
                    Spacer()
                    Button(action: {
                        UserSettings.language = "en"
                        impactFeedback(.soft)
                    }, label: {
                        Image("en").resizable().aspectRatio(contentMode: .fit).frame(width: 70).border(UserSettings.language == "en" ? Color.black : Color.white, width: 2.5)
                    })
                    Spacer()
                }
                Text(NSLocalizedString("LANGUAGE_CHANGE_LATER", lang: UserSettings.language)).font(.footnote)
                BlueButton(label: "Ok", action: {
                    PopupManager.showPopup = false
                }).padding(.top, 8)
            }
        }
    }
}

struct ProductImagePopup: View {
    @EnvironmentObject var UserSettings: UserSettings
    let image: String
    let name: String
    
    var body: some View {
        PopupView {
            VStack {
                Image(image).resizable().scaledToFit().frame(maxWidth: 400)
                Text(NSLocalizedString(name, lang: UserSettings.language).replacingOccurrences(of: " - ", with: "\n")).font(.system(size: 20))
            }
            
        }
    }
}

struct ThankYouPopup: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    
    var body: some View {
        PopupView {
            HStack {
                Spacer()
                Image("GG-Logo-2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 80)
                Image("uni_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 80)
                Spacer()
            }
            HStack {
                Spacer()
                Text(NSLocalizedString("THANK_YOU", lang: UserSettings.language)).font(.title)
                Spacer()
            }
            Text(NSLocalizedString("THANK_YOU_MESSAGE", lang: UserSettings.language))
            BlueButton(label: "Ok", action: {
                PopupManager.showPopup = false
            }).padding(.top, 8)
        }
    }
}
