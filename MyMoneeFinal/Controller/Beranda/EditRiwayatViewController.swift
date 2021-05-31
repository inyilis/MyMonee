//
//  EditRiwayatViewController.swift
//  MyMoneeFinal
//
//  Created by MacBook on 16/05/21.
//

import UIKit

class EditRiwayatViewController: UIViewController, UITextFieldDelegate {

    var riwayatStatus: Bool?
    var btnInOn: Bool = true
    var btnOutOn: Bool = true
    
    var strId: String?
    var strJudul: String?
    var strJumlah: String?
    var strTgl: String?
    var boolStatus: Bool = false
    var indexRow: Int?
    
    @IBOutlet weak var judulField: UITextField!
    @IBOutlet weak var jumlahField: UITextField!
    @IBOutlet weak var btnIn: UIButton!
    @IBOutlet weak var btnOut: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnDel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jumlahField.delegate = self

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
        
        btnUpdate.layer.cornerRadius = 20
        btnDel.layer.cornerRadius = 20
        btnDel.layer.borderWidth = 2
        btnDel.layer.borderColor = UIColor(rgb: 0xEB5757).cgColor
        
        self.judulField.text = strJudul
        self.jumlahField.text = currencyDoubleToStr(doubleValue: currencyStrToDouble(strValue: strJumlah!))
        riwayatStatus = boolStatus
        if boolStatus {
            btnIn.layer.borderWidth = 3
            btnIn.layer.borderColor = UIColor(rgb: 0x5069B8).cgColor
        } else {
            btnOut.layer.borderWidth = 3
            btnOut.layer.borderColor = UIColor(rgb: 0x5069B8).cgColor
        }
    }

    @IBAction func btnKembali(_ sender: Any) {
        let riwayatView = DetailRiwayatViewController()
        riwayatView.strId = strId
        riwayatView.strJudul = strJudul
        riwayatView.strJumlah = strJumlah
        riwayatView.strTgl = strTgl
        riwayatView.boolStatus = boolStatus
        riwayatView.indexRow = indexRow
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPemasukan(_ sender: Any) {
        if btnInOn {
            btnIn.layer.borderWidth = 3
            btnIn.layer.borderColor = UIColor(rgb: 0x5069B8).cgColor
            btnOut.layer.borderWidth = 0
            riwayatStatus = true
            btnInOn = false
            btnOutOn = true
        } else {
            btnIn.layer.borderWidth = 0
            btnInOn = true
        }
    }
    
    @IBAction func btnPengeluaran(_ sender: Any) {
        if btnOutOn {
            btnOut.layer.borderWidth = 3
            btnOut.layer.borderColor = UIColor(rgb: 0x5069B8).cgColor
            btnIn.layer.borderWidth = 0
            riwayatStatus = false
            btnInOn = true
            btnOutOn = false
        } else {
            btnOut.layer.borderWidth = 0
            btnOutOn = true
        }
    }
    
    @IBAction func btnPerbarui(_ sender: Any) {
//        let idx = indexRow!
//        riwayat[idx] = Riwayat(
//            id: strId,
//            judul: "\(judulField.text ?? "")",
//            jumlah: currencyDoubleToStrDot(doubleValue: currencyStrToDouble(strValue: jumlahField.text ?? "")),
//            tanggal: dateNow.getDate,
//            status: riwayatStatus ?? true)
//        kembaliKeBeranda()
//        self.showToast(message: "Proses merubah data", font: .systemFont(ofSize: 16.0))
        serviceRiwayat.updateRiwayatList(
            id: strId!,
            uploadDataModel: Riwayat(
                judul: "\(judulField.text ?? "")",
                jumlah: currencyDoubleToStrDot(doubleValue: currencyStrToDouble(strValue: jumlahField.text ?? "")),
                tanggal: dateNow.getDate,
                status: riwayatStatus ?? true
            )) {
            DispatchQueue.main.async {
                self.showToast(message: "Berhasil merubah data", font: .systemFont(ofSize: 16.0))
                self.kembaliKeBeranda()
            }
        }
    }
    
    @IBAction func btnHapus(_ sender: Any) {
        showAlertDel()
    }
    
    func kembaliKeBeranda() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showAlertDel() {
        let alert = UIAlertController(title: "Menghapus Riwayat", message: "Apakah anda yakin menghapus \n “Riwayat \(strJudul!)”?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: {
            action in print("Tapped Dismiss")
        }))
        
        alert.addAction(UIAlertAction(title: "Hapus", style: .destructive, handler: {
            action in print("Tapped Delete")
//            self.showToast(message: "Proses menghapus data", font: .systemFont(ofSize: 16.0))
            serviceRiwayat.delRiwayatList(id: self.strId!) {
                DispatchQueue.main.async {
                    self.showToast(message: "Berhasil menghapus data", font: .systemFont(ofSize: 16.0))
                    self.kembaliKeBeranda()
                }
            }
//            riwayat.remove(at: self.indexRow!)
        }))
        
        present(alert, animated: true)
    }
    
    // input hanya angka
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
}
