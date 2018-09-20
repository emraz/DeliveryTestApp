//
//  DeliveryDetailsViewController.swift
//  DeliveryTestApp
//
//  Created by Mahmudul Hasan R@zib on 9/19/18.
//  Copyright © 2018 Matrix Solution Ltd. All rights reserved.
//

import UIKit
import MapKit
import AlamofireImage


class DeliveryDetailsViewController: UIViewController, CLLocationManagerDelegate {
    
    var selectedDeliveryItem = Delivery()
    var mapView: MKMapView?
    var locationManager: CLLocationManager?
    let distanceSpan: Double = 500
    let annotation = MKPointAnnotation()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Delivery Details"
        self.view.backgroundColor = UIColor.white
        self.setupMapView()
        self.setupDetailsView()
    }
    
    private func setupMapView() {
        
        mapView = MKMapView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: (SCREEN_HEIGHT * 2.0)/3.0))
        annotation.coordinate = CLLocationCoordinate2D(latitude: selectedDeliveryItem.location?.lat ?? 0.0, longitude: selectedDeliveryItem.location?.lng ?? 0.0)
        mapView?.addAnnotation(annotation)
        mapView?.setCenter(annotation.coordinate, animated: true)
        self.view.addSubview(self.mapView!)

        self.locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }
    }
    
    private func setupDetailsView() {
        
        let bottomInset:CGFloat = AppManager.hasBottomSafeAreaInsets ? 34.0 : 0.0
        let offset:CGFloat = 5.0
        let mapHt:CGFloat = mapView?.frame.height ?? 0
        let detailsView:UIView = UIView.init(frame: CGRect.init(x: 0, y: mapView?.frame.maxY ?? 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - mapHt - self.topbarHeight - bottomInset))
        detailsView.backgroundColor = UIColor.clear
        
        let imgView = UIImageView(frame: CGRect.init(x: offset, y: offset, width: detailsView.frame.height - offset*2, height: detailsView.frame.height - offset*2))
        
        let imageData = DataManager.sharedManager.readData(fileName: selectedDeliveryItem.deliveryID+".jpg")
        let imageUIImage = UIImage(data: imageData)
        imgView.image = imageUIImage
        
        /*if let url = URL(string: selectedDeliveryItem.imageUrl) {
            imgView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "place_holder.jpg"))
        }*/
        
        imgView.contentMode = UIViewContentMode.scaleAspectFill
        imgView.clipsToBounds = true
        imgView.backgroundColor = UIColor.clear
        detailsView.addSubview(imgView)

        let detailsLabel = UILabel.init(frame: CGRect.init(x: imgView.frame.maxX + offset*2, y: offset, width: detailsView.frame.width - offset*3 - imgView.frame.size.width, height: detailsView.frame.height - offset*2))
        detailsLabel.backgroundColor = UIColor.clear
        detailsLabel.textAlignment = .left
        detailsLabel.textColor = UIColor.black
        detailsLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        detailsLabel.numberOfLines = 0
        detailsLabel.text = selectedDeliveryItem.descrption
        detailsView.addSubview(detailsLabel)
        
        self.view.addSubview(detailsView)
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        if let mapView = self.mapView {
            let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, self.distanceSpan, self.distanceSpan)
            mapView.setRegion(region, animated: true)
            mapView.showsUserLocation = true
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
