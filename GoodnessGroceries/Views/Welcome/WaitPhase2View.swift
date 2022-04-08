import SwiftUI
import PermissionsSwiftUI

struct WaitPhase2View: View {
    
    @Environment(\.openURL) var openURL
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    @StateObject var welcomeVM = WelcomeViewModel()
    var body: some View {
        VStack {
            HStack (spacing: 25) {
                Image("GG-Logo-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            }.padding(.bottom, 15)
            
            VStack (alignment: .center, spacing: 30) {
                Text(NSLocalizedString("AUTHENTICATION_REQUESTED_WAIT_TITLE", lang: UserSettings.language)).font(.title)
                VStack (alignment: .leading, spacing: 15) {
                    Text(NSLocalizedString("AUTHENTICATION_REQUESTED_WAIT_TEXT_1", lang: UserSettings.language) + " " + UserSettings.phase1_date.localize_date() + ".")
                    Text(NSLocalizedString("AUTHENTICATION_REQUESTED_WAIT_TEXT_2", lang: UserSettings.language))
                    Text(NSLocalizedString("AUTHENTICATION_REQUESTED_WAIT_TEXT_3", lang: UserSettings.language))
                }
                Spacer(minLength: 0)
                HStack (spacing: 10) {
                    Spacer(minLength: 0)
                    Text(UserSettings.phase2_date.day_left() + " " + NSLocalizedString("AUTHENTICATION_REQUESTED_WAIT_TEXT_4", lang: UserSettings.language)).font(.system(size: 56.0))
                    Spacer(minLength: 0)
                }
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
                HStack (spacing: 10) {
                    Link("Goodness Groceries homepage", destination: URL(string: "https://food.uni.lu/goodness-groceries")!).font(.system(size: 14.0))
                    Spacer(minLength: 0)
                    Link("Contact us", destination: URL(string: "https://food.uni.lu/goodness-groceries/contact-us")!).font(.system(size: 14.0))
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

extension String {
    func day_left() -> String {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        let now = calendar.startOfDay(for: Date())
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let p2 = (dateFormatter.date(from: self) ?? dateFormatter.date(from: "1970-01-01"))!
        let diffInDays = Calendar.current.dateComponents([.day], from: now, to: p2).day ?? -1
        return String(diffInDays)
    }
    
    func localize_date() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let p2 = (dateFormatter.date(from: self) ?? dateFormatter.date(from: "1970-01-01"))!
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier:  UserSettings.shared.language)
        return dateFormatter.string(from: p2)
    }
}
