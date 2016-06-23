/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

@available(iOS 8.0, *)
class ViewController: UIViewController, UITextFieldDelegate{

    /* declare all the outlets ANDDD variables */
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var driver: UILabel!
    @IBOutlet weak var rider: UILabel!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var memberLabel: UILabel!
    var switchControl = false //true for signUp false for Login
    
    /*display pop-ups for the app 
    @param title: title of the alert!
    @param message: alert message to be displayed!
    @param alertTitle: action message to be displayed! */
    public func popUp(title: String, message: String, alertTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: alertTitle, style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    /*IBAction for sign up button */
    @IBAction func signUp(sender: AnyObject) {
        
        /* check for empty fields */
        if username.text == "" || password.text == "" {
            popUp("Invalid Entry!", message: "Username and password are required fields!", alertTitle: "Got it!")
        } else if switchControl == false {
            
            /* sign up user with parse, see parse documentation */
            let user = PFUser()
            user.username = username.text
            user.password = password.text
            user["driver"] = `switch`.on
            
            user.signUpInBackgroundWithBlock({ (success, error) in
                if let error = error {
                    let errorString = error.userInfo["error"] as? String
                    self.popUp("Sign up failed!", message: errorString!, alertTitle: "Try again")
                } else {
                    self.performSegueWithIdentifier("login", sender: self)
                }
            })
        } else {
            
            /* log in user with parse, see parse documentation */
            PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) in
                if error != nil {
                    let errorString = error!.userInfo["error"] as? String
                    self.popUp("Login failed!", message: errorString!, alertTitle: "Try again")
                } else {
                    self.performSegueWithIdentifier("login", sender: self)
                }
            })
        }
    }
    
    /* IBAction for login button */
    @IBAction func loginFunc(sender: AnyObject) {
        if switchControl == false {
            signUpButton.setTitle("Login", forState: UIControlState.Normal)
            login.setTitle("Sign Up", forState: UIControlState.Normal)
            memberLabel.text = "Not a member?"
            memberLabel.textAlignment = NSTextAlignment.Center
            `switch`.hidden = true
            driver.hidden = true
            rider.hidden = true
            switchControl = true
        } else {
            signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
            login.setTitle("Login", forState: UIControlState.Normal)
            memberLabel.text = "Already a member?"
            `switch`.hidden = false
            driver.hidden = false
            rider.hidden = false
            switchControl = false
        }
    }
    
    /* function to close keyboard on pressing anywhere in the view */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /* function to close keyboard on hitting return */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /* if user is already logged-in segue directly */
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser()?.username != nil {
            self.performSegueWithIdentifier("login", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        username.delegate = self
        password.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
