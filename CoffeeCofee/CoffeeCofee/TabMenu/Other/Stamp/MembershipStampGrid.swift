//
//  MembershipStampGrid.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI
import FirebaseAuth

struct MembershipStampGrid: View {
    @ObservedObject var presenter = MembershipStampModel()
    @StateObject var loginPresenter = LoginViewModel()

    var body: some View {
        
        let userUID = loginPresenter.initializeUserID()

        ZStack(alignment: .top) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 16) {
                    ForEach(0..<10) { _ in
                        Image(systemName: "cup.and.saucer")
                            .font(.largeTitle)
                            .frame(width: 80, height: 80)
                    }
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 16) {
                ForEach(presenter.stampData.filter { $0.userId == userUID }) { stamp in
                    ZStack(alignment: .top) {
                        MembershipStampCell(stamp: stamp)
                            .zIndex(1)
                    }
                }
            }
        }
        .onAppear {
            presenter.fetchstampDatas {
            }
        }
    }
}



