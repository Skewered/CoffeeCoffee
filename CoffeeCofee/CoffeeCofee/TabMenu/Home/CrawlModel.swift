//
//  CrawlManager.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI
import Foundation
import UIKit
import WebKit
import SwiftSoup
import Alamofire

class CrawlModel: ObservableObject {
    
    @Published var events: [EventData] = []
    
    var UserEventAppendImg: EventData
    
    init() {
        UserEventAppendImg = EventData(imageURL: nil)
    }
    
    func crawlEvent(completion: @escaping () -> Void) {
        let urlStr = "https://www.mega-mgccoffee.com/bbs/?bbs_category=3"
        guard let url = URL(string: urlStr) else { return }
        
        AF.request(url).responseData { [weak self] response in
            guard let self = self else { return }
            
            if let html = String(data: response.value!, encoding: .utf8) {
                
                do {
                    let doc: Document = try SwiftSoup.parseBodyFragment(html)
                    let elements: Elements = try doc.select("div.cont_gallery_list_img.cont_gallery_list_img_height > img")
                    
                    for element in elements {
                        guard var urlImage = URL(string: try element.attr("src").description) else { return }
                        
                        self.UserEventAppendImg = EventData(imageURL: urlImage)
                        events.append(self.UserEventAppendImg)
                    }
                    completion()
                }
                
                catch {
                    print("crawl error")
                }
            } else {
                return
            }
        }
    }
}
