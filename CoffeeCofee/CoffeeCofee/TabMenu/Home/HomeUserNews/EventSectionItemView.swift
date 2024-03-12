//
//  EventSectionItemView.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI

struct EventSectionItemView : View {
    let event : EventData
    
    var body: some View{
        
        NavigationLink(destination: NavigationTempView()) {
            if let imageURLString = event.imageURL {
                AsyncImage(url: imageURLString) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
            } else {
                Color.gray.frame(height: 150)
            }
        }
        .foregroundColor(.black) 
    }
}
