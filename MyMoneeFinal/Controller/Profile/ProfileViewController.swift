//
//  ProfileViewController.swift
//  MyMoneeFinal
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var btnOn: Bool = true

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var btnEditFoto: UIButton!
    @IBOutlet weak var icEditName: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = userData.value(forKey: "name") as? String
        editName.text = userData.value(forKey: "name") as? String
        imageProfile.layer.cornerRadius = 50
        
        nameLabel.isHidden = false
        editName.isHidden = true
        btnEditFoto.isHidden = true
        icEditName.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        infoLabel.text = InfoPengeluaran()
        imageProfile.image = UIImage(data: (userData.value(forKey: "fotoProfile") as? Data)!)
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        
        if btnOn {
            btnEdit.setTitle("Selesai", for: .normal)
            nameLabel.isHidden = true
            editName.isHidden = false
            btnEditFoto.isHidden = false
            icEditName.isHidden = false
            btnOn = false
        } else {
            btnEdit.setTitle("Edit", for: .normal)
            nameLabel.isHidden = false
            editName.isHidden = true
            btnEditFoto.isHidden = true
            icEditName.isHidden = true
            userData.setValue(editName.text, forKey: "name")
            nameLabel.text = editName.text
            btnOn = true
        }
    }
    
    @IBAction func btnEditFoto(_ sender: Any) {
        let imageProfile = UIImagePickerController()
        imageProfile.sourceType = .photoLibrary
        imageProfile.delegate = self
        imageProfile.allowsEditing = true
        present(imageProfile, animated: true)
    }
    
    func InfoPengeluaran() -> String {
        let pengeluaran = currencyStrToDouble(strValue: uangIO[1].jumlah!) / currencyStrToDouble(strValue: uangIO[0].jumlah!) * 100
        var infoPengeluaran: String?
        
        if pengeluaran > 0 && pengeluaran <= 35 {
            infoPengeluaran = "Bagus! Pengeluaranmu lebih sedikit dari Pemasukan"
        } else if pengeluaran > 35 && pengeluaran <= 70 {
            infoPengeluaran = "Ingat! Pengeluaranmu setengah dari Pemasukan"
        } else if pengeluaran > 70 && pengeluaran <= 100 {
            infoPengeluaran = "Gawat! Pengeluaranmu hampir sama dengan Pemasukan"
        } else if pengeluaran > 100 {
            infoPengeluaran = "Bahaya! Pengeluaranmu lebih besar dari Pemasukan"
        } else {
            infoPengeluaran = "Selamat datang di aplikasi My Monee!"
        }
        return infoPengeluaran!
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            userData.setValue(image.pngData(), forKey: "fotoProfile")
            imageProfile.image = UIImage(data: (userData.value(forKey: "fotoProfile") as? Data)!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
