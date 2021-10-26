//
//  PageView.swift
//  CurrentsNews
//
//  Created by Вадим Буркин on 26.10.2021.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]
    @State private var currentPage = 0
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
                    PageViewController(pages: pages, currentPage: $currentPage)
                    PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                        .frame(width: CGFloat(pages.count * 18))
                        .padding(.trailing)
        }
    }
}

//struct PageView_Previews: PreviewProvider {
//    static var previews: some View {
//        PageView(pages: <#T##[_]#>)
//    }
//}
