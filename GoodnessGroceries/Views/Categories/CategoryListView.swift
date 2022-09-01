import SwiftUI

struct CategoryListView: View {
    
    @StateObject var categoriesVM = CategoriesViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    var body: some View {
       
       
        VStack (spacing: 0) {
            ForEach(categoriesVM.categories, id: \.self) { category in
                CategoryRowView(category: category).foregroundColor(.black)
                Divider()
            }
        }
        Spacer(minLength: 20)
        Divider()
        NavigationLink(destination: ProductCategoryListView(category: nil)) {
            VStack (alignment: .leading) {
                Spacer()
                HStack {
                    Image("GG-All").resizable().frame(width: 60, height: 60)
                    Text(NSLocalizedString("ALL_IND", lang: UserSettings.language)).font(.system(size: 20)).foregroundColor(Color(.black))
                    Spacer(minLength: 0)
                    Image("arrow_right").padding(.top, 4).frame(width: 20)
                }
                Divider()
            }
        }
        
    }
}
