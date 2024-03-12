//
//  MembershipCouponModel.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MembershipCouponModel: ObservableObject {
    
    @Published var couponData: [CouponData] = []
    @Published var selectedCoupon: CouponData?
    
    @StateObject var loginPresenter = LoginViewModel()

    func setSelectedCoupon(_ newCoupon: CouponData) {
        selectedCoupon = newCoupon
        objectWillChange.send()
      }
    
    func fetchcouponDatas(completion: @escaping () -> Void) {
        let db = Database.database().reference()
        let userUID = loginPresenter.initializeUserID()

        db.child("CouponData").queryOrdered(byChild: "userId").queryEqual(toValue: userUID ).observeSingleEvent(of: .value, with:  { snapshot in

            guard let snapshotDict = snapshot.value as? [String: Any] else {
                print("Error: Invalid snapshot format or no data found.")
                return
            }
            
            var couponDatas: [CouponData] = []
            for (key, value) in snapshotDict {
                if  let cardDict = value as? [String: Any],
                    
                    let publisher = cardDict["publisher"] as? String,
                    let name = cardDict["name"] as? String,
                    let userId = cardDict["userId"] as? String,
                    let date = cardDict["date"] as? String,
                    let discountAmount = cardDict["discountAmount"] as? Int,
                    let imageName = cardDict["imageName"] as? String,
                    let couponTapInfo = cardDict["couponTapInfo"] as? String {
                                    
                    let couponData = CouponData(
                        id: key,
                        publisher: publisher,
                        name: name,
                        userId: userId,
                        date: date,
                        discountAmount: discountAmount,
                        imageName: imageName,
                        couponTapInfo: couponTapInfo
                    )
                    
                    couponDatas.append(couponData)
                    
                }
            }
            
            couponDatas.sort { $0.date > $1.date }

            self.couponData = couponDatas
            completion()
        })
    }
    
    func createCouponDatas() {
        var ref: DatabaseReference! = Database.database().reference() //

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        
        let data: [String: Any] = [
            "publisher": "CoffeeCoffee",
            "name": "스탬프 보상 쿠폰",
            "userId": Auth.auth().currentUser?.uid ?? "",   //
            "date": formattedDate, // 오늘 날자
            "discountAmount": 1000,
            "imageName": "Americano_Hot",
            "couponTapInfo": "have"
        ]

        ref.child("CouponData").childByAutoId().setValue(data) { error, _ in
            if let error = error {
                print("Error saving data to Firebase: \(error.localizedDescription)")
            } else {
                print("Data saved to Firebase successfully!")
            }
        }
    }
    
    func createCouponDetailDatas() {
        var ref: DatabaseReference! = Database.database().reference()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        
        let data: [String: Any] = [
            "date": formattedDate,
            "description": "-10개",
            "name": "스탬프 쿠폰 전환",
            "userId": Auth.auth().currentUser?.uid ?? ""
        ]

        ref.child("StampDetailsData").childByAutoId().setValue(data) { error, _ in
            if let error = error {
                print("Error saving data to Firebase: \(error.localizedDescription)")
            } else {
                print("Data saved to Firebase successfully!")
            }
        }
    }
    
    func clearSelectedCoupon() {
            selectedCoupon = CouponData(id: "", publisher: "", name: "", userId: "", date: "", discountAmount: 0, imageName: "", couponTapInfo: "")
        }
    
    
    func deleteCouponData (couponDataToDelete: CouponData) {
        let db = Database.database().reference()
        let cartItemRef = db.child("CouponData")
        let itemID = couponDataToDelete.id
        let itemRef = cartItemRef.child(itemID)
        itemRef.removeValue { error, _  in
            if let error = error {
                print("Error deleting cart item \(couponDataToDelete) from Firebase: \(error.localizedDescription)")
            } else {
                print("Cart data deleted from Firebase successfully!")
            }
        }
    }
}
