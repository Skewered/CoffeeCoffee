//
//  CartDetailView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/11/06.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct CartDetailView: View {
    var shopName: String
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.refresh) private var refresh

    @EnvironmentObject var cartPresenter: OrderCartViewModel
    @EnvironmentObject var paymentPresenter: PaymentModel
    @EnvironmentObject var homeUserPresenter: HomeUserViewModel
     
    @State private var isPaymentViewActive: Bool = false
    @State private var showDeleteConfirmation = false
    @State private var itemToDelete: CartItemData?
    
    init(shopName: String) {
        self.shopName = shopName
    }
    
    var body: some View {
        
        let cartItemsForShop = cartPresenter.cartItems.filter { $0.shopName == shopName }
        NavigationView {
            VStack {
                ForEach(Array(cartItemsForShop.enumerated()), id: \.element.id) { index, item in
                    if let coffee = homeUserPresenter.coffeeData.first(where: { $0.coffeeId == item.selectedCoffee }) {
                        HStack {
                            CartDetailCell(coffee: coffee, item: item)
                            
                            Spacer()
                            
                            Button(action: {
                                itemToDelete = item
                                showDeleteConfirmation = true
                            }) {
                                Text("X")
                            }
                            .padding(16)
                        }
                        
                    } else {
                        Text("해당 메뉴를 찾을 수 없습니다.")
                    }
                }
                .alert(isPresented: $showDeleteConfirmation) {
                    Alert(
                        title: Text("장바구니에서 삭제"),
                        message: Text("이 항목을 정말 삭제하시겠습니까?"),
                        primaryButton: .destructive(Text("삭제"), action: {
                            if let itemToDelete = itemToDelete {
                                cartPresenter.deleteCartItem(cartItemId: itemToDelete.id)
                                cartPresenter.fetchCartItem() {
                                    cartPresenter.fetchTotalPriceByShop(shopName: shopName)
                                }
                            }
                        }),
                        secondaryButton: .cancel(Text("취소"))
                    )
                }
                
                Text("합계금액 : \(cartPresenter.totalPriceByShop[shopName] ?? 0)")
                    .font(.headline)
                    .padding(.bottom, 20)
                
                HStack {
                    Button(action: {
                        cartPresenter.cartItemsForShop = cartItemsForShop
                        paymentPresenter.paymentData.cartItems = cartItemsForShop
                        
                        isPaymentViewActive = true
                        
                    }) {
                        Text("주문하기")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(width: 100, height: 40)
                            .background(Color.brown)
                            .cornerRadius(20)
                    }
                    .frame(width: 150, height: 40)
                    .background(Color.brown)
                    .cornerRadius(20)
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("닫기")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(width: 100, height: 40)
                            .background(Color.brown)
                            .cornerRadius(20)
                    }
                    .frame(width: 150, height: 40)
                    .background(Color.brown)
                    .cornerRadius(20)
                }
                
                NavigationLink(
                    destination: PaymentView(shopName: shopName)
                        .navigationBarBackButtonHidden(true),
                    isActive: $isPaymentViewActive
                ) { EmptyView() }
                .hidden()
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("<")
                    }
                }
            }
        }
    }
}


