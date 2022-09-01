import SwiftUI
import PermissionsSwiftUI
import WebKit

struct StatusRequestedView: View {
    
    @Environment(\.openURL) var openURL
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    @StateObject var welcomeVM = WelcomeViewModel()
    @State private var showWebView = false

    
    var body: some View {
        VStack {
            HStack (spacing: 25) {
                Image("GG-Logo-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            }.padding(.bottom, 15)
            
            VStack (alignment: .center, spacing: 30) {
                Text(NSLocalizedString("AUTHENTICATION_REQUESTED_VALID_TITLE", lang: UserSettings.language)).font(.title).fixedSize(horizontal: false, vertical: true)
                VStack (alignment: .leading, spacing: 15) {
                    Text(NSLocalizedString("AUTHENTICATION_REQUESTED_VALID_TEXT_1", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                    Text(NSLocalizedString("AUTHENTICATION_REQUESTED_VALID_TEXT_3", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                }
                BlueButton(label: NSLocalizedString("REOPEN_FORM", lang: UserSettings.language), action: {
                        DispatchQueue.main.async {
                            UserSettings.step -= 1
                            //openURL(URL(string: "https://food.uni.lu/projects/goodness-groceries/")!)
                        }
                }).padding(.top, 20)
                Spacer(minLength: 0)
                HStack (spacing: 10) {
                    Spacer(minLength: 0)
                    Image("uni_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120)
                    Image("pall_center")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120)
                    Spacer(minLength: 0)
                }
            }
        }.padding()
    }
    
    func login() {
        welcomeVM.login { success in
            if success {
                hideKeyboard()
                withAnimation {
                    welcomeVM.requestAccess()
                }
            } else {
                PopupManager.currentPopup = .message(title: NSLocalizedString("WRONG_FORMAT_ALERT_TITLE", lang: UserSettings.language), message: NSLocalizedString("WRONG_FORMAT_ALERT_TEXT", lang: UserSettings.language))
                notificationFeedback(.warning)
            }
        }
    }
}

struct WebView: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
