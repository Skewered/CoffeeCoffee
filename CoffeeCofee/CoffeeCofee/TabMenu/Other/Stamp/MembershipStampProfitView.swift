//
//  MembershipStampProfitView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI
import FirebaseAuth

enum StampProfitInfo : String, CaseIterable {
    case oneweak = "일주일"
    case onemonth = "1개월"
    case threemonth = "3개월"
    case sixmonth = "6개월"
}


struct MembershipStampProfitView: View {
    @State var StampProfitSelectedPicker: StampProfitInfo = .oneweak
    @Namespace private var animation
    @EnvironmentObject var stampPresenter: MembershipStampModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            ForEach(StampProfitInfo.allCases, id: \.self) { item in
                VStack {
                    Text(item.rawValue)
                        .font(.title3)
                        .frame(maxWidth: .infinity/4, minHeight: 50)
                        .foregroundColor(colorScheme == .light ? .black : .white)
                }
                .background(
                    Capsule()
                        .fill(StampProfitSelectedPicker == item ? Color.brown : Color.clear)
                        .overlay(
                            Capsule()
                                .stroke(Color.black, lineWidth: 1)
                        )
                )
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        StampProfitSelectedPicker = item
                    }
                }
            }
        }
        
        MembershipStampProfitSelectedPickerView(stampInfo: StampProfitSelectedPicker)
    }
    
    
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}

