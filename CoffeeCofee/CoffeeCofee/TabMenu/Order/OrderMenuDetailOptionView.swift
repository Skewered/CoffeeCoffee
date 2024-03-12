//
//  OrderMenuDetailOptionView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/09/03.
//

import SwiftUI
import FirebaseAuth

struct OrderMenuDetailOptionView: View {
    
    var menudata: CoffeeData
    var shopData: ShopData
    var totalPrice = 0
    
    @State private var showPrecautions = false
    @State private var concentration :[String] = ["연하게", "선택안함", "샷 추가", "2샷 추가"]
    @State private var select_concentration: String = "선택안함"
    @State private var tumbler :[String] = ["텀블러 사용", "선택안함"]
    @State private var select_tumbler: String = "선택안함"
    @State private var quantity = 1
    @State private var isAlertPresented = false
    @State private var isOrderViewPresented = false
    
    @EnvironmentObject var homeUserPresenter: HomeUserViewModel
    @EnvironmentObject var orderCartViewModel: OrderCartViewModel
    @EnvironmentObject var paymentModel: PaymentModel
    
    var body: some View {
        
        var totalPrice: Int {
            if select_concentration == "샷 추가" {
                let extraShotPrice = 500
                return quantity * (menudata.price + extraShotPrice)
            } else if select_concentration == "2샷 추가" {
                let extraShotPrice = 1000
                return quantity * (menudata.price + extraShotPrice)
            } else {
                return quantity * menudata.price
            }
        }
        
        NavigationView {
            VStack {
                HStack {
                    Text("퍼스널 옵션")
                    Spacer()
                    Button(action: {
                        showPrecautions.toggle()
                    }) {
                        Image(systemName: showPrecautions ?  "arrow.up" : "arrow.down")
                    }
                }
                if showPrecautions {
                    
                    if menudata.category == "Coffee" {
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 16) {
                            ForEach(concentration, id: \.self) { radioData in
                                OrderMenuDetailRadio(title: radioData, isSelected: select_concentration == radioData) {
                                    select_concentration = radioData
                                }
                            }
                        }
                    }
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 16) {
                        ForEach(tumbler, id: \.self) { radioData in
                            OrderMenuDetailRadio(title: radioData, isSelected: select_tumbler == radioData) {
                                select_tumbler = radioData
                            }
                        }
                    }
                }
                
                
                VStack {
                    HStack {
                        Text("주문 수량: \(quantity) 개") // 수정된 부분
                        Stepper("", value: $quantity, in: 1...10)
                    }
                    Text("\(totalPrice) 원")
                }
                
                HStack{
                    Button(action:
                            {
                        let newCartItem = CartItemData (
                            id: "",
                            userEmail: Auth.auth().currentUser?.email ?? "",
                            selectedCoffee: menudata.coffeeId,
                            price: totalPrice,
                            quantity: quantity,
                            tumbler: select_tumbler,
                            concentration: select_concentration,
                            userId: Auth.auth().currentUser?.uid ?? "",
                            address: shopData.address,
                            shopName: shopData.shopName
                        )
                        
                        orderCartViewModel.addCartItem(newCartItem)
                        isAlertPresented = true
                        //isOrderViewPresented = true
                    }, label: {
                        Text("장바구니")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    })
                    .frame(width: 100, height: 40)
                    .background(Color.brown)
                    .cornerRadius(20)
                }
            }
            .alert(isPresented: $isAlertPresented) {
                Alert(title: Text("장바구니로 이동하시겠습니까?"), message: nil, primaryButton: .default(Text("예"), action: {
                    isOrderViewPresented = true
                }), secondaryButton: .cancel(Text("아니요")))
            }
        }
      
        NavigationLink(destination:
            OrderCartView()
            .navigationBarBackButtonHidden(true)
            .environmentObject(orderCartViewModel), isActive: $isOrderViewPresented) { EmptyView() }
    }

}


