import SwiftUI

struct Help: View {
    
    @Environment(\.openURL) var openURL
    @EnvironmentObject var UserSettings: UserSettings
    var resetNavigationID: UUID
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 0) {
                VStack (spacing: 10) {
                    Image("GG-Logo-1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120)
                    Text(NSLocalizedString("WELCOME_PAGE_1_TEXT", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                    HStack (spacing: 10) {
                        Image("uni_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 80)
                        Image("pall_center")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 80)
                    }
                }.padding()
                Divider()
                Form {
                    Section(header: Text(NSLocalizedString("HELP", lang: UserSettings.language))) {
                        NavigationLink(destination: IndicatorsHelpView()) {
                            Text(NSLocalizedString("HELP_PAGE_BUTTON_0", lang: UserSettings.language))
                        }.isDetailLink(false)
                        NavigationLink(destination: ProductCategoriesHelpView()) {
                            Text(NSLocalizedString("HELP_PAGE_BUTTON_1", lang: UserSettings.language))
                        }
                        NavigationLink(destination: SymbolsHelpView()) {
                            Text(NSLocalizedString("HELP_PAGE_BUTTON_12", lang: UserSettings.language))
                        }
                        Button(action: {
                            openURL(URL(string: "https://food.uni.lu/goodness-groceries/")!)
                        }, label: {
                            Text(NSLocalizedString("HELP_PAGE_BUTTON_2", lang: UserSettings.language)).foregroundColor(.black)
                        })
                        Button(action: {
                            openURL(URL(string: "https://food.uni.lu/goodness-groceries/help/")!)
                        }, label: {
                            Text(NSLocalizedString("HELP_PAGE_BUTTON_3", lang: UserSettings.language)).foregroundColor(.black)
                        })
                        Button(action: {
                            openURL(URL(string: "https://food.uni.lu/goodness-groceries/contact-us/")!)
                        }, label: {
                            Text(NSLocalizedString("HELP_PAGE_BUTTON_4", lang: UserSettings.language)).foregroundColor(.black)
                        })
                    }
                }
            }
            .navigationBarTitle(NSLocalizedString("HELP", lang: UserSettings.language), displayMode: .inline)
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
            .id(resetNavigationID)
    }
}
