//
//  OrderMapCoordinator.swift
//  CoffeeCofee
//
//  Created by 1 on 2024/02/19.
//

import SwiftUI
import CoreLocation
import GoogleMaps

class OrderMapCoordinator: NSObject, CLLocationManagerDelegate, GMSMapViewDelegate {
    var parent: OrderMapView
    var mapView: GMSMapView?
    var markers = [GMSMarker]()
    var userLocationMarker: GMSMarker?
    var placesResponse: PlacesResponse?
    var initialLocationSet = false
    
    init(parent: OrderMapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        clearMarkers()
        
        let latitude = position.target.latitude
        let longitude = position.target.longitude
        
        if !initialLocationSet {
                    if let userLocation = mapView.myLocation {
                        let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude,
                                                              longitude: userLocation.coordinate.longitude,
                                                              zoom: 15.0)
                        mapView.animate(to: camera)
                        initialLocationSet = true
                    }
                }
        
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String

        let urlString =  "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=500&type=cafe&key=\(apiKey!)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let placesResponse = try JSONDecoder().decode(PlacesResponse.self, from: data)
                    DispatchQueue.main.async {
                        for place in placesResponse.results {
                            let marker = GMSMarker()
                            marker.position = CLLocationCoordinate2D(latitude: place.geometry.location.lat, longitude: place.geometry.location.lng)
                            marker.title = place.name
                            marker.userData = place.place_id
                            marker.map = self.mapView
                            self.markers.append(marker)
                        }
                        
                    }
                } catch {
                    print("JSON 파싱 실패:", error)
                }
            }
        }.resume()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let placeId = marker.userData as? String {
            getPlaceDetails(for: placeId) { detailedPlace in
                //self.showPopup(for: detailedPlace)
                DispatchQueue.main.async {
                    self.parent.shopData.shopName = detailedPlace.name
                    self.parent.shopData.address = detailedPlace.formatted_address
                    self.parent.isOrderMenuViewPresented = true
                }
            }
        }
        return true
    }
    
    func clearMarkers() {
        for marker in markers {
            marker.map = nil
        }
        markers.removeAll()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let camera = GMSCameraPosition.camera(withLatitude:
                location.coordinate.latitude,
                longitude: location.coordinate.longitude,
                zoom: 15.0)
            parent.locationManager.stopUpdatingLocation()
            parent.locationManager.delegate = nil
        }
    }
    
    private func getPlaceDetails(for placeId: String, completion: @escaping (PlaceDetails) -> Void) {
        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(placeId)&key=AIzaSyCi9R5v3ymiEbtylqbynVdh3_s2hiMDlxA"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let placeDetails = try JSONDecoder().decode(PlaceDetailsResponse.self, from: data).result
                    completion(placeDetails)
                } catch {
                    print("JSON 파싱 실패:", error)
                }
            } else {
                print("HTTP 요청 실패:", error)
            }
        }.resume()
    }
}
