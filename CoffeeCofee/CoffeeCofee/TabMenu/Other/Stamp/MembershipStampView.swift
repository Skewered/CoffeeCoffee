//
//  MembershipStampView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//


import SwiftUI

struct MembershipStampView: View {
    
    var body: some View {
        VStack
        {
            HStack {
                Text("스탬프")
                Spacer()
                
                NavigationLink(destination: MembershipStampProfitView(), label: {
                    Text("적립내역보기")
                })
            }
            
            ZStack {
                MembershipStampGrid()
            }
            Text("유의사항")
                
            Text("""
            1. 첫번 째 유의사항
            2. 두번 째 유의사항
            3. 세번 째 유의사항
            """)
        }
    }
}



