//
//  SetDistanceViewController.swift
//  Don't eat alone
//
//  Created by Ilyess NAIT BELKACEM on 27/07/2022.
//

import UIKit
import CoreLocation

class SetDistanceViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var kmValueLabel: UILabel!
    @IBOutlet weak var distanceSlider: UISlider!
    var longitude: Double!
    var latitude: Double!
    @IBOutlet weak var logoutButton: UIButton!
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation? {
        didSet{
            self.longitude = self.currentLocation!.coordinate.longitude
            self.latitude = self.currentLocation!.coordinate.latitude
            // lancer a chaque changement de localisation
            //self.localisationLabel.text = self.currentLocation?.description
        }
    }
    var lockLocation: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.kmValueLabel.text = String(distanceSlider.value)
        self.logoutButton.setTitle(NSLocalizedString("home.disconnect.button", comment: ""), for: .normal)
        self.logoutButton.setTitleColor(UIColor.red, for: .normal)

        // Do any additional setup after loading the view.
    }


    @IBAction func sliderDidChange(_ sender: UISlider) {
        self.kmValueLabel.text = String(sender.value)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    @IBAction func handleSearchRestaurant(_ sender: Any) {
        self.lockLocation = false
        guard CLLocationManager.locationServicesEnabled() else {// vérifier si l'appareil a un GPS
            return
        }
        let status = CLLocationManager.authorizationStatus()
        if status == .denied || status == .restricted {
            self.displayErrorLocation()
        }else if status == .authorizedWhenInUse {
            self.lauchLocalize()
        }else if status == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        
        if(self.longitude != nil && self.latitude != nil){
            DispatchQueue.main.async {
                let list = HomeViewController.newInstance(radius: Int(self.distanceSlider.value), longitude: self.longitude, latitude: self.latitude)
                self.navigationController?.pushViewController(list, animated: true)
            }
        }
    }
    
    func displayErrorLocation(){
        let alert = UIAlertController(title: "Location", message: "Acces denied", preferredStyle: .alert)
        alert.addAction(UIAlertAction (title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    func lauchLocalize() {
        self.lockLocation = true
        // Lance l'écoute du changement de coordonnées GPS
        self.locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            self.displayErrorLocation()
        }else if status == .authorizedWhenInUse && self.lockLocation ==  false {
            self.lauchLocalize()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        self.currentLocation = locations.last
        self.longitude = self.currentLocation!.coordinate.longitude
        self.latitude = self.currentLocation!.coordinate.latitude

        // arrete la géolocalisation
        self.locationManager.stopUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func handleLogout(_ sender: Any) {
        self.navigationController?.pushViewController(SigninViewController(), animated: true)
    }
}
