//
//  DetailImpianViewController.swift
//  MyMoneeFinal
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class DetailImpianViewController: UIViewController {
    
    var strId: String?
    var strJudul: String?
    var strTabungan: String?
    var strTarget: String?
    var progressMenabung: Float?
    var indexRow: Int?
    
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var bgImage: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var judulText: UILabel!
    @IBOutlet weak var targetText: UILabel!
    @IBOutlet weak var persenTarget: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var indicatorProgress: UIProgressView!
    @IBOutlet weak var tabungan: UILabel!
    @IBOutlet weak var btnKonfirmasi: UIButton!
    @IBOutlet weak var btnKembali: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnUpdate.layer.cornerRadius = 18
        bgImage.layer.cornerRadius = 4
        bgImage.layer.shadowColor = UIColor.darkGray.cgColor
        bgImage.layer.shadowOpacity = 0.7
        bgImage.layer.shadowOffset = .zero
        bgImage.layer.shadowRadius = 3
        detailView.layer.cornerRadius = 30
        detailView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        progressView.layer.cornerRadius = 4
        progressView.layer.shadowColor = UIColor.darkGray.cgColor
        progressView.layer.shadowOpacity = 0.7
        progressView.layer.shadowOffset = .zero
        progressView.layer.shadowRadius = 3
        btnKonfirmasi.layer.cornerRadius = 20
        btnKembali.layer.cornerRadius = 20
        btnKembali.layer.borderWidth = 2
        btnKembali.layer.borderColor = UIColor(rgb: 0x5069B8).cgColor
        
        self.judulText.text = strJudul
        self.targetText.text = "Rp \(strTarget!)"
        self.persenTarget.text = "\(progressMenabung!*100)%"
        self.indicatorProgress.progress = progressMenabung!
        self.tabungan.text = strTabungan
        
        btnKonfirmasi.isEnabled = false
        btnKonfirmasi.backgroundColor = UIColor(rgb: 0xBDBDBD)
        if progressMenabung == 1 {
            btnKonfirmasi.isEnabled = true
            btnKonfirmasi.backgroundColor = UIColor(rgb: 0x5069B8)
        }
    }
    
    @IBAction func btnActEditImpian(_ sender: Any) {
        let editImpian = EditImpianViewController()
        editImpian.strId = strId
        editImpian.strJudul = strJudul
        editImpian.strTabungan = strTabungan
        editImpian.strTarget = strTarget
        editImpian.progressMenabung = progressMenabung
        editImpian.indexRow = indexRow
        self.navigationController?.pushViewController(editImpian, animated: true)
    }
    
    @IBAction func btnActKonfirmasi(_ sender: Any) {
        showKonfirmasi()
    }
    
    func showKonfirmasi() {
        let alert = UIAlertController(title: "Konfirmasi Impian", message: "Apakah anda yakin mengkonfirmasi \n “\(strJudul!) Impian”?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: {
            action in print("Tapped Dismiss")
        }))
        
        alert.addAction(UIAlertAction(title: "Iya Dong!", style: .default, handler: {
            action in print("Tapped Iya")
//            riwayat.insert(
//                Riwayat(
//                    id: "MM-\(GenericId())",
//                    judul: "\(self.strJudul!)",
//                    jumlah: currencyDoubleToStrDot(doubleValue: currencyStrToDouble(strValue: self.strTarget!)),
//                    tanggal: dateNow.getDate,
//                    status: false
//                ), at: 0
//            )
//
//            impian.remove(at: self.indexRow!)
//            self.btnKembaliAction("")
            
            serviceRiwayat.addRiwayatList(
                uploadDataModel: Riwayat(
                    judul: self.strJudul!,
                    jumlah: currencyDoubleToStrDot(doubleValue: currencyStrToDouble(strValue: self.strTarget!)),
                    tanggal: dateNow.getDate,
                    status: false
                )) {
                DispatchQueue.main.async {
                    serviceImpian.delImpianList(id: self.strId!) {
                        DispatchQueue.main.async {
                            self.showToast(message: "Berhasil menambah data", font: .systemFont(ofSize: 16.0))
                            self.btnKembaliAction("")
                        }
                    }
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
    @IBAction func btnKembaliAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
