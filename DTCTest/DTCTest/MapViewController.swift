//
//  MapViewController.swift
//  DTCTest
//
//  Created by somsak on 19/6/2564 BE.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: BaseViewController {
    
    @IBOutlet private var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCLLocationManager()
    }

    func configureCLLocationManager(){
        self.startAnimating()
        
        // Create a CLLocationManager and assign a delegate
        locationManager.delegate = self

        locationManager.requestAlwaysAuthorization()
    }
    
    func initialLocation(){
        let initialLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
        mapView.centerToLocation(initialLocation)
        
        // Show artwork on map
        let artwork = Artwork(
          title: "Your location",
          locationName: "Your location",
          discipline: "Sculpture",
          coordinate: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude))
        self.stopAnimating()
        mapView.addAnnotation(artwork)
    }
}

// Step 5: Implement the CLLocationManagerDelegate to handle the callback from CLLocationManager
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.stopAnimating()
        switch status {
        case .denied: // Setting option: Never
          print("LocationManager didChangeAuthorization denied")
            self.alertOneAction(title: "กรุณาเปิด location") { (bool) in
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            }
            
        case .notDetermined: // Setting option: Ask Next Time
          print("LocationManager didChangeAuthorization notDetermined")
            
        case .authorizedWhenInUse: // Setting option: While Using the App
          print("LocationManager didChangeAuthorization authorizedWhenInUse")
          // Stpe 6: Request a one-time location information
            locationManager.requestLocation()
            
        case .authorizedAlways: // Setting option: Always
          print("LocationManager didChangeAuthorization authorizedAlways")
          // Stpe 6: Request a one-time location information
            self.startAnimating()
            locationManager.requestLocation()
            
        case .restricted: // Restricted by parental control
          print("LocationManager didChangeAuthorization restricted")
            
        default:
          print("LocationManager didChangeAuthorization")
        }
    }

  // Step 7: Handle the location information
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            initialLocation()
        }
    }
  
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        // Handle failure to get a user’s location
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

class Artwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let discipline: String?
  let coordinate: CLLocationCoordinate2D

  init(
    title: String?,
    locationName: String?,
    discipline: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate

    super.init()
  }

  var subtitle: String? {
    return locationName
  }
}
