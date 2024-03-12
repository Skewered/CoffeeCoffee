//
//  PrepaidCardView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//


import SwiftUI

struct PrepaidCardView: View {
    
    @Binding var resetTrigger: Bool
    
    @State private var isPopupNoticeVisible = false
    
    @EnvironmentObject var prepaidCardPresenter: PrepaidCardViewModel
    
    init(resetTrigger: Binding<Bool>) {
        _resetTrigger = resetTrigger
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                PrepaidCardListView()
                    .frame(height: 600)
                PrepaidPrecautionsView()
                PrepaidRefundView()
            }
            .navigationBarTitle("선불카드", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPopupNoticeVisible = true
                    }) {
                        Text("안내")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        prepaidCardPresenter.fetchPrepaidCards()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .overlay(
                ZStack {
                    if isPopupNoticeVisible {
                        Color.black.opacity(0.5).ignoresSafeArea()
                            .onTapGesture {
                                isPopupNoticeVisible = false
                            }
                        VStack {
                            PrepaidNoticePopupView(isPopupNoticeVisible: $isPopupNoticeVisible)
                                .frame(width: 300, height: 400)
                                .padding(.horizontal, 35)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                    .zIndex(1)
            )
        }
    }
}


