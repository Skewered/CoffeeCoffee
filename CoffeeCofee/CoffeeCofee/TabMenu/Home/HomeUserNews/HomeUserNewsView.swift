//
//  HomeUserNewsView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//


import SwiftUI

struct HomeUserNewsView: View {
    var body: some View {
        VStack{
            HStack {
                Text("새 소식")
                Spacer()
            }
            HomeUserNewsCell()
                .frame(width: UIScreen.main.bounds.width, height: 300)
        }
        .frame(width: UIScreen.main.bounds.width - 32.0)
        .padding()
    }
}
