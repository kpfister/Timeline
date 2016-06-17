//
//  PhotoSelectViewController.swift
//  Timeline
//
//  Created by Karl Pfister on 6/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PhotoSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Outlets 
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    weak var delegate: PhotoSelectViewControllerDelegate?
    
    @IBAction func selectImageButtonTapped(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alert = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .ActionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            alert.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: { (_) -> Void in
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (_) -> Void in
                imagePicker.sourceType = .Camera
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            delegate?.photoSelectViewControllerSelected(image)
            addPhotoButton.setTitle("", forState: .Normal)
            imageView.image = image
        }
    }
}

protocol PhotoSelectViewControllerDelegate: class {
    func photoSelectViewControllerSelected(imaage: UIImage)
}
