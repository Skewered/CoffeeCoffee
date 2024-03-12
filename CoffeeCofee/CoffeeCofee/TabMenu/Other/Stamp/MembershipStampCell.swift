//
//  MembershipStampCell.swift
//  CoffeeCofee
//
//  Created by 1 on 2024/02/17.
//

import SwiftUI

struct MembershipStampCell: View {
    @State private var isLabelVisible = false
    var stamp: StampData
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Button(action: {
                isLabelVisible = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    isLabelVisible = false
                }
            }) {
                Image(systemName: "cup.and.saucer.fill")
                    .font(.largeTitle)
                    .frame(width: 80, height: 80)
            }
            
            if isLabelVisible {
                VStack{
                    Text(stamp.name)
                        .font(.headline)
                    Text(stamp.date)
                        .font(.caption)
                }
                .foregroundColor(.white)
                .background(Color.black.opacity(0.7))
                .cornerRadius(8)
                .padding([.leading, .trailing], 16)
                .padding(.top, 8)
            }
            
        }
    }
}
