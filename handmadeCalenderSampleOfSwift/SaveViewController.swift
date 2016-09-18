//
//  SaveViewController.swift
//  handmadeCalenderSampleOfSwift
//
//  Created by erijae on 2015/12/06.
//  Copyright © 2015年 just1factory. All rights reserved.
//

import UIKit


class SaveViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var photoSelectButton: UIButton!
    @IBOutlet var mainImageView: UIImage!
    @IBOutlet var displayDateLabel: UILabel!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 43, green: 216, blue: 164, alpha: 1)
//        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
//    }
    
    
    @IBAction func photoSelectButtonTouchDown(sender: AnyObject){
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            UIAlertView(title: "警告", message: "Photoライブラリにアクセスできません", delegate: nil, cancelButtonTitle: "OK").show()
        } else {
            let imagePickerController = UIImagePickerController()
            
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = self
            self.presentViewController(imagePickerController, animated:true, completion:nil)
        }
        
        func imagePickerController(picker: UIImagePickerController!, didfinishPikingMediaWithInfo info: NSDictionary!){
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            mainImageView = UIImage(named: "Fahionimage" )
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    @IBOutlet var fashionimage: UIImageView!
    
    @IBAction func selectBackground(){
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        fashionimage!.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save() {
        
        UIImageWriteToSavedPhotosAlbum(mainImageView, self, "image:didFinishSavingWithError:contextInfo:", nil)
    
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        
        var title = "保存完了"
        var message = "アルバムへの保存完了"
        
        if error != nil {
            title = "エラー"
            message = "アルバムへの保存に失敗しました"
        }
        
        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK")
        alert.show()
    }

    

    
}
