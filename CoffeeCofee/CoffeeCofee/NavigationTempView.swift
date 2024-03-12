//
//  NavigationTempView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/13.
//


import SwiftUI

struct NavigationTempView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            Text("Navigation_Temp View!!")
            Button("이전 화면으로") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
