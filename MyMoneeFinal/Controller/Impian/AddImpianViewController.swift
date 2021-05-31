//
//  AddImpianViewController.swift
//  MyMoneeFinal
//
//  Created by MacBook on 16/05/21.
//

import UIKit

class AddImpianViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var judulField: UITextField!
    @IBOutlet weak var jumlahField: UITextField!
    @IBOutlet weak var btnSimpan: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jumlahField.delegate = self
        judulField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        jumlahField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)

        btnSimpan.layer.cornerRadius = 20
        btnSimpan.backgroundColor = UIColor(rgb: 0xBDBDBD)
        btnSimpan.isEnabled = false
    }

    @IBAction func btnActKembali(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnActSimpan(_ sender: Any) {
//        impian.insert(
//            Impian(
//                judul:  "\(judulField.text ?? "")",
//                target: currencyDoubleToStrDot(doubleValue: currencyStrToDouble(strValue: jumlahField.text ?? ""))
//            ), at: 0)
//        self.showToast(message: "Proses menambah data", font: .systemFont(ofSize: 12.0))
        serviceImpian.addImpianList(
            uploadDataModel: Impian(
                judul: "\(judulField.text ?? "")",
                target: currencyDoubleToStrDot(doubleValue: currencyStrToDouble(strValue: jumlahField.text ?? ""))
            )) {
            DispatchQueue.main.async {
                self.showToast(message: "Berhasil menambah data", font: .systemFont(ofSize: 16.0))
                self.btnActKembali("")
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
//        print("\(judulField.text!) = \(jumlahField.text!)")
        if (self.judulField.text == "") || (self.jumlahField.text == "") {
            btnSimpan.isEnabled = false
            btnSimpan.backgroundColor = UIColor(rgb: 0xBDBDBD)
        } else {
            btnSimpan.isEnabled = true
            btnSimpan.backgroundColor = UIColor(rgb: 0x5069B8)
        }
    }
    
}
