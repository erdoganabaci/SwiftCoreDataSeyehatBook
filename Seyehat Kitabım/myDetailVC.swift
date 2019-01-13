//
//  myDetailVC.swift
//  Seyehat Kitabım
//
//  Created by Erdo on 13.01.2019.
//  Copyright © 2019 Erdo. All rights reserved.
//

import UIKit
import CoreData
class myDetailVC: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var myimageView: UIImageView!
    @IBOutlet weak var myNameText: UITextField!
    @IBOutlet weak var myPainterText: UITextField!
    @IBOutlet weak var myYearText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myimageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myDetailVC.selectImage))
        myimageView.addGestureRecognizer(gestureRecognizer)
    }
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        myimageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    
    
    }
    @IBAction func mySaveButtonClick(_ sender: Any) {
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newArt = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        newArt.setValue(myNameText.text, forKey: "name")
        newArt.setValue(myPainterText.text, forKey: "paint")
        if let yil = Int(myYearText.text!){
            newArt.setValue(yil, forKey: "year")
        }
         if(myimageView.image != nil){
        let data = myimageView.image!.jpegData(compressionQuality: 0.5)
       
        newArt.setValue(data, forKey: "image")
        do {
            try context.save()
            print("No Error")
        } catch  {
            print("ERROR")
        }
      }
    }

}
