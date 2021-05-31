//
//  DetailRiwayatViewController.swift
//  MyMoneeFinal
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class DetailRiwayatViewController: UIViewController {

    var strId: String?
    var strJudul: String?
    var strJumlah: String?
    var strTgl: String?
    var boolStatus: Bool = false
    var indexRow: Int?
    
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var bgImage: UIView!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var judulText: UILabel!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var jumlahText: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var tglLabel: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnUpdate.layer.cornerRadius = 18
        bgImage.layer.cornerRadius = 4
        detailView.layer.cornerRadius = 30
        detailView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        btnBack.layer.cornerRadius = 20
        btnBack.layer.borderWidth = 2
        btnBack.layer.borderColor = UIColor(rgb: 0x5069B8).cgColor

        self.idLabel.text = strId
        self.judulText.text = strJudul
        self.tglLabel.text = strTgl
        
        if boolStatus {
            self.jumlahText.text = "+Rp \(strJumlah ?? "")"
            self.statusText.text = "Pemasukan"
            self.imageStatus.image = UIImage(named: "ic_up")
            self.jumlahText.textColor = UIColor(rgb: 0x219653)
            self.bgImage.backgroundColor = UIColor(rgb: 0x219653).withAlphaComponent(0.2)
        } else {
            self.jumlahText.text = "-Rp \(strJumlah ?? "")"
            self.statusText.text = "Pengeluaran"
            self.imageStatus.image = UIImage(named: "ic_down")
            self.jumlahText.textColor = UIColor(rgb: 0xEB5757)
            self.bgImage.backgroundColor = UIColor(rgb: 0xEB5757).withAlphaComponent(0.2)
        }
        
    }
    
    @IBAction func btnEditRiwayat(_ sender: Any) {
        let editRiwayatView = EditRiwayatViewController()
        editRiwayatView.strId = strId
        editRiwayatView.strJudul = strJudul
        editRiwayatView.strJumlah = strJumlah
        editRiwayatView.strTgl = strTgl
        editRiwayatView.boolStatus = boolStatus
        editRiwayatView.indexRow = indexRow
        self.navigationController?.pushViewController(editRiwayatView, animated: true)
    }
    
    @IBAction func btnKembali(_ sender: Any) {
//        let berandaView = BerandaViewController()
//        berandaView.modalPresentationStyle = .fullScreen
//        berandaView.modalTransitionStyle = .crossDissolve
//        present(berandaView, animated: true)
//        let berandaView = BerandaViewController(nibName: String(describing: BerandaViewController.self), bundle: nil)
//        self.navigationController?.pushViewController(berandaView, animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
