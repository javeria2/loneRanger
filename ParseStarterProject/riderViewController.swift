//
//  riderViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Sanchay  Javeria on 6/23/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import MapKit

@available(iOS 8.0, *)
class riderViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    /* declare outlets */
    @IBOutlet weak var map: MKMapView!
    var manager = CLLocationManager()
    var latitude, longitude: CLLocationDegrees!
    @IBOutlet weak var friendButton: UIButton!
    
    /* if a segue has happened, then what? Used here for logout */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logout" {
            PFUser.logOut()
        }
    }
    
    /* IBAction for calling a friend */
    @IBAction func findAFriend(sender: AnyObject) {
        
        if friendButton.titleLabel?.text == "Cancel your ride" {
            let query = PFQuery(className: "rider")
            query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
            query.findObjectsInBackgroundWithBlock({ (objects, error) in
                if error == nil {
                    for object in objects!{
                        object.deleteInBackground()
                    }
                }else {
                    print(error)
                }

            })
            friendButton.setTitle("Find a friend!", forState: UIControlState.Normal)
            
        } else {
            let friend = PFObject(className: "rider")
            friend["name"] = PFUser.currentUser()?.username
            friend["location"] = PFGeoPoint(latitude: latitude, longitude: longitude)
            
            friend.saveInBackgroundWithBlock { (success, error) in
                if error != nil {
                    let alert = UIAlertController(title: "error", message: error.debugDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    self.friendButton.setTitle("Cancel your ride", forState: UIControlState.Normal)
                }
            }
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = manager.location?.coordinate
        latitude = location?.latitude
        longitude = location?.longitude
        
        let focus = CLLocationCoordinate2D(latitude: location!.latitude, longitude: location!.longitude)
        let area = MKCoordinateRegion(center: focus, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        map.setRegion(area, animated: true)
        
        map.removeAnnotations(map.annotations)
        
        let pinhere = CLLocationCoordinate2DMake(location!.latitude, location!.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = pinhere
        annotation.title = "\(PFUser.currentUser()?.username)'s location"
        map.addAnnotation(annotation)
    }
    
    override func viewDidLoad() {

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
