//
//  AddPostTableViewController.swift
//  Timeline
//
//  Created by Karl Pfister on 6/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var image: UIImage?
    
    //MARK: - Outlets

    @IBOutlet weak var addPostCommentTextField: UITextField!

    //MARK: Actions
    
    @IBAction func addPostButtonTapped(sender: AnyObject) {
        if let image = image, let comment = addPostCommentTextField.text {
            PostController.sharedInstance.createPost(image, caption: comment)
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Missing Information", message: "Sometthing is missing... Check your image and comment.", preferredStyle: .Alert)
            let dismissAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
            alertController.addAction(dismissAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //    @IBAction func selectImageButtonTapped(sender: AnyObject) {
    //        let imagePicker = UIImagePickerController()
    //        imagePicker.delegate = self
    //
    //        let alert = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .ActionSheet)
    //
    //        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
    //            alert.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: { (_) -> Void in
    //                imagePicker.sourceType = .PhotoLibrary
    //                self.presentViewController(imagePicker, animated: true, completion: nil)
    //            }))
    //        }
    //
    //        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
    //            alert.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (_) -> Void in
    //                imagePicker.sourceType = .Camera
    //                self.presentViewController(imagePicker, animated: true, completion: nil)
    //            }))
    //        }
    //
    //        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
    //
    //        presentViewController(alert, animated: true, completion: nil)
    //
    //    }
   
   
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedPhotoSelect" {
            let embedViewController = segue.destinationViewController as? PhotoSelectViewController
            embedViewController?.delegate = self
        }
    }
}

extension AddPostTableViewController: PhotoSelectViewControllerDelegate{
    func photoSelectViewControllerSelected(image: UIImage) {
        self.image = image
    }
}
