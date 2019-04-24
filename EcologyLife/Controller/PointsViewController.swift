//
//  PointsViewController.swift
//  EcologyLife
//
//  Created by Полина on 03/03/2019.
//  Copyright © 2019 Polina. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class PointsViewController: UIViewController, GMSMapViewDelegate {
    
    var mapView: GMSMapView?
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  locationManager.delegate = self
      //  locationManager.requestWhenInUseAuthorization()
        initMap()
        requestForPoints()
    }
    
    func initMap(){
        GMSServices.provideAPIKey("AIzaSyB2MSQGMIY3Acp-Flo-ld3LFBAFfBFRM3A")
        let camera = GMSCameraPosition.camera(withLatitude:  56.007291, longitude: 92.872754, zoom: 12)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView!.delegate = self
        mapView!.settings.compassButton = true
        mapView!.settings.myLocationButton = true
        mapView!.settings.scrollGestures = true
        mapView!.settings.zoomGestures = true
        self.view = mapView
    }
    
    func requestForPoints(){
//        Alamofire.request("http://192.168.1.204:8181/v1/recyclepoints").responseJSON { response in
            Alamofire.request("http://127.0.0.1:8282/v1/recyclepoints").responseJSON { response in
            self.parseJson(json: JSON(response.result.value!))
        }
    }

    private func parseJson(json: JSON){
        
        let pointsJson = json["msg"].array
        var points: [RecyclePoint] = []
        
        pointsJson?.forEach { (json) in
            var blankPoint = RecyclePoint()
            blankPoint.title = json["title"].string
            blankPoint.description = json["description"].string
            blankPoint.adrees = json["adrees"].string
            blankPoint.lat = json["lat"].doubleValue
            blankPoint.lon = json["lon"].doubleValue
            points.append(blankPoint)
        }
        self.addMarkerToMap(points: points)
    }
    
    func addMarkerToMap(points: [RecyclePoint]){
        points.forEach { (RecyclePoint) in
            self.addMarkerToMap(point: RecyclePoint)
        }
    }
    
    func addMarkerToMap(point: RecyclePoint){
        let currentLocation = CLLocationCoordinate2DMake(point.lat!, point.lon!)
        let marker = GMSMarker(position: currentLocation)
        marker.title = point.title
        marker.snippet = "\(String(point.adrees!))\n\n\(String(point.description!))"
        marker.map = mapView!
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf")
    }
    
}
// MARK: - CLLocationManagerDelegate
//1 creating a MapViewController extension that conforms to CLLocationManagerDelegate.
    extension PointsViewController: CLLocationManagerDelegate {
    // 2 locationManager(_:didChangeAuthorization:) is called when the user grants or revokes location permissions.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3 Here you verify the user has granted you permission while the app is in use.
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4 Once permissions have been established, ask the location manager for updates on the user’s location.
        locationManager.startUpdatingLocation()
        //5GMSMapView has two features concerning the user’s location: myLocationEnabled draws a light blue dot where the user is located, while myLocationButton, when set to true, adds a button to the map that, when tapped, centers the map on the user’s location.
        mapView!.isMyLocationEnabled = true
        mapView!.settings.myLocationButton = true
    }
    // 6 locationManager(_:didUpdateLocations:) executes when the location manager receives new location data.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        // 7This updates the map’s camera to center around the user’s current location. The GMSCameraPosition class aggregates all camera position parameters and passes them to the map for display.
        mapView!.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        // 8 Tell locationManager you’re no longer interested in updates; you don’t want to follow a user around as their initial location is enough for you to work with.
        locationManager.stopUpdatingLocation()
    }
}
