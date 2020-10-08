//
//  ViewController.swift
//  iOSRestaurant
//
//  Created by 許自翔 on 2020/10/3.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController ,MKMapViewDelegate,CLLocationManagerDelegate{

    var restaurantList = [Restaurant]()
    var restaurant : Restaurant?
    let locationManager = CLLocationManager()
    var like:Bool = false
    
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbBreweryType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMap.delegate = self
        setMapRegion()
        myMap.showsUserLocation = true
        }
    
    override func viewWillAppear(_ animated: Bool) {
        Network.shared.getRestaurant { (restList) in
            if restList != nil{
                self.restaurantList = restList
                var objectAnnotations = [MKPointAnnotation]()
                DispatchQueue.main.async { [self] in
                    for i in 0..<self.restaurantList.count{
                        self.restaurant = self.restaurantList[i]
                        let annotation = MKPointAnnotation()
                        objectAnnotations.append(annotation)
                        annotation.coordinate = CLLocation(
                            latitude: CLLocationDegrees(String(self.restaurant!.latitude))!,
                            longitude:  CLLocationDegrees(String(self.restaurant!.longitude))!).coordinate
                        annotation.title = self.restaurant?.name
                        annotation.subtitle = self.restaurant?.brewery_type
                        self.lbName.text = self.restaurant!.name
                        self.lbBreweryType.text = self.restaurant!.brewery_type
                        self.myMap.addAnnotation(annotation)
                        self.myMap.centerCoordinate = annotation.coordinate
                    }
                }
            }
        }
    }

    func setMapRegion() {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        var region = MKCoordinateRegion()
        region.span = span
        myMap.setRegion(region, animated: true)
        myMap.regionThatFits(region)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 印出目前所在位置座標
        let currentLocation :CLLocation =
            locations[0] as CLLocation
        print("\(currentLocation.coordinate.latitude)")
        print(", \(currentLocation.coordinate.longitude)")
        /*
         依照稍前設置的屬性distanceFilter的距離精確度，會在定位發生變化時執行上述這個方法，其中參數會獲得目前定位的資訊CLLocation，裡面會有像是緯度( latitude )與經度( longitude )的數值資訊。
         */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 首次使用 向使用者詢問定位自身位置權限
        if CLLocationManager.authorizationStatus()
            == .notDetermined {
            // 取得定位服務授權
            locationManager.requestWhenInUseAuthorization()

            // 開始定位自身位置
            locationManager.startUpdatingLocation()
        }
        // 使用者已經拒絕定位自身位置權限
        else if CLLocationManager.authorizationStatus()
                    == .denied {
            // 提示可至[設定]中開啟權限
            let alertController = UIAlertController(
              title: "定位權限已關閉",
              message:
              "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟",
                preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            self.present(
              alertController,
              animated: true, completion: nil)
        }
        // 使用者已經同意定位自身位置權限
        else if CLLocationManager.authorizationStatus()
                    == .authorizedWhenInUse {
            // 開始定位自身位置
            locationManager.startUpdatingLocation()
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        self.lbName.text = view.annotation!.title as? String
        self.lbBreweryType.text = view.annotation!.subtitle as? String
        
    }
    

    
    @IBAction func actionToLike(_ sender: Any) {
        Network.shared.postMyLike(outRestaurant: restaurant!) { ([String : Int]) in
        }
    }
    
    
}

