import Foundation
import Combine
import SwiftUI

class UserSettings: ObservableObject {
    static let shared = UserSettings()
    let objectWillChange = ObservableObjectPublisher()
    let sharedUserDefaults = UserDefaults(suiteName: "group.lu.uni.bicslab.goodness.groceries")
    
    var step: Int {
        get {
            return UserDefaults.standard.integer(forKey: "step")
        }
        set (step) {
            self.objectWillChange.send()
            UserDefaults.standard.set(step, forKey: "step")
            self.handleShowWelcome()
        }
    }
    
    var clientID: String {
        get {
            UserDefaults.standard.string(forKey: "clientID") ?? ""
        }
        set (id) {
            self.objectWillChange.send()
            UserDefaults.standard.set(id, forKey: "clientID")
        }
    }
    
    var statusRequested: Bool {
        get {
            UserDefaults.standard.bool(forKey: "statusRequested")
        }
        set (status) {
            self.objectWillChange.send()
            UserDefaults.standard.set(status, forKey: "statusRequested")
        }
    }
    
    var statusPhase2: Bool {
        get {
            UserDefaults.standard.bool(forKey: "statusPhase2")
        }
        set (status) {
            self.objectWillChange.send()
            UserDefaults.standard.set(status, forKey: "statusPhase2")
        }
    }
    var phase2_date: String {
        get {
            UserDefaults.standard.string(forKey: "phase2_date") ?? ""
        }
        set (phase2_date) {
            self.objectWillChange.send()
            UserDefaults.standard.set(phase2_date, forKey: "phase2_date")
        }
    }
    var phase1_date: String {
        get {
            UserDefaults.standard.string(forKey: "phase1_date") ?? ""
        }
        set (phase1_date) {
            self.objectWillChange.send()
            UserDefaults.standard.set(phase1_date, forKey: "phase1_date")
        }
    }
    
    var productsToReview: [String] {
        get {
            UserDefaults.standard.stringArray(forKey: "productsToReview") ?? []
        }
        set (products) {
            self.objectWillChange.send()
            UserDefaults.standard.set(products, forKey: "productsToReview")
        }
    }
    
    var language: String {
        get {
            if let userDefaults = sharedUserDefaults {
                return userDefaults.string(forKey: "language") ?? "undefined"
            }
            return "undefined"
        }
        set (language) {
            if let userDefaults = sharedUserDefaults {
                self.objectWillChange.send()
                userDefaults.set(language, forKey: "language")
                userDefaults.synchronize()
            }
        }
    }
    
    var deviceToken: String = "" {
        willSet { self.objectWillChange.send() }
    }
    
    var showSurvey: Bool = false {
        willSet { self.objectWillChange.send() }
    }
    
    var showWelcome: Bool = true {
        willSet { self.objectWillChange.send() }
    }
    
    //var showCountDown: Bool = true {
     //   willSet { self.objectWillChange.send() }
    //}
    
    var loading: Bool = false {
        willSet { self.objectWillChange.send() }
    }
    
    init() {
        self.handleShowWelcome()
    }
    
    func signIn() {
        self.loading = true
        NetworkManager.shared.fetchUserStatus(for: clientID) { response in
            switch response {
            case .success(let userData):
                switch userData.status {
                    case .requested, .archived:
                        self.statusRequested = true
                        break
                    case .valid:
                        self.statusRequested = false
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
                        self.phase2_date = userData.phase2_date ?? "1970-01-01"
                        self.phase1_date = userData.phase1_date ?? "1970-01-01"
                        break
                }
                self.handleShowWelcome()
                break
            case .failure(let type):
                appDelegate().popupManager.currentPopup = .error(type)
                break
            }
            self.loading = false
        }
    }
    
    func handleShowWelcome() {
        @EnvironmentObject var UserSettings: UserSettings
        print(step)
        print(statusRequested)
        //let calendar = Calendar.currentCalendar()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        let now = calendar.startOfDay(for: Date())
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let p2 = (dateFormatter.date(from: (phase2_date)) ?? dateFormatter.date(from: "1970-01-01"))!
        let diffInDays = Calendar.current.dateComponents([.day], from: now, to: p2).day
        if (diffInDays ?? 1 <= 0) {
            self.statusPhase2 = true
        }
        else {
            self.statusPhase2 = false
        }
        print("Phase2")
        print(statusPhase2)
        print(p2)
        print(now)
        if step == 6 && !statusRequested {
            step += 1
        }

        if step >= 6 && !statusRequested && statusPhase2 { // # of welcome pages
            self.showWelcome = false
            //self.showCountDown = false
        } else {
            self.showWelcome = true
            //self.showCountDown = true
        }
    }
}
