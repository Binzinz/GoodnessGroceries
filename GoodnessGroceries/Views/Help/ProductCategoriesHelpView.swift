import SwiftUI

struct ProductCategoriesHelpView: View {
    
    
    @StateObject var categoriesVM = CategoriesViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    @State var selected: Set<String> = []
    var body: some View {
        ScrollView (.vertical, showsIndicators: true) {
            VStack (alignment: .leading, spacing: 10) {
                HStack (spacing: 15) {
                    Image("GG_local_organic").frame(width: 50)
                    Text(NSLocalizedString("PRODUCT_CATEGORY_LOCAL_ORGANIC", lang: UserSettings.language)).font(.system(size: 20)).bold().fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 0)
                    Image("arrow_right").rotationEffect(.degrees(selected.contains("local_organic") ? 90 : 0))
                }
                if selected.contains("local_organic") {
                    Text(NSLocalizedString("PRODUCT_CATEGORY_LOCAL_DESC", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                    Text(NSLocalizedString("PRODUCT_CATEGORY_ORGANIC_DESC", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding()
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.linear(duration: 0.15)) {
                    if selected.contains("local_organic") {
                        selected.remove("local_organic")
                    } else {
                        selected.insert("local_organic")
                    }
                }
            }
            
            VStack (alignment: .leading, spacing: 10) {
                HStack (spacing: 15) {
                    Image("GG_imported_organic").frame(width: 50)
                    Text(NSLocalizedString("PRODUCT_CATEGORY_IMPORTED_ORGANIC", lang: UserSettings.language)).font(.system(size: 20)).bold().fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 0)
                    Image("arrow_right").rotationEffect(.degrees(selected.contains("imported_organic") ? 90 : 0))
                }
                if selected.contains("imported_organic") {
                    Text(NSLocalizedString("PRODUCT_CATEGORY_IMPORTED_DESC", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                    Text(NSLocalizedString("PRODUCT_CATEGORY_ORGANIC_DESC", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding()
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.linear(duration: 0.15)) {
                    if selected.contains("imported_organic") {
                        selected.remove("imported_organic")
                    } else {
                        selected.insert("imported_organic")
                    }
                }
            }
            
            VStack (alignment: .leading, spacing: 10) {
                HStack (spacing: 15) {
                    Image("GG_local_conventional").frame(width: 50)
                    Text(NSLocalizedString("PRODUCT_CATEGORY_LOCAL_CONVENTIONAL", lang: UserSettings.language)).font(.system(size: 20)).bold().fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 0)
                    Image("arrow_right").rotationEffect(.degrees(selected.contains("local_conventional") ? 90 : 0))
                }
                if selected.contains("local_conventional") {
                    Text(NSLocalizedString("PRODUCT_CATEGORY_LOCAL_DESC", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                    Text(NSLocalizedString("PRODUCT_CATEGORY_CONVENTIONAL_DESC", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding()
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.linear(duration: 0.15)) {
                    if selected.contains("local_conventional") {
                        selected.remove("local_conventional")
                    } else {
                        selected.insert("local_conventional")
                    }
                }
            }
            
            VStack (alignment: .leading, spacing: 10) {
                HStack (spacing: 15) {
                    Image("GG_imported_conventional").frame(width: 50)
                    Text(NSLocalizedString("PRODUCT_CATEGORY_IMPORTED_CONVENTIONAL", lang: UserSettings.language)).font(.system(size: 20)).bold().fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 0)
                    Image("arrow_right").rotationEffect(.degrees(selected.contains("imported_conventional") ? 90 : 0))
                }
                if selected.contains("imported_conventional") {
                    Text(NSLocalizedString("PRODUCT_CATEGORY_IMPORTED_DESC", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                    Text(NSLocalizedString("PRODUCT_CATEGORY_CONVENTIONAL_DESC", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding()
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.linear(duration: 0.15)) {
                    if selected.contains("imported_conventional") {
                        selected.remove("imported_conventional")
                    } else {
                        selected.insert("imported_conventional")
                    }
                }
            }
        }.navigationBarTitle(NSLocalizedString("HELP_PAGE_BUTTON_1", lang: UserSettings.language), displayMode: .inline)
    }
}

