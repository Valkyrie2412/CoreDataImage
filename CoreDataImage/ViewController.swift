//
//  ViewController.swift
//  CoreDataImage
//
//  Created by Hiếu Nguyễn on 9/22/18.
//  Copyright © 2018 Hiếu Nguyễn. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let entity = try? AppDelegate.context.fetch(Entity.fetchRequest()) as? [Entity] {
            photoImage.image = entity?.last?.photo as? UIImage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Loại bỏ bộ chọn nếu người dùng đã huỷ
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
       
        
        photoImage.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    

    
    // MARK: Actions

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard
//        nameTextField.resignFirstResponder()
        
        // UIImagePickerController là một view controller cho phép một người dùng chọn phương tiện từ thư viện ảnh của họ.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard photoImage.image != nil else {
            return
        }
        let context = Entity(context: AppDelegate.context)
        context.photo = photoImage.image
        AppDelegate.saveContext()

    }
    
    
}

