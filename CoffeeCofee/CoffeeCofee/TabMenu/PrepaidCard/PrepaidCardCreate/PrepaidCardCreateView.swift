//
//  PrepaidCardCreateView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI
import Firebase

struct PrepaidCardCreateView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                TabView {
                    ForEach(PrepaidCardImage.allCases, id: \.self) { image in
                        NavigationLink(destination: PrepaidCardCreateDetailView(data: image)) {
                            Image(image.rawValue)
                                .resizable()
                                .scaledToFit()
                                .tag(image)
                                .frame(width: 300, height: 300)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(height: 300)
                
                Text("감사")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(PrepaidCardBirdImage.allCases, id: \.self) { image in
                            NavigationLink(destination: PrepaidCardCreateDetailView(data: image)) {
                                Image(image.rawValue)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            }
                        }
                    }
                }
                
                Text("축하")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(PrepaidCardPatternImage.allCases, id: \.self) { image in
                            NavigationLink(destination: PrepaidCardCreateDetailView(data: image)) {
                                Image(image.rawValue)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            }
                        }
                    }
                }
                
                Text("응원")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(PrepaidCardFlowerImage.allCases, id: \.self) { image in
                            NavigationLink(destination: PrepaidCardCreateDetailView(data: image)) {
                                Image(image.rawValue)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            }
                        }
                    }
                }
            }
        }
    }
}
