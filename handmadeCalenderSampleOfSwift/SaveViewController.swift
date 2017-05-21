
//
//  SaveViewController.swift
//  handmadeCalenderSampleOfSwift
//
//  Created by erijae on 2015/12/06.
//  Copyright © 2015年 just1factory. All rights reserved.
//

import UIKit


class SaveViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet var commentTextField: UITextField!
    @IBOutlet var photoSelectButton: UIButton!
    @IBOutlet var mainImageView: UIImage!
    @IBOutlet var displayDateLabel: UILabel!
    
    // これを追加
    @IBOutlet var pictureImageView: UIImageView!
    
    var getYear: Int!
    var getMonth: Int!
    var getDay: Int!
    var getDayOfWeek: Int!
    
    let monthName:[String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    
    // これを追加
    // ここ
    // ディクショナリーを宣言
    var dateDictionary: [String: AnyObject]!
    
    
    let saveDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(getYear)
        print(getMonth)
        print(getDay)
        print(getDayOfWeek)
        
        displayDateLabel.text = "\(getYear!)年\(getMonth!)月\(getDay!)日(\(monthName[getDayOfWeek]))"
        
        
        // ここ
        // 保存しているデータがあるかチェック
        if saveDefault.object(forKey: "\(displayDateLabel.text)") != nil {
            print("なんか入ってる")
            let dictionary = saveDefault.object(forKey: "\(displayDateLabel.text)")
            let photo: Data? = (dictionary as AnyObject).value(forKey: "image") as? Data
            let memo: String! = (dictionary as AnyObject).value(forKey: "comment") as! String
            
            let image = UIImage(data: photo!)
            pictureImageView.image = image
            
            
            commentTextField.text = memo
            
        } else {
            print("空やで")
        }
    }
    
    
    
    
    
    
    @IBAction func photoSelectButtonTouchDown(_ sender: AnyObject){
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            UIAlertView(title: "警告", message: "Photoライブラリにアクセスできません", delegate: nil, cancelButtonTitle: "OK").show()
        } else {
            let imagePickerController = UIImagePickerController()
            
            imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = self
            self.present(imagePickerController, animated:true, completion:nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController!, didfinishPikingMediaWithInfo info: NSDictionary!){
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            mainImageView = UIImage(named: "Fahionimage" )
            
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    @IBOutlet var fashionimage: UIImageView!
    
    @IBAction func selectBackground(){
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        fashionimage!.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    //    @IBAction func save() {
    //
    //        UIImageWriteToSavedPhotosAlbum(mainImageView, self, "image:didFinishSavingWithError:contextInfo:", nil)
    //
    //        let alert: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
    //
    //        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in NSLog("OKボタンが押されました！")}))
    //
    //    func image(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
    //
    //        var title = "保存完了"
    //        var message = "アルバムへの保存完了"
    //
    //        if error != nil {
    //            title = "エラー"
    //            message = "アルバムへの保存に失敗しました"
    //        }
    //
    //        //let saveData: UserDefaults.standard
    //
    //        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK")
    //        alert.show()
    //    }
    //
    //
    //
    //
    //}
    
    // ここ
    @IBAction func Save(){
        
        if pictureImageView!.image == nil {
            let picture_alert = UIAlertView()
            picture_alert.title = "写真が選択されていません"
            picture_alert.message = "写真を選択してね！"
            picture_alert.addButton(withTitle: "OK")
            picture_alert.show();
            
            let imagePickerController: UIImagePickerController = UIImagePickerController()
            
            imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            
            pictureImageView.contentMode = UIViewContentMode.center
            self.view.addSubview(pictureImageView)
            
            self.present(imagePickerController, animated: true, completion: nil)
            
        } else {
            
            //save
            
            //写真をnsdataにする
            let photoData: NSData = UIImagePNGRepresentation(pictureImageView!.image!)! as NSData
            
            //日付
            let date_formatter: DateFormatter = DateFormatter()
            date_formatter.locale = NSLocale(localeIdentifier: "ja") as Locale!
            date_formatter.dateFormat = "yyyy/MM/dd"
            print(date_formatter.dateFormat)
            
            
            //Dictionaryに要素を追加
            dateDictionary = ["image": photoData as AnyObject, "comment": commentTextField.text as AnyObject]
            saveDefault.set(dateDictionary, forKey: "\(displayDateLabel.text)")
            saveDefault.synchronize()
            
            print("Saved!")
            
            //保存した後に元の画面に戻る
            self.dismiss(animated: true, completion: nil)
//            let ViewController = self.storyboard!.instantiateViewController( withIdentifier: "FashionVC" )
//            self.present( ViewController, animated: true, completion: nil)
            
        }
        
        // 周辺タップでキーボードを閉じる
        func EndEdit(sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
    }
    
    //    func textFieldShouldReturn(textField: UITextField) -> Bool{
    //        // キーボードを閉じる
    //        self.view.endEditing(true)
    //        return false
    //    }
    
}
