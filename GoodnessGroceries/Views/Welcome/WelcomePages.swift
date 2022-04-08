import SwiftUI
import CarBode
import AVFoundation
import PermissionsSwiftUI
import Introspect
import CoreImage.CIFilterBuiltins

struct Welcome_page1: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager

    var body: some View {
        VStack {
            HStack {
                Image("GG-Logo-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            }.padding(.bottom, 15)
            
            VStack (alignment: .leading, spacing: 30) {
                HStack (spacing: 0) {
                    Spacer()
                    Text(NSLocalizedString("WELCOME_PAGE_1_TITLE", lang: UserSettings.language)).font(.title).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                    Spacer()
                }
                Text(NSLocalizedString("WELCOME_PAGE_1_TEXT", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    withAnimation {
                        UserSettings.step += 1
                    }
                })
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
}

struct Welcome_page2: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @State var isPresentingScanner: Bool = false
    @State var askPermissions: Bool = true
    
    
    var body: some View {
        VStack {
            HStack {
                Image("GG-Logo-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            }.padding(.bottom, 50)
            
            VStack (alignment: .center, spacing: 30) {
                VStack (spacing: 10) {
                    TextField(NSLocalizedString("CLIENT_ID", lang: UserSettings.language), text: $UserSettings.clientID
                              ,onEditingChanged: {changed in
                        print(changed)
                    }).introspectTextField { textField in
                        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                        let doneButton = UIBarButtonItem(title: NSLocalizedString("DONE", lang: UserSettings.language), style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                        doneButton.tintColor = .systemBlue
                        toolBar.items = [flexButton, doneButton]
                        toolBar.setItems([flexButton, doneButton], animated: true)
                        textField.inputAccessoryView = toolBar
                        textField.keyboardType = .numberPad
                    }
                
                    
                    Rectangle()
                        .frame(height: 1.0, alignment: .bottom)
                        .foregroundColor(.gray)
                }
                Text(NSLocalizedString("OR", lang: UserSettings.language)).font(.footnote)
                Button(action: {
                    self.isPresentingScanner = true
                }, label: {
                    Image(systemName: "qrcode.viewfinder").foregroundColor(Color("GG_D_Blue"))
                    Text(NSLocalizedString("SCAN_DIRECTLY", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true).foregroundColor(Color("GG_D_Blue"))
                }).padding()
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    UserSettings.step += 1
                })
                    
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
        .sheet(isPresented: self.$isPresentingScanner) {
            ZStack {
                CameraNotAllowedView()
                if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized || !askPermissions {
                    CBScanner(supportBarcode: .constant([.ean13]), scanInterval: .constant(0.0), mockBarCode: .constant(BarcodeData(value: "0000000001234", type: .ean13))) {
                        hideKeyboard()
                        self.isPresentingScanner = false
                        UserSettings.clientID = $0.value
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .JMModal(showModal: $askPermissions, for: [.camera], autoDismiss: true, autoCheckAuthorization: true)
            .changeHeaderTo(NSLocalizedString("PERMISSIONS_MODAL_TITLE", lang: UserSettings.language))
            .changeHeaderDescriptionTo(NSLocalizedString("PERMISSIONS_MODAL_HEADER", lang: UserSettings.language))
            .changeBottomDescriptionTo(NSLocalizedString("PERMISSIONS_MODAL_FOOTER", lang: UserSettings.language))
            .setPermissionComponent(for: .camera, image: AnyView(Image(systemName: "camera.fill")), title: NSLocalizedString("PERMISSIONS_MODAL_CAMERA_TITLE", lang: UserSettings.language), description: NSLocalizedString("PERMISSIONS_MODAL_CAMERA_DESCRIPTION", lang: UserSettings.language))
            .setAccentColor(toPrimary: Color("GG_D_Blue"), toTertiary: Color(.systemRed))
        }
    }
}

struct Welcome_page3: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack {
            HStack {
                Image("GG-Logo-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            }.padding(.bottom, 15)
            
            VStack (alignment: .leading, spacing: 0) {
                HStack (spacing: 0) {
                    Spacer()
                    Text(NSLocalizedString("WELCOME_PAGE_3_TITLE", lang: UserSettings.language)).font(.title).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                    Spacer()
                }.padding(.bottom, 10)
                Text(NSLocalizedString("WELCOME_PAGE_3_TEXT", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                CategoryIconsGridView()
                Spacer(minLength: 0)
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    withAnimation {
                        UserSettings.step += 1
                    }
                })
            }
        }.padding()
    }
}

struct Welcome_page4: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @StateObject var categoriesVM = CategoriesViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Image("GG-Logo-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            }.padding(.bottom, 15)
            
            VStack (alignment: .center, spacing: 10) {
                Text(NSLocalizedString("WELCOME_PAGE_4_TITLE", lang: UserSettings.language)).font(.system(size: 20, weight: .bold))
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        ForEach(categoriesVM.categories) {
                            WelcomeCategoryCellView(category: $0)
                        }
                    }.padding(.bottom)
                    .padding(.top, 5)
                }
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    withAnimation {
                        UserSettings.step += 1
                    }
                })
            }
        }.padding()
    }
}

struct Welcome_page5: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @StateObject var welcomeVM = WelcomeViewModel()
    @EnvironmentObject var PopupManager: PopupManager
    
    var body: some View {
        VStack {
            HStack {
                Image("GG-Logo-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            }.padding(.bottom, 15)
            
            VStack (alignment: .center, spacing: 10) {
                Text(NSLocalizedString("WELCOME_PAGE_5_TITLE", lang: UserSettings.language)).font(.system(size: 20, weight: .bold))
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        ForEach(ProductCategory.allCases, id: \.self) {
                            WelcomeProductCategoryCellView(Productcategory: $0)
                        }
                    }.padding(.bottom)
                    .padding(.top, 5)
                }
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    withAnimation {
                        login()
                    }
                })
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

struct Welcome_page6: View {
    
    @EnvironmentObject var UserSettings: UserSettings

    var body: some View {
        VStack {
            HStack {
                Image("GG-Logo-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            }.padding(.bottom, 15)
            
            VStack (alignment: .leading, spacing: 10) {
                HStack {
                    Spacer(minLength: 0)
                    Text(NSLocalizedString("WELCOME_PAGE_NOTIFICATIONS_TITLE", lang: UserSettings.language)).font(.title)
                    Spacer(minLength: 0)
                }
                ScrollView(.vertical, showsIndicators: true) {
                    VStack (spacing: 10) {
                        Text(NSLocalizedString("WELCOME_PAGE_NOTIFICATIONS_TEXT_1", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                        Text(NSLocalizedString("WELCOME_PAGE_NOTIFICATIONS_TEXT_2", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                    }
                }
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _,_  in
                        DispatchQueue.main.async {
                            UserSettings.step += 1
                        }
                    }
                })
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
}

struct Welcome_page7: View {
    @EnvironmentObject var UserSettings: UserSettings
    @State var dataString = "123"
    @State var barcodeType = CBBarcodeView.BarcodeType.qrCode
    @State var rotate = CBBarcodeView.Orientation.up
    
    var body: some View {
        VStack {
            HStack {
                Image("GG-Logo-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            }.padding(.bottom, 15)
            
            VStack (alignment: .leading, spacing: 20) {
                HStack (spacing: 0) {
                    Spacer()
                    Text(NSLocalizedString("WELCOME_PAGE_6_TITLE", lang: UserSettings.language)).font(.title).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                    Spacer()
                }
                Text(NSLocalizedString("WELCOME_PAGE_6_TEXT", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                Spacer(minLength: 0)
                HStack (spacing: 0) {
                    Spacer()
                    CBBarcodeView(data: $dataString, barcodeType: $barcodeType, orientation: $rotate, onGenerated: nil).frame(width: 205, height: 210).opacity(0.9)
                    Spacer()
                }
                Spacer(minLength: 0)
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    withAnimation {
                        UserSettings.step += 1
                    }
                })
            }
        }.padding()
    }
}

struct Welcome_page8: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack {
            HStack {
                Image("GG-Logo-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            }.padding(.bottom, 15)
            
            VStack (alignment: .leading, spacing: 0) {
                HStack (spacing: 0) {
                    Spacer()
                    Text(NSLocalizedString("WELCOME_PAGE_7_TITLE", lang: UserSettings.language)).font(.title).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                    Spacer()
                }
                Text(NSLocalizedString("WELCOME_PAGE_7_TEXT", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true).padding(.top, 20)
                CategoryIconsGridView()
                Spacer(minLength: 0)
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    withAnimation {
                        UserSettings.step += 1
                    }
                })
                
                
            }
        }.padding()
    }
}

struct Welcome_page9: View {
    
    @Environment(\.openURL) var openURL
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    @StateObject var welcomeVM = WelcomeViewModel()
    @State var checkState:Bool = false ;
    var body: some View {
        VStack {
            HStack (spacing: 25) {
                Image("GG-Logo-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            }.padding(.bottom, 15)
            
            VStack (alignment: .center, spacing: 30) {
                Text(NSLocalizedString("AUTHENTICATION_REQUESTED_TITLE", lang: UserSettings.language)).font(.title)
                VStack (alignment: .leading, spacing: 15) {
                    Text(NSLocalizedString("AUTHENTICATION_REQUESTED_TEXT_1", lang: UserSettings.language))
                    Text(NSLocalizedString("AUTHENTICATION_REQUESTED_TEXT_2", lang: UserSettings.language))
                }
                Spacer(minLength: 0)
                
                self.checkState ?
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    withAnimation {
                        UserSettings.step += 1
                    }
                }).padding(.top, 20)
                :
                BlueButton(label: NSLocalizedString("OPEN_FORM", lang: UserSettings.language), action: {
                    withAnimation {
                        openURL(URL(string: "https://food.uni.lu/projects/goodness-groceries/")!)
                    }
                }).padding(.top, 20)
                Button(action:
                           {
                               //1. Save state
                               self.checkState = !self.checkState
                               print("State : \(self.checkState)")


                       }) {
                           HStack(spacing: 0) {
                                Spacer()
                                       //2. Will update according to state
                               Image(systemName: self.checkState ? "checkmark.square": "square")
                               Text(" " + NSLocalizedString("WELCOME_PAGE_7_TEXT2", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true).foregroundColor(Color.black)
                               Spacer()

                           }
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
            }
        }.padding()
    }
}



extension  UITextField {
   @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
      self.resignFirstResponder()
   }
}
