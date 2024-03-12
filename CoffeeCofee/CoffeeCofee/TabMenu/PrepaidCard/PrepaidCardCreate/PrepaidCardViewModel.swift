//
//  PrepaidCardViewModel.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

class PrepaidCardViewModel: ObservableObject {
    @Published var prepaidCards: [PrepaidCardData] = []
    
    @StateObject var loginPresenter = LoginViewModel()
    
    func fetchPrepaidCards() {
        let db = Database.database().reference()
        let userUID = loginPresenter.initializeUserID()
        
        db.child("prepaidCards").queryOrdered(byChild: "userId").queryEqual(toValue: userUID).observeSingleEvent(of: .value, with:  { snapshot in
            guard let snapshotDict = snapshot.value as? [String: Any] else {
                print("Error: Invalid snapshot format or no data found.")
                return
            }
            
            var cards: [PrepaidCardData] = []
            for (key, value) in snapshotDict {
                if  let cardDict = value as? [String: Any],
                    let design = cardDict["design"] as? String,
                    let cardName = cardDict["cardName"] as? String,
                    let chargeAmount = cardDict["chargeAmount"] as? Int,
                    let paymentMethod = cardDict["paymentMethod"] as? String,
                    let userUID = cardDict["userId"] as? String {
                    let card = PrepaidCardData(
                        id: key,
                        design: design,
                        cardName: cardName,
                        chargeAmount: chargeAmount,
                        paymentMethod: paymentMethod,
                        userId: userUID
                    )
                    cards.append(card)
                }
            }
            cards.sort { $0.chargeAmount > $1.chargeAmount }
            self.prepaidCards = cards
        })
    }
    
    func savePrepaidCards(item :PrepaidCardData) {
        let db = Database.database().reference()
        
        let data: [String: Any] = [
            "design": item.design,
            "cardName": item.cardName,
            "chargeAmount": item.chargeAmount,
            "paymentMethod": item.paymentMethod,
            "userId": Auth.auth().currentUser?.uid ?? ""
        ]
        
        db.child("prepaidCards").childByAutoId().setValue(data) { error, _ in
            if let error = error {
                print("Error saving data to Firebase: \(error.localizedDescription)")
            } else {
                print("Data saved to Firebase successfully!")
            }
        }
    }
    
    func chargeDataToFirebase(cardId: String, chargeAmount: Int, newChargeAmount: Int) {
        let ref = Database.database().reference().child("prepaidCards").child(cardId)
        let data: [String: Any] = [
            "chargeAmount": chargeAmount + newChargeAmount
        ]
        ref.updateChildValues(data) { error, _ in
            if let error = error {
                print("Error updating data to Firebase: \(error.localizedDescription)")
            } else {
                print("Data updated to Firebase successfully!")
            }
        }
    }
}

