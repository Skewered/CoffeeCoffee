//
//  MembershipStampProfitSelectedPickerView.swift
//  CoffeeCofee
//
//  Created by 1 on 2024/02/17.
//

import SwiftUI

struct MembershipStampProfitSelectedPickerView: View {
    
    var stampInfo: StampProfitInfo
    
    @EnvironmentObject var stampPresenter: MembershipStampModel
    @StateObject var loginPresenter = LoginViewModel()

    init(stampInfo: StampProfitInfo) {
            self.stampInfo = stampInfo
    }
    
    var body: some View {
        
        let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
        let threeMonthAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())!
        let sixMonthAgo = Calendar.current.date(byAdding: .month, value: -6, to: Date())!
        let userUID = loginPresenter.initializeUserID()

        ScrollView(.vertical, showsIndicators: false) {
            switch stampInfo {
            case .oneweak:
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(stampPresenter.stampDetailsData.filter { $0.userId == userUID }, id: \.self ) { stamp in
                                if let stampDate = stamp.date.toDate(),  stampDate >= weekAgo  {
                                    MembershipStampProfitCell(stampDetails: stamp)
                                        .background(Color.white)
                                               .cornerRadius(10)
                                               .padding(.horizontal, 8)
                                               .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                }
            case .onemonth:
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(stampPresenter.stampDetailsData.filter { $0.userId == userUID }, id: \.self ) { stamp in
                                if let stampDate = stamp.date.toDate(),  stampDate >= oneMonthAgo  {
                                    MembershipStampProfitCell(stampDetails: stamp)
                                        .background(Color.white)
                                               .cornerRadius(10)
                                               .padding(.horizontal, 8)
                                               .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                }
            case .threemonth:
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(stampPresenter.stampDetailsData.filter { $0.userId == userUID }, id: \.self ) { stamp in
                                if let stampDate = stamp.date.toDate(),  stampDate >= threeMonthAgo  {
                                    MembershipStampProfitCell(stampDetails: stamp)
                                        .background(Color.white)
                                               .cornerRadius(10)
                                               .padding(.horizontal, 8)
                                               .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                }
            case .sixmonth:
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(stampPresenter.stampDetailsData.filter { $0.userId == userUID }, id: \.self ) { stamp in
                                if let stampDate = stamp.date.toDate(),  stampDate >= sixMonthAgo  {
                                    MembershipStampProfitCell(stampDetails: stamp)
                                        .background(Color.white)
                                               .cornerRadius(10)
                                               .padding(.horizontal, 8)
                                               .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
