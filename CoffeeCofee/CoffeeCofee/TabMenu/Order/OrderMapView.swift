//
//  OrderMapModel.swift
//  CoffeeCofee
//
//  Created by 1 on 2024/01/31.
//

import SwiftUI
import GoogleMaps

struct OrderMapView: UIViewRepresentable {
    
    @State var locationManager = CLLocationManager()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var isOrderMenuViewPresented: Bool
    @Binding var shopData: ShopData
    
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.isUserInteractionEnabled = true
        mapView.delegate = context.coordinator
        context.coordinator.mapView = mapView
        locationManager.requestWhenInUseAuthorization()
        
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = context.coordinator
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func makeCoordinator() -> OrderMapCoordinator {
        let coordinator = OrderMapCoordinator(parent: self)
        return coordinator
    }
}
