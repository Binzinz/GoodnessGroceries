import SwiftUI

struct ProductListView: View {
    
    let category: Category?
    let product_category: ProductCategory?
    @EnvironmentObject var UserSettings: UserSettings
    @StateObject var productsVM = ProductsViewModel()
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: true) {
            VStack {
                if products.count > 0 {
                    ForEach(products, id: \.self) { product in
                        NavigationLink(destination: ProductView(product: product, category: category)) {
                            ProductRowView(product: product, category: category)
                                .foregroundColor(.black)
                                .navigationBarTitle(NSLocalizedString("PRODUCTS", lang: UserSettings.language))
                        }
                        Divider()
                    }
                } else {
                    Text(NSLocalizedString("NO_PRODUCTS_FOUND", lang: UserSettings.language)).padding(.vertical, 10)
                }
            }.padding(.horizontal).padding(.top, 5)
        }
    }
    
    var products: [Product] {
        return self.productsVM.products.filter { product in
            for productIndicator in product.indicators {
                if let indicator = self.productsVM.indicators.first(where: { $0.id == productIndicator.id }) {
                    if category != nil && product_category != nil {
                        if indicator.category_id == category!.id && product.category == product_category {
                            return true
                        }
                    }
                    else if category == nil && product_category == nil {
                        return true
                    }
                    else if category == nil &&  product_category != nil {
                        if product.category == product_category {
                            return true
                        }
                    }
                    else if product_category == nil && category != nil {
                        if indicator.category_id == category!.id {
                            return true
                        }
                    }
                    else {
                        return false
                    }
                }
            }
            return false
        }
    }
}
