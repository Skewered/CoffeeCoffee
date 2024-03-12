//
//  MembershipStampModel.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/18.
//

import SwiftUI
import Firebase


class MembershipStampModel: ObservableObject {
        
    @Published var stampData: [StampData] = []
    @Published var stampDetailsData: [StampDetailsData] = []
    
    @StateObject var loginPresenter = LoginViewModel()

    func fetchstampDatas(completion: @escaping () -> Void) {
        let userUID = loginPresenter.initializeUserID()
        let db = Database.database().reference()

        db.child("StampData").queryOrdered(byChild: "userId").queryEqual(toValue: userUID ).observeSingleEvent(of: .value, with:  { snapshot in
            
            guard let snapshotDict = snapshot.value as? [String: Any] else {
                print("Error: Invalid snapshot format or no data found.")
                return
            }
            var stampDatas: [StampData] = []
            for (key, value) in snapshotDict {
                if  let cardDict = value as? [String: Any],
                    let name = cardDict["name"] as? String,
                    let userUID = cardDict["userId"] as? String,
                    let date = cardDict["date"] as? String {
                    
                    let stampData = StampData (
                        id: key,
                        userId: userUID,
                        name: name,
                        date: date
                    )
                    
                    stampDatas.append(stampData)
                    
                }
            }
            stampDatas.sort { $0.date > $1.date }
            
            self.stampData = stampDatas
            completion()
        })
    }
    
    func fetchstampDetailsDatas() {
        let db = Database.database().reference()
        let userUID = loginPresenter.initializeUserID()

        db.child("StampDetailsData").queryOrdered(byChild: "userId").queryEqual(toValue: userUID ).observeSingleEvent(of: .value, with: { snapshot in
            
            guard let snapshotDict = snapshot.value as? [String: Any] else {
                print("Error: Invalid snapshot format or no data found.")
                return
            }
            
            var stampDetailsDatas: [StampDetailsData] = []
            for (key, value) in snapshotDict {
                if  let cardDict = value as? [String: Any],
                    let name = cardDict["name"] as? String,
                    let userUID = cardDict["userId"] as? String,
                    let description = cardDict["description"] as? String,
                    let date = cardDict["date"] as? String {
                    let stampDetailsData = StampDetailsData (
                        id: key,
                        name: name,
                        userId: userUID,
                        description: description,
                        date: date
                    )
                    stampDetailsDatas.append(stampDetailsData)
                }
            }
            stampDetailsDatas.sort { $0.date > $1.date }
            self.stampDetailsData = stampDetailsDatas
        })
    }
    
    func deleteStampDataToFirebase() {
        let userUID = loginPresenter.initializeUserID()

        let db = Database.database().reference()
        let query = db.child("StampData").queryOrdered(byChild: "userId").queryEqual(toValue: userUID)

        
        query.observeSingleEvent(of: .value, with: { snapshot in
                guard snapshot.exists() else {
                    print("No stamp data found for the user.")
                    return
                }

                for childSnapshot in snapshot.children {
                    guard let dataSnapshot = childSnapshot as? DataSnapshot else {
                        continue
                    }

                    dataSnapshot.ref.removeValue { error, _ in
                        if let error = error {
                            print("Error deleting stamp data from Firebase: \(error.localizedDescription)")
                        } else {
                            print("Stamp data deleted from Firebase successfully!")
                        }
                    }
                }
            })
        
    }
    
    func createStampDetailDatas() {
        var ref: DatabaseReference! = Database.database().reference() //

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        
        
        
        let data: [String: Any] = [
            "date": formattedDate,
            "description": "1개",
            "name": "스탬프",
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
}
       
        
        
        
