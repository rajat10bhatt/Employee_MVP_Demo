//
//  MapViewController.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 12/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapKit")
        locationManager.requestWhenInUseAuthorization()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "Back"), target: self, action: #selector(backButtonTapped(_:)))
        let coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        let distance: CLLocationDistance = 1000
        self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(coordinate, distance, distance), animated: true)
        let locationPin = MyAnnotation(title: "Your Location", subtitle: "", coordinate: coordinate)
//        let locationPin = MyAnnotation(title: searchString, subtitle: "", coordinate: location.coordinate)
        self.mapView.addAnnotation(locationPin)
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        //self.dismiss(animated: true, completion: nil)
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
