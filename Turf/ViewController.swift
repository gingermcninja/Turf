//
//  ViewController.swift
//  Turf
//
//  Created by Paul McGrath on 04/12/2016.
//  Copyright © 2016 Paul McGrath. All rights reserved.
//

import UIKit


class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate  {
    let locationManager:CLLocationManager = CLLocationManager()
    var camera:GMSCameraPosition!// = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
    var mapView:GMSMapView!// = GMSMapView(frame: CGRect.zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.mapType = kGMSTypeSatellite
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        view = mapView
        
        let cell = MapCell(center: CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20))
        _ = MapGrid(origin: cell)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = cell.center
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        
        let path = GMSMutablePath()
        
        for point in cell.path {
            path.add(point)
        }
        
        let polygon = GMSPolygon(path: path)
        polygon.isTappable = true
        polygon.map = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        NSLog("cp1")
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //NSLog("%d",locations.count)
        _ = locations[0]
        
        //camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 6.0)
        //mapView.camera = camera
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        NSLog("Tapped!")
        let polygon:GMSPolygon = overlay as! GMSPolygon
        let fadedYellow:UIColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 0.0, alpha: 0.5)
        polygon.fillColor = fadedYellow
        
    }
}

