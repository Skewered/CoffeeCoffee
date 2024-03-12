//
//  UserLoginView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//


import SwiftUI

struct UserLoginView: View {
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    @State private var showMainTabView = false
    @State private var selectedTab = 0
    
    @EnvironmentObject var loginPresenter: LoginViewModel
    @EnvironmentObject var homeUserPresenter: HomeUserViewModel
    @EnvironmentObject var stampPresenter: MembershipStampModel
    @EnvironmentObject var crawlPresenter: CrawlModel
    @EnvironmentObject var couponPresenter: MembershipCouponModel
    @EnvironmentObject var prepaidCardPresenter: PrepaidCardViewModel

    
    var body: some View {
        VStack {
            Text("Email")
            TextField("이메일", text: $userEmail)
                .frame(width: 200, height: 40)
            
            Text("Password")
            SecureField("비밀번호", text: $userPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 200, height: 40)
            
            HStack {
                Button(action: {
                    loginPresenter.UserLogin(email: userEmail, password: userPassword, showMainTabView: $showMainTabView) { success in
                        if success {
                            loginPresenter.initializeUserID()
                            homeUserPresenter.fetchCoffeeData()
                            stampPresenter.fetchstampDetailsDatas()
                            crawlPresenter.crawlEvent() {
                            }
                            couponPresenter.fetchcouponDatas() {
                            }
                            prepaidCardPresenter.fetchPrepaidCards()
                        }
                    }
                }) {
                    Text("로그인")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .frame(width: 100, height: 40)
                .background(Color.brown)
                .cornerRadius(20)
                
                Button(action: {
                    loginPresenter.UserCreate(email: userEmail, password: userPassword)
                }) {
                    Text("회원가입")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .frame(width: 100, height: 40)
                .background(Color.brown)
                .cornerRadius(20)
            }
            
            Text(loginPresenter.errorMessage)
                            .foregroundColor(.red)
                            .padding()
        }
        .fullScreenCover (isPresented: $showMainTabView, content: {
            MainTabView(selectedTab: $selectedTab)
        })

    }
}


