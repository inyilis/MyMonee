//
//  AddRiwayatViewController.swift
//  MyMoneeFinal
//
//  Created by MacBook on 16/05/21.
//

import UIKit

class AddRiwayatViewController: UIViewController, UITextFieldDelegate {

    var riwayatStatus: Bool?
    var btnInOn: Bool = true
    var btnOutOn: Bool = true
    
    @IBOutlet weak var judulField: UITextField!
    @IBOutlet weak var jumlahField: UITextField!
    @IBOutlet weak var btnIn: UIButton!
    @IBOutlet weak var btnOut: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jumlahField.delegate = self
        judulField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .allEditingEvents)
        jumlahField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        btnIn.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .touchUpInside)
        btnOut.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .touchUpInside)

        btnIn.layer.cornerRadius = 4
        btnIn.layer.shadowColor = UIColor.darkGray.cgColor
        btnIn.layer.shadowOpacity = 0.7
        btnIn.layer.shadowOffset = .zero
        btnIn.layer.shadowRadius = 3
        
        btnOut.layer.cornerRadius = 4
        btnOut.layer.shadowColor = UIColor.darkGray.cgColor
        btnOut.layer.shadowOpacity = 0.7
        btnOut.layer.shadowOffset = .zero
        btnOut.layer.shadowRadius = 3
        
        btnSave.layer.cornerRadius = 20
        btnSave.backgroundColor = UIColor(rgb: 0xBDBDBD)
        btnSave.isEnabled = false
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }

    @IBAction func btnKembali(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
//        UIView.transition(
//            with: self.navigationController!.view,
//            duration: 0.5,
//            options: UIView.AnimationOptions.transitionCrossDissolve,
//            animations: nil, completion: nil)
    }

    @IBAction func btnPemasukan(_ sender: Any) {
        if btnInOn {
            btnIn.isSelected = true
            btnIn.layer.borderWidth = 3
            btnIn.layer.borderColor = UIColor(rgb: 0x5069B8).cgColor
            btnOut.isSelected = false
            btnOut.layer.borderWidth = 0
            riwayatStatus = true
            btnInOn = false
            btnOutOn = true
        } else {
            btnIn.isSelected = false
            btnIn.layer.borderWidth = 0
            btnInOn = true
        }
    }
    
    @IBAction func btnPengeluaran(_ sender: Any) {
        if btnOutOn {
            btnOut.isSelected = true
            btnOut.layer.borderWidth = 3
            btnOut.layer.borderColor = UIColor(rgb: 0x5069B8).cgColor
            btnIn.isSelected = false
            btnIn.layer.borderWidth = 0
            riwayatStatus = false
            btnInOn = true
            btnOutOn = false
        } else {
            btnOut.isSelected = false
            btnOut.layer.borderWidth = 0
            btnOutOn = true
        }
    }
    
    @IBAction func btnSimpan(_ sender: Any) {
//        riwayat.insert(
//            Riwayat(
//                id: "MM-\(GenericId())",
//                judul: "\(judulField.text ?? "")",
//                jumlah: currencyDoubleToStrDot(doubleValue: currencyStrToDouble(strValue: jumlahField.text ?? "")),
//                tanggal: dateNow.getDate,
//                status: riwayatStatus ?? true
//            ), at: 0
//        )
//        self.showToast(message: "Proses menambah data", font: .systemFont(ofSize: 16.0))
        serviceRiwayat.addRiwayatList(
            uploadDataModel: Riwayat(
//                id: "MM-\(GenericId())",
                judul: "\(judulField.text ?? "")",
                jumlah: currencyDoubleToStrDot(doubleValue: currencyStrToDouble(strValue: jumlahField.text ?? "")),
                tanggal: dateNow.getDate,
                status: riwayatStatus ?? true
            )) {
            DispatchQueue.main.async {
                print("Berhasil menambah data")
                self.showToast(message: "Berhasil menambah data", font: .systemFont(ofSize: 16.0))
                self.btnKembali("")
            }
        }
    }
    
    // input hanya angka
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (self.judulField.text == "") || (self.jumlahField.text == "") || !(btnIn.isSelected) && !(btnOut.isSelected) {
            btnSave.isEnabled = false
            btnSave.backgroundColor = UIColor(rgb: 0xBDBDBD)
        } else {
            btnSave.isEnabled = true
            btnSave.backgroundColor = UIColor(rgb: 0x5069B8)
        }
    }
    
}
