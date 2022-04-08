import SwiftUI

struct ProductCategoryRowView: View {
    
    let product_category: ProductCategory
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (spacing: 15) {
                Image("GG_\(product_category.rawValue)").frame(width: 60)
                Text(NSLocalizedString(product_category.name, lang: UserSettings.language)).font(.headline)
                Spacer(minLength: 0)
                Image("arrow_right").padding(.top, 4)
            }
            HStack {
                Text(NSLocalizedString(product_category.description, lang: UserSettings.language)).font(.system(size: 14)).fixedSize(horizontal: false, vertical: true)
                Spacer(minLength: 20)
            }
        }
        .padding(.vertical, 5)
        .navigationBarTitle(NSLocalizedString("PRODUCT_CATEGORIES", lang: UserSettings.language))
    }
}
