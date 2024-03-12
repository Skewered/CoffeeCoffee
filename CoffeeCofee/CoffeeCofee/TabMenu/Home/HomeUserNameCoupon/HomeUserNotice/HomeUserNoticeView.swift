//
//  HomeUserNoticeView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI
import FirebaseAuth

struct HomeUserNoticeView: View {
    
    @EnvironmentObject var stampPresenter: MembershipStampModel
    
    @StateObject var loginPresenter = LoginViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("알림")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            let userUID = loginPresenter.initializeUserID()
            
            ScrollView {
                ForEach(stampPresenter.stampDetailsData.filter { $0.userId == userUID }) { stampDetail in
                    HomeUserNoticeCell(stampDetail: stampDetail)
                                .padding()
                            }
                        }
        }
        .padding()
        
    }
}
