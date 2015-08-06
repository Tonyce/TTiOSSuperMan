//
//  SelfCenterViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/14.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class SelfCenterViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var selfScrollViewContainer: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var selfImage: UIImageView!
    
    @IBOutlet weak var bakSwith: UISwitch!
    
    var selfConfig: SelfConfig!
    var alphaView : UIView!
    
    let selfScrollViewContainerDefaultContentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        selfConfig = SelfConfig.sharedInstance
        
        selfImage.layer.cornerRadius = CGRectGetHeight(selfImage.frame) / 2
        selfImage.layer.masksToBounds = true
        
        let frame: CGRect = self.navigationController!.navigationBar.frame
        alphaView = UIView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height + 20))
        alphaView.backgroundColor = UIColor.redColor()
        alphaView.alpha = 0.3
        
        
        // Do any additional setup after loading the view.
//        saveBtn.setTitle(GoogleIcon.ebc4, forState: UIControlState.Normal)
//        saveBtn.tintColor = UIColor.whiteColor()
//        saveBtn.layer.cornerRadius = CGRectGetHeight(saveBtn.frame) / 2
        
        selfScrollViewContainer.frame = view.frame

        selfScrollViewContainer.contentSize = CGSize(width: view.bounds.width, height:  view.bounds.height )
        // selfScrollViewContainer.contentInset = selfScrollViewContainerDefaultContentInset
        
        selfImage.image = selfConfig.image
        textView.text = selfConfig.word
//        textView.layer.borderWidth = 0.5
//        textView.layer.borderColor = UIColor.MKColor.Grey.CGColor
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
//        let actionImessage = UIAlertAction(title: "photoLib", style: UIAlertActionStyle.Default,
//            handler: {(paramAction:UIAlertAction!) in
//                                self.selectFromLib()
//                /* Send the photo via iMessage */
//        })
        let actionFromPhoto = UIAlertAction(title: "photoLib", style: UIAlertActionStyle.Default)
            {[unowned self] action -> Void in
                self.selectFromLib()
                /* Send the photo via iMessage */
        }
        let actionCancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel,
            handler: {(paramAction:UIAlertAction!) in

        })
        
//        alertController.addAction(actionEmail)
//        alertController.addAction(actionImessage)
//        alertController.addAction(actionDelete)
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
    //        picker.mediaTypes = [kUTTypeImage]
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
//            selfConfig = SelfConfig(image: image, word: word, userName: selfConfig.userName)
        }
    }
}

extension SelfCenterViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let alpha = offset / 100
        alphaView.alpha = alpha
    }
}


//        let selectPhotoView = storyboard!.instantiateViewControllerWithIdentifier("selectPhotoWay") as! SelectPhotoWayViewController
//        //        print("taped")
//        presentViewController(selectPhotoView, animated: true, completion: nil)

//        self.view.insertSubview(alphaView, belowSubview: self.navigationController!.navigationBar)
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()



