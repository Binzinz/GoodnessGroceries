//
//  SymbolsHelpView.swift
//  GoodnessGroceries
//
//  Created by Benjamin FORNAGE on 21/07/2022.
//  Copyright © 2022 Flavio Matias. All rights reserved.
//

import Foundation
import SwiftUI

struct SymbolsHelpView: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @StateObject var categoriesVM = CategoriesViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    @State var selected: Set<Indicator> = []
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: true) {
            VStack (alignment: .leading, spacing: 10) {
                Divider()
                //HStack (spacing: 10) {
                    Image(systemName: "checkmark").foregroundColor(Color("GG_D_Green")).font(Font.system(size: 20, weight: .bold))
                    Text(NSLocalizedString("HELP_ATTRIBUTED", lang: UserSettings.language))
                Spacer()
                //}
                //HStack (spacing: 10) {
                    Text("Ø").font(Font.system(size: 20, weight: .bold)).foregroundColor(Color(.systemRed))
                    Text(NSLocalizedString("HELP_NOT_ATTRIBUTED", lang: UserSettings.language))
                Spacer()
                //}
                //HStack (spacing: 10) {
                    Text("n/a").font(Font.system(size: 20, weight: .regular)).foregroundColor(Color(.systemGray))
                    Text(NSLocalizedString("HELP_NOT_APPLICABLE", lang: UserSettings.language))
                Spacer()
                //}
            }.padding()
        }.navigationBarTitle(NSLocalizedString("HELP_PAGE_BUTTON_12", lang: UserSettings.language), displayMode: .inline)
    }
}

