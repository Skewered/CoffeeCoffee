//
//  OrderCartViewModel.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/09/08.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase
import GoogleMaps

class OrderCartViewModel: ObservableObject {
    
    @Published var cartItems: [CartItemData] = []
    @Published var cartItemsForShop: [CartItemData] = []
    @Published var shopData = ShopData()
    @Published var showOrderCartView = false
    @Published var totalPriceByShop: [String: Int] = [:]

    @StateObject var loginPresenter = LoginViewModel()

    @Environment(\.colorScheme) var colorScheme
    
    var ref: DatabaseReference! = Database.database().reference() //
      
    func addCartItem(_ item: CartItemData) {
        
        let data: [String: Any] = [
            "userEmail": item.userEmail,
            "selectedCoffee": item.selectedCoffee,
            "price": item.price,
            "quantity": item.quantity,
            "tumbler": item.tumbler,
            "concentration": item.concentration,
            "userId": item.userId,
            "address": item.address,
            "shopName": item.shopName
        ]
        
        ref.child("CartItemData").childByAutoId().setValue(data) { error, _ in
            if let error = error {
                print("Error saving data to Firebase: \(error.localizedDescription)")
            } else {
                print("Data saved to Firebase successfully!")
            }
        }
    }
    
    func fetchCartItem(completion: @escaping () -> Void) {
        
        let db = Database.database().reference()
        let userUID = loginPresenter.initializeUserID()

        db.child("CartItemData").queryOrdered(byChild: "userId").queryEqual(toValue: userUID ).observeSingleEvent(of: .value, with:  { snapshot in
            guard let snapshotDict = snapshot.value as? [String: Any] else {
                // 처리할 데이터가 없는 경우 또는 데이터 구조가 다른 경우
                print("Error: Invalid snapshot format or no data found.")
                return
            }
            
            var CartItems: [CartItemData] = []
            for (key, value) in snapshotDict {
                if  let cartItemDict = value as? [String: Any],
                    let userEmail = cartItemDict["userEmail"] as? String,
                    let selectedCoffee = cartItemDict["selectedCoffee"] as? String,
                    let price = cartItemDict["price"] as? Int,
                    let quantity = cartItemDict["quantity"] as? Int,
                    let tumbler = cartItemDict["tumbler"] as? String,
                    let concentration = cartItemDict["concentration"] as? String,
                    let address = cartItemDict["address"] as? String,
                    let shopName = cartItemDict["shopName"] as? String,
                    let userUID = cartItemDict["userId"] as? String {
                    let cartItem = CartItemData(
                        id: key,
                        userEmail: userEmail,
                        selectedCoffee: selectedCoffee,
                        price: price,
                        quantity: quantity,
                        tumbler: tumbler,
                        concentration: concentration,
                        userId: userUID,
                        address: address,
                        shopName: shopName
                        
                    )
                    CartItems.append(cartItem)
                    
                }
            }
            self.cartItems = CartItems
            completion()
        })
    }

    func fetchTotalPriceByShop(shopName: String) {
        
        let cartItemsForShop = cartItems.filter { $0.shopName == shopName }
        let totalPrice = cartItemsForShop.reduce(0) { $0 + $1.price }
        totalPriceByShop[shopName] = totalPrice

    }
    
    func deleteCartItem(cartItemId: String) {
        let ref = Database.database().reference().child("CartItemData").child(cartItemId)
        ref.removeValue { error, _ in
            if let error = error {
                print("Error deleting item from Firebase: \(error.localizedDescription)")
            } else {
                print("Item deleted from Firebase successfully!")
            }
        }
    }
    
    func OrderAnimate(selectedPicker: Binding<OrderMenuTapInfo>) -> some View {
        HStack {
            ForEach(OrderMenuTapInfo.allCases, id: \.self) { item in
                HStack {
                    self.OrderButton(selectedPicker: selectedPicker,item: item)
                }
            }
        }
    }
    
    func OrderButton(selectedPicker: Binding<OrderMenuTapInfo>, item: OrderMenuTapInfo) -> some View {
        VStack {
            Text(item.rawValue)
                .font(.title3)
                .frame(maxWidth: .infinity/4, minHeight: 50)
                .foregroundColor(colorScheme == .light ? .black : .white)
        }
        .background(
            Capsule()
                .fill(selectedPicker.wrappedValue == item ? Color.brown : Color.white)
                .overlay(
                    Capsule()
                        .stroke(Color.black, lineWidth: 1)
                )
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                selectedPicker.wrappedValue = item
            }
        }
    }
}
