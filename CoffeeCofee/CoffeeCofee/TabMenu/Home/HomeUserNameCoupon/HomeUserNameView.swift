//
//  HomeUserNameView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct HomeUserNameView: View {
    @EnvironmentObject var loginPresenter: LoginViewModel
    
    var body: some View {
        HStack{
            Text("\(loginPresenter.userEmail)")
                .bold()
            Text(" 님")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16.0)
    }
}


