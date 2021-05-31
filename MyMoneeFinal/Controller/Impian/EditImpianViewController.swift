//
//  EditImpianViewController.swift
//  MyMoneeFinal
//
//  Created by MacBook on 16/05/21.
//

import UIKit

class EditImpianViewController: UIViewController, UITextFieldDelegate {
    
    var strId: String?
    var strJudul: String?
    var strTabungan: String?
    var strTarget: String?
    var progressMenabung: Float?
    var indexRow: Int?

    @IBOutlet weak var judulField: UITextField!
    @IBOutlet weak var jumlahField: UITextField!
    @IBOutlet weak var btnPerbarui: UIButton!
    @IBOutlet weak var btnHapus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jumlahField.delegate = self

        btnPerbarui.layer.cornerRadius = 20
        btnHapus.layer.cornerRadius = 20
        btnHapus.layer.borderWidth = 2
        btnHapus.layer.borderColor = UIColor(rgb: 0xEB5757).cgColor
        
        self.judulField.text = strJudul
        self.jumlahField.text = currencyDoubleToStr(doubleValue: currencyStrToDouble(strValue: strTarget!))
    }

    @IBAction func btnActKembali(_ sender: Any) {
        let detailImpian = DetailImpianViewController()
        detailImpian.strId = strId
        detailImpian.strJudul = strJudul
        detailImpian.strTabungan = strTabungan
        detailImpian.strTarget = strTarget
        detailImpian.progressMenabung = progressMenabung
        detailImpian.indexRow = indexRow
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActPerbarui(_ sender: Any) {
//        let idx = indexRow!
//        impian[idx] = Impian(
//            judul: "\(judulField.text ?? "")",
//            target: currencyDoubleToStrDot(doubleValue: currencyStrToDouble(strValue: jumlahField.text ?? "")))
//        kembaliKeImpian()
        
        serviceImpian.updateImpianList(
            id: strId!,
            uploadDataModel: Impian(
                id: strId,
                judul: "\(judulField.text ?? "")",
                target: currencyDoubleToStrDot(doubleValue: currencyStrToDouble(strValue: jumlahField.text ?? ""))
            )) {
            DispatchQueue.main.async {
                self.showToast(message: "Berhasil merubah data", font: .systemFont(ofSize: 16.0))
                self.kembaliKeImpian()
            }
        }
    }
    
    func kembaliKeImpian() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnActHapus(_ sender: Any) {
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Menghapus Impian", message: "Apakah anda yakin menghapus\n“Impian membeli \(strJudul!)”?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: {
            action in print("Tapped Dismiss")
        }))
        
        alert.addAction(UIAlertAction(title: "Hapus", style: .destructive, handler: { [self]
            action in print("Tapped Delete")
//            impian.remove(at: self.indexRow!)
            serviceImpian.delImpianList(id: strId!) {
                DispatchQueue.main.async { [self] in
                    showToast(message: "Berhasil menghapus data", font: .systemFont(ofSize: 16.0))
                    kembaliKeImpian()
                }
            }
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
