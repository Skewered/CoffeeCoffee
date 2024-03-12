//
//  HomeUserNewsCell.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct HomeUserNewsCell: View {
    @EnvironmentObject var crawlPresenter: CrawlModel

    var body: some View {
        VStack {
            TabView {
                ForEach(crawlPresenter.events) { event in
                    EventSectionItemView(event: event)
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}




