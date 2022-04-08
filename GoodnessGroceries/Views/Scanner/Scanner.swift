import SwiftUI
import CarBode
import AVFoundation
import PermissionsSwiftUI

struct Scanner: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    @State var product: Product?
    @State var scannerIsActive: Bool = true
    @State var torchLightIsActive: Bool = false
    @State var askPermissions: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .topLeading) {
                CameraNotAllowedView()
                if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized || !askPermissions {
                    CBScanner(supportBarcode: .constant([.qr]), torchLightIsOn: $torchLightIsActive, mockBarCode: .constant(BarcodeData(value: productsVM.products[0].code, type: .qr)), isActive: $scannerIsActive) { search in
                        let product_index = search.value.range(of: "https://food.daloos.uni.lu/?product=")?.upperBound ?? search.value.startIndex
                        if let product = self.productsVM.products.first(where: { $0.code == search.value[product_index...]}) {
                            if self.product != product {
                                self.product = product
                                notificationFeedback(.success)
                            }
                        } else {
                            withAnimation() {
                                self.product = nil
                            }
                        }
                    }.edgesIgnoringSafeArea(.all)
                    if let product = self.product {
                        VStack {
                            Spacer()
                            NavigationLink(destination: ProductView(product: product, category: nil)) {
                                ProductScannedView(product: product).foregroundColor(.black)
                                    .padding([.top, .leading])
                                    .background(Color.white)
                                    .cornerRadius(7)
                                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
                                    .padding(.horizontal, 20)
                            }.padding(.bottom, 35)
                        }
                    }
                    Button(action: {
                        torchLightIsActive.toggle()
                        impactFeedback(.medium)
                    }, label: {
                        ZStack {
                            Circle().foregroundColor(.white).frame(width: 50, height: 50)
                            Image(systemName: "flashlight.\(torchLightIsActive ? "on" : "off").fill").font(.system(size: 25, weight: .regular))
                        }
                    }).offset(x: 20, y: 20)
                }
            }
            .JMModal(showModal: $askPermissions, for: [.camera], autoDismiss: true, autoCheckAuthorization: true, restrictDismissal: false)
            
            .changeHeaderTo(NSLocalizedString("PERMISSIONS_MODAL_TITLE", lang: UserSettings.language))
            .changeHeaderDescriptionTo(NSLocalizedString("PERMISSIONS_MODAL_HEADER", lang: UserSettings.language))
            .changeBottomDescriptionTo(NSLocalizedString("PERMISSIONS_MODAL_FOOTER", lang: UserSettings.language))
            .setPermissionComponent(for: .camera, image: AnyView(Image(systemName: "camera.fill")), title: NSLocalizedString("PERMISSIONS_MODAL_CAMERA_TITLE", lang: UserSettings.language), description: NSLocalizedString("PERMISSIONS_MODAL_CAMERA_DESCRIPTION", lang: UserSettings.language))
            .setAccentColor(toPrimary: Color("GG_D_Blue"), toTertiary: Color(.systemRed))
            .onAppear {
                scannerIsActive = true
                product = nil
            }
            .onDisappear {
                scannerIsActive = false
                torchLightIsActive = false
            }
            .navigationBarTitle(NSLocalizedString("SCANNER", lang: UserSettings.language), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                print("Dismissing sheet view...")
                scannerIsActive = false
                torchLightIsActive = false
            }) {
                Text("Done").bold()
            })
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

