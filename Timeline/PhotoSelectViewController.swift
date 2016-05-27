//
//  PhotoSelectViewController.swift
//  Timeline
//
//  Created by Caleb Hicks on 5/25/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PhotoSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var delegate: PhotoSelectViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectPhotoButtonTapped() {
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
            
            let size = image.sizeForMaxHeight(400)
            
            let resizedImage = image.copyImageToSize(size)
            
            delegate?.photoSelectViewControllerSelected(image)
            addPhotoButton.setTitle("", forState: .Normal)
            imageView.image = image
        }
    }
}

protocol PhotoSelectViewControllerDelegate: class {
    
    func photoSelectViewControllerSelected(image: UIImage)
}

extension UIImage {
    
    func copyImageToSize(size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size);
        
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
    
    func sizeForMaxHeight(targetHeight: CGFloat) -> CGSize {
        
        let scaleFactor = targetHeight / self.size.height
        let targetWidth = self.size.width * scaleFactor
        
        return CGSize(width: targetWidth, height: targetHeight)
    }
}