//
//  detailsVC.swift
//  Seyehat Kitabım
//
//  Created by Erdo on 12.01.2019.
//  Copyright © 2019 Erdo. All rights reserved.
//

import UIKit
import CoreData
class detailsVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    
    @IBOutlet weak var imageText: UIImageView!
    
    
    @IBOutlet weak var artersText: UITextField!
    
    @IBOutlet weak var nameText: UITextField!
   
    @IBOutlet weak var yearText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageText.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(detailsVC.selectImage))
        imageText.addGestureRecognizer(gestureRecognizer)

    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil) //oluşturulan pickerı kullanıcıya göster yani resim seçme ekranını.
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //resim seçme picker bitince ne olacağı kısaca resim seçtikten sonra datayı alıyorsun.
            imageText.image = info[.editedImage] as? UIImage
            self.dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func saveButtonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate  //ilk başta appdelegete oluşturluyordan ordaki funk çağırıyıoz ve kullanıyoz.
        let context = appDelegate.persistentContainer.viewContext
        let newArt = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        //attribute isimleri databasedeki
        newArt.setValue(nameText, forKey: "name")
        newArt.setValue(artersText, forKey: "painter")
        //integer eklerken adam string değer girmemesi lazım database type farklı
        if let year = Int(yearText.text!){
            
            newArt.setValue(year, forKey: "year")
            
        }
        
        let data = imageText.image!.jpegData(compressionQuality: 0.5) //resmin çözünürlüğünü düşürüyor
        newArt.setValue(data, forKey: "image")
        //save ederken try catch hata yakalamamız lazım
        do {
            try context.save()
            print("database kayıt hatası...")
        } catch  {
            print("NO ERROR")
        }
        
    }
    
}

