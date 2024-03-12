//
//  PrepaidNoticePopupView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct PrepaidNoticePopupView: View {
    @Binding var isPopupNoticeVisible: Bool
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Group {
                    Group{
                        Text("카드 환불은 어떻게 하나요?")
                        Text("카드 환불은 1:1 문의하기를 이용해주세요.")
                    }
                    
                    Group {
                        Text("카드를 안보이게 하고싶어요.")
                        Text("우측 상단의 톱니바퀴 아이콘 > 즐겨찾기 아이콘 ON/OFF 을 통해 메인에 카드를 노출/미노출 시킬수 있습니다.")
                    }
                    
                    Group{
                        Text("메가MGC커피 매장 포스/키오스크에서 메가선불카드를 사용하고 싶어요.")
                        Text("매장")
                        Text("앱 내 메가선불카드의 바코드를 매장 직원에게 제시해 주세요. 바코드를 스캔하거나 바코드 번호로 카드를 사용할 수 있습니다.")
                        Text("키오스크")
                        Text("키오스크 결제 화면에서 '선불카드'를 선택해주세요. 앱 내 메가선불카드의 바코드를 키오스크 바코드 스케너에 스캔해 주세요. 바코드 번호를 직접 입력하여 사용 할 수 있습니다.")
                        Text("메가선불카드와 관련된 자세한 내용은 유의사항 및 전액환불규정을 참고해주세요.")
                    }
                }
                .foregroundColor(.black)
                
                
                Button(action: {
                    isPopupNoticeVisible = false
                }) {
                    Text("닫기")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .frame(width: 300, height: 40)
                .background(Color.brown)
                .cornerRadius(20)
                .padding(16)
            }
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
        }
    }
}
