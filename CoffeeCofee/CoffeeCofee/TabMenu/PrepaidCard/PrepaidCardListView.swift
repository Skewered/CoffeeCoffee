//
//  PrepaidCardListView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI
import FirebaseAuth

struct PrepaidCardListView: View {
    @EnvironmentObject var prepaidCardPresenter: PrepaidCardViewModel
    @StateObject var loginPresenter = LoginViewModel()
    
    var body: some View {
        TabView {
            let userUID = loginPresenter.initializeUserID()
            
            ForEach(prepaidCardPresenter.prepaidCards.filter { $0.userId == userUID  }) { card in
                VStack {
                    Image(card.design)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .tag(card.id)
                    Text(card.cardName)
                    Text("\(card.chargeAmount) 원")
                    
                    HStack {
                        NavigationLink(destination: PrepaidCardChargeView(data: card)) {
                            Image(systemName: "creditcard")
                            Text("카드 충전")
                        }
                    }
                    Image("barcode1")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()
                }
            }
            
            
            NavigationLink(destination: PrepaidCardCreateView()) {
                ZStack {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 200, height: 100)
                    
                    Text("카드 추가")
                        .foregroundColor(.white)
                        .font(.title)
                }
                
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}
