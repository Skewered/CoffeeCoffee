//
//  HomeUserBarcodePopup.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct HomeUserBarcodePopup: View {
    @Binding var isPopupVisible: Bool
    
    
    
    var body: some View {
        VStack(spacing: 10) {
            Text("맴버십 바코드")
            Image("barcode1")
        }
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

