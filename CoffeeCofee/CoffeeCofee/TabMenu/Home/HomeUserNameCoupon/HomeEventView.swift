//
//  HomeEventView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct HomeEventView: View {
    
    @EnvironmentObject var homeUserPresenter: HomeUserViewModel

    var body: some View {
        VStack(spacing: 0) {
            Image(homeUserPresenter.bannerImages[homeUserPresenter.currentIndex])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .id(homeUserPresenter.currentIndex)
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .onAppear {
            if homeUserPresenter.autoScrollTimer == nil {
                homeUserPresenter.startAutoScrollIfNeeded()
            }
        }
    }
}
