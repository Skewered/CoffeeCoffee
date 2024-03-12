//
//  PaymentModel.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/12/05.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

class PaymentModel: ObservableObject {
    @StateObject var loginPresenter = LoginViewModel()

    @Published var paymentData =
    PaymentInfoData(
        id: "",
        userUID: "",
        cartItems: [],
        shopRequest: "",
        userRequest: "",
        coupon: nil,
        method: "",
        cashreceipt: "",
        cashUserReceipt: "",
        price: 0
    )
    
    var ref: DatabaseReference! = Database.database().reference()
    
    func savePaymentDataToFirebase(paymentData: PaymentInfoData) {
        let userUID = loginPresenter.initializeUserID()

        let couponData: [String: Any]?
            if let coupon = paymentData.coupon {
                couponData = [
                    "id": coupon.id,
                    "publisher": coupon.publisher,
                    "name": coupon.name,
                    "userId": coupon.userId,
                    "date": coupon.date,
                    "discountAmount": coupon.discountAmount,
                    "imageName": coupon.imageName,
                    "couponTapInfo": coupon.couponTapInfo
                ]
            } else {
                couponData = nil
            }
        
        let cartItemsData: [[String: Any]] = paymentData.cartItems.map { cartItem in
            return [
                "id": cartItem.id,
                "userEmail": cartItem.userEmail,
                "selectedCoffee": cartItem.selectedCoffee,
                "price": cartItem.price,
                "quantity": cartItem.quantity,
                "tumbler": cartItem.tumbler,
                "concentration": cartItem.concentration,
                "userId": cartItem.userId,
                "address": cartItem.address,
                "shopName": cartItem.shopName
            ]
        }
        
        
        let data: [String: Any] = [
            "userUID": userUID,
            "cartItems": cartItemsData,
            "shopRequest": paymentData.shopRequest,
            "userRequest": paymentData.userRequest,
            "coupon": couponData,
            "method": paymentData.method,
            "cashreceipt": paymentData.cashreceipt,
            "cashUserReceipt": paymentData.cashUserReceipt,
            "price": paymentData.price
        ]
        
        ref.child("paymentData").childByAutoId().setValue(data) { error, _ in
            if let error = error {
                print("Error saving data to Firebase: \(error.localizedDescription)")
            } else {
                print("Data saved to Firebase successfully!")
            }
        }
    }
    
    func saveStampDataToFirebase (shopName: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        let userUID = loginPresenter.initializeUserID()
        
        let data: [String: Any] = [
            "userId": userUID,
            "name": shopName,
            "date": formattedDate
        ]
        
        ref.child("StampData").childByAutoId().setValue(data) { error, _ in
            if let error = error {
                print("Error saving data to Firebase: \(error.localizedDescription)")
            } else {
                print("Data saved to Firebase successfully!")
            }
        }
    }
    
    func deleteCartItems(cartItemsToDelete: [CartItemData]) {
      let db = Database.database().reference()
      let cartItemRef = db.child("CartItemData")

      if !cartItemsToDelete.isEmpty {
          for cartItemID in cartItemsToDelete {
            let itemID = cartItemID.id
            let itemRef = cartItemRef.child(itemID)
            itemRef.removeValue { error, _  in
            if let error = error {
              print("Error deleting cart item \(cartItemID) from Firebase: \(error.localizedDescription)")
            } else {
                print("Cart data deleted from Firebase successfully!")
            }
          }
        }
      } else {
            print("Error deleting cart item")
      }
    }
}
