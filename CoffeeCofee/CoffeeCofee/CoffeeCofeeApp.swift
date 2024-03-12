//
//  CoffeeCofeeApp.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/13.
//

import SwiftUI
import FirebaseCore
import GoogleMaps


class AppDelegate: NSObject, UIApplicationDelegate {
    
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        GMSServices.provideAPIKey(apiKey!)
        
        return true
    }
}



@main
struct CoffeeCofeeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        
        WindowGroup {
            UserLoginView()
                .environmentObject(HomeUserViewModel())
                .environmentObject(OrderCartViewModel())
                .environmentObject(MembershipCouponModel())
                .environmentObject(PaymentModel())
                .environmentObject(MembershipStampModel())
                .environmentObject(LoginViewModel())
                .environmentObject(CrawlModel())
                .environmentObject(PrepaidCardViewModel())
                
        }
    }
}


