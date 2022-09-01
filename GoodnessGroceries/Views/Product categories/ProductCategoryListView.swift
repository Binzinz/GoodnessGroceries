import SwiftUI

struct ProductCategoryListView: View {
    
    let category: Category?
    @StateObject var categoriesVM = CategoriesViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: true) {
            VStack {
                ForEach(ProductCategory.allCases, id: \.self) { product_category in
                    if category != nil {
                        NavigationLink(destination: ProductListView(category: category!, product_category: product_category)) {
                            ProductCategoryRowView(product_category: product_category).foregroundColor(.black)
                        }
                    }
                    else {
                        NavigationLink(destination: ProductListView(category: nil, product_category: product_category)) {
                            ProductCategoryRowView(product_category: product_category).foregroundColor(.black)
                        }
                        
                    }
                    Divider()
                        
                }
                Spacer(minLength: 20)
                Divider()
                if category != nil {
                    NavigationLink(destination: ProductListView(category: category!, product_category: nil)) {
                        VStack (alignment: .leading) {
                            Spacer()
                            HStack {
                                Image("GG-AllC").resizable().frame(width: 60, height: 60)
                                Text(NSLocalizedString("ALL_CAT", lang: UserSettings.language)).font(.system(size: 20)).foregroundColor(Color(.black))
                                Spacer(minLength: 0)
                                Image("arrow_right").padding(.top, 4).frame(width: 20)
                            }
                            Divider()
                        }
                    }
                }
                else {
                    NavigationLink(destination: ProductListView(category: nil, product_category: nil)) {
                        VStack (alignment: .leading) {
                            Spacer()
                            HStack {
                                Image("GG-AllC").resizable().frame(width: 60, height: 60)
                                Text(NSLocalizedString("ALL_CAT", lang: UserSettings.language)).font(.system(size: 20)).foregroundColor(Color(.black))
                                Spacer(minLength: 0)
                                Image("arrow_right").padding(.top, 4).frame(width: 20)
                            }
                            Divider()
                        }
                    }
                    
                }
            }.padding(.horizontal).padding(.top, 5)
        }
    }
}
