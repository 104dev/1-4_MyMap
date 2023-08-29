//
//  ViewController.swift
//  1-4_MyMap
//
//  Created by jushiro watanabe on 2023/08/28.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputText.delegate = self
    }


    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var dispMap: MKMapView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let searchKey = textField.text {
            print(searchKey)
            
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(searchKey, completionHandler: {(placemarks, error) in
                if let unwrapPlacemarks  = placemarks {
                    
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        if let location = firstPlacemark.location {
                            
                            let targetCoodinate = location.coordinate
                            
                            print(targetCoodinate)
                            
                            let pin = MKPointAnnotation()
                            
                            pin.coordinate = targetCoodinate
                            
                            pin.title = searchKey
                            
                            self.dispMap.addAnnotation(pin)
                            
                            self.dispMap.region = MKCoordinateRegion(center: targetCoodinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                            
                        }
                    }
                }
            })
        }
        
        return true
    }
    
    
    @IBAction func changeMapButton(_ sender: Any) {
        
        if dispMap.mapType == .standard{
            dispMap.mapType = .satellite
        }else if dispMap.mapType == .satellite {
            dispMap.mapType = .hybrid
        } else if dispMap.mapType == .hybrid {
            dispMap.mapType = .satelliteFlyover
        } else if dispMap.mapType == .satelliteFlyover {
            dispMap.mapType = .hybridFlyover
        } else if dispMap.mapType == .hybridFlyover {
            dispMap.mapType = .mutedStandard
        } else {
            dispMap.mapType = .standard
        }
    }
}

