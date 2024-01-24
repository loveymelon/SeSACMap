//
//  MapViewController.swift
//  SeSACMap
//
//  Created by 김진수 on 1/24/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designUI()
        designMapView(text: "전체")
        
        checkDeviceLocationAuthorization()
    }
    
    @objc func tappedFilter() {
        self.showAlert { title in
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.designMapView(text: title)
        }
    }

}

extension MapViewController {
    func designUI() {
        designNavigation()
        
        self.locationManager.delegate = self
    }
    
    func designNavigation() {
        let leftButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(tappedFilter))
        
        self.navigationItem.rightBarButtonItem = leftButton
    }

    
    func designMapView(text: String) {
        
        var tempItem: [Theater]
        
        switch text {
        case _ where text == "CGV":
            tempItem = TheaterData.theater.filter{ $0.name == text }
        case _ where text == "롯데시네마":
            tempItem = TheaterData.theater.filter{ $0.name == text }
        case _ where text == "메가박스":
            tempItem = TheaterData.theater.filter{ $0.name == text}
        default:
            tempItem = TheaterData.theater
        }
        
        for item in tempItem {
            let coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            let annotation = MKPointAnnotation()
            
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1300, longitudinalMeters: 1300)
            
            // 필터시 해당 영화관으로 핀 이동
            mapView.setRegion(region, animated: true)
            
            annotation.coordinate = coordinate
            annotation.title = item.name
            
            self.mapView.addAnnotation(annotation)
            
        }
    }
    
    // 위치 서비스가 설정되었는지 확인
    func checkDeviceLocationAuthorization() {
        
        DispatchQueue.global().async { [self] in

            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    checkCurrentLocationAuthorization(status: authorization)
                }
                
            } else {
                print("위치 서비스가 꺼져 있어서, 위치 권한 요청을 할 수 없어요.")
            }
        }
        
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            showLocationSettingAlert()
            let coordinate = CLLocationCoordinate2D(latitude: 37.654165, longitude: 127.049696)
            setRegionAndAnnotation(center: coordinate) 
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print("Error")
        }
    }
    
    // 사용자 위치로 핀
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1300, longitudinalMeters: 1300)
        
        mapView.setRegion(region, animated: true)
        
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            
            setRegionAndAnnotation(center: coordinate)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
    
}
