//
//  PrepaidPrecautionsView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct PrepaidPrecautionsView: View {
    @State private var showPrecautions = false
    
    var body: some View {
        VStack{
            HStack {
                Text("유의사항")
                Spacer()
                Button(action: {
                    showPrecautions.toggle()
                }) {
                    Image(systemName: showPrecautions ?  "arrow.up" : "arrow.down")
                }
            }
            
            if showPrecautions {
                Text("""
                           1. 첫 번째 유의사항
                           2. 두 번째 유의사항
                           3. 세 번째 유의사항
                           """)
                .padding(.horizontal, 16)
            }
        }
    }
}
