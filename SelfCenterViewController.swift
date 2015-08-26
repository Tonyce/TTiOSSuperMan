//
//  SelfCenterViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/14.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class SelfCenterViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{


    @IBOutlet weak var selfScrollViewContainer: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var selfImage: UIImageView!
    
    @IBOutlet weak var bakSwith: UISwitch!
    
    var alphaView : UIView!
    
    let selfScrollViewContainerDefaultContentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selfImage.layer.cornerRadius = CGRectGetHeight(selfImage.frame) / 2
        selfImage.layer.masksToBounds = true
        
        let frame: CGRect = self.navigationController!.navigationBar.frame
        alphaView = UIView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height + 20))
        alphaView.backgroundColor = UIColor.redColor()
        alphaView.alpha = 0.3
        
        
        selfScrollViewContainer.frame = view.frame

        selfScrollViewContainer.contentSize = CGSize(width: view.bounds.width, height:  view.bounds.height - 60)
        
        selfImage.image = SelfConfig.sharedInstance.image
        textView.text = SelfConfig.sharedInstance.word
        
        bakSwith.setOn(false, animated: true)
        if let _ = SelfConfig.sharedInstance.userName{
            if  SelfConfig.sharedInstance.allowBak == true  {
                bakSwith.setOn(true, animated: true)
            }
        }

        bakSwith.addTarget(self, action: "allowBakAction:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
       
    }
    
    func allowBakAction(sender: UISwitch){
        if let _ = SelfConfig.sharedInstance.userName {
            bakSwith.setOn(bakSwith.on, animated: true)
        }else {

            let alertController = UIAlertController(
                title: nil,
                message: "您还没有登录",
                preferredStyle: UIAlertControllerStyle.Alert)

            let okAction = UIAlertAction(title: "ok",
                                       style: UIAlertActionStyle.Cancel,
                                     handler: { (paramAction:UIAlertAction!) in
                                        self.bakSwith.setOn(false, animated: true)
                                    })
            let loginAction = UIAlertAction(title: "login", style: .Default) {
                (action) in
                print("login")
                self.showLoginView()
            }
            alertController.addAction(okAction)
            alertController.addAction(loginAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            bakSwith.setOn(bakSwith.on, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resignKbAction(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func showSelectPhoto(sender: AnyObject) {
        
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .ActionSheet)
        
        let actionFromCamera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default)
            {[unowned self] action -> Void in
                self.selectFromCamera()
        }

        let actionFromPhoto = UIAlertAction(title: "photoLib", style: UIAlertActionStyle.Default)
            {[unowned self] action -> Void in
                self.selectFromLib()
                /* Send the photo via iMessage */
        }
        let actionCancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel,
            handler: {(paramAction:UIAlertAction!) in

        })
        
        [actionFromCamera, actionFromPhoto, actionCancel].map {
            alertController.addAction($0)
        }
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    func selectFromLib(){
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)){
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true

            presentViewController(imagePicker, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "No camera", message: "Please allow this app the use of your camera in settings or buy a device that has a camera.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    func selectFromCamera(){
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            presentViewController(imagePicker, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "No camera", message: "Please allow this app the use of your camera in settings or buy a device that has a camera.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true , completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        var  editedImage:UIImage?, imageToSave:UIImage?
        
        editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if ( editedImage != nil ) {
            editedImage = editedImage?.scaleToSize(200)
            imageToSave = editedImage
        } else {
            imageToSave = originalImage
        }
        
        selfImage.image = imageToSave
        dismissViewControllerAnimated(true , completion: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveSelfConfig" {
            let image: UIImage = selfImage.image!
            let word: String = textView.text
            SelfConfig.sharedInstance.image = image
            SelfConfig.sharedInstance.word = word
            SelfConfig.sharedInstance.allowBak = bakSwith.on
        }
    }
    
    func showLoginView(){
        let loginView = self.storyboard?.instantiateViewControllerWithIdentifier("loginView") as! LoginViewController
        loginView.delegate = self
        presentViewController(loginView, animated: true, completion: nil)
    }
}

extension SelfCenterViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let alpha = offset / 100
        alphaView.alpha = alpha
    }
}

extension SelfCenterViewController: LoginViewControllerDelegate {
    func writeLoginStatus(loginStatus: [String : Bool], name: String) {

        SelfConfig.sharedInstance.userName = name
        SelfConfig.sharedInstance.saveSelfConfigs(SelfConfig.sharedInstance)
        bakSwith.setOn(true, animated: true)
        dismissViewControllerAnimated(true, completion: nil)
    }
}

//        let selectPhotoView = storyboard!.instantiateViewControllerWithIdentifier("selectPhotoWay") as! SelectPhotoWayViewController
//        //        print("taped")
//        presentViewController(selectPhotoView, animated: true, completion: nil)

//        self.view.insertSubview(alphaView, belowSubview: self.navigationController!.navigationBar)
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()



