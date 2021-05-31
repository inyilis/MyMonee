//
//  BerandaViewController.swift
//  MyMoneeFinal
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class BerandaViewController: UIViewController, DataKosongDelegate {
    
    @IBOutlet weak var addIO: UIButton!
    @IBOutlet weak var greetings: UILabel!
    @IBOutlet weak var yourName: UILabel!
    @IBOutlet weak var saldoTerkini: UILabel!
    @IBOutlet weak var subViewSaldo: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subViewRiwayat: UIView!
    @IBOutlet weak var labelRiwayat: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dataKosongView: DataKosong!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addIO.layer.cornerRadius = 18
        subViewSaldo.layer.cornerRadius = 8
        subViewRiwayat.layer.cornerRadius = 30
        subViewRiwayat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        dataKosongView.btnAct.layer.cornerRadius = 20
        dataKosongView.btnAct.setTitle("Tambah Penggunaan", for: .normal)
        dataKosongView.delegate = self
        dataKosongView.isHidden = true
        labelRiwayat.isHidden = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let uiNIbUangIO = UINib(nibName: String(describing: UangIOCollectionViewCell.self), bundle: nil)
        collectionView.register(uiNIbUangIO, forCellWithReuseIdentifier: String(describing: UangIOCollectionViewCell.self))
        
        let uiNIbRiwayat = UINib(nibName: String(describing: RiwayatTableViewCell.self), bundle: nil)
        tableView.register(uiNIbRiwayat, forCellReuseIdentifier: String(describing: RiwayatTableViewCell.self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
        
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 0 && hour <= 10 {
            self.greetings.text = "Selamat Pagi,"
        }
        if hour >= 11 && hour <= 14 {
            self.greetings.text = "Selamat Siang,"
        }
        if hour >= 15 && hour <= 17 {
            self.greetings.text = "Selamat Sore,"
        }
        if hour >= 18 && hour <= 23 {
            self.greetings.text = "Selamat Malam,"
        }
        
    }
    
    func loadData() {
        loading.isHidden = false
        serviceRiwayat.loadRiwayatList { (riwayatList) in
            DispatchQueue.main.async {
                self.loading.isHidden = true
                riwayat = riwayatList
                self.tableView.reloadData()
                self.collectionView.reloadData()
                self.getDataKosongView()
                CekSaldo()
                self.yourName.text = userData.value(forKey: "name") as? String
                self.saldoTerkini.text = "Rp \(mySaldo)"
            }
        }
    }
    
    @IBAction func addRiwayat(_ sender: Any) {
        let addRiwayat = AddRiwayatViewController()
        addRiwayat.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addRiwayat, animated: true)
//        UIView.transition(
//            with: self.navigationController!.view,
//            duration: 0.5,
//            options: UIView.AnimationOptions.transitionCrossDissolve,
//            animations: nil, completion: nil)
    }
    
    func add() {
        addRiwayat("")
    }
    
    func getDataKosongView() {
        if (riwayat.count > 0) {
            dataKosongView.isHidden = true
            labelRiwayat.isHidden = false
            tableView.isHidden = false
        } else {
            dataKosongView.isHidden = false
            labelRiwayat.isHidden = true
            tableView.isHidden = true
        }
    }
    
}

extension BerandaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return uangIO.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UangIOCollectionViewCell.self), for: indexPath) as! UangIOCollectionViewCell
        cell.judulText.text = uangIO[indexPath.row].judul
        cell.jumlahText.text = "Rp \(uangIO[indexPath.row].jumlah ?? "")"
        if uangIO[indexPath.row].status{
            cell.imageView.image = UIImage(named: "ic_up")
        } else {
            cell.imageView.image = UIImage(named: "ic_down")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - (8), height: 47)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}

extension BerandaViewController: UITableViewDelegate, UITableViewDataSource{
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riwayat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RiwayatTableViewCell.self), for: indexPath) as! RiwayatTableViewCell
        cell.judulText.text = riwayat[indexPath.row].judul
        cell.tanggalText.text = riwayat[indexPath.row].tanggal
        if riwayat[indexPath.row].status{
            cell.jumlahText.text = "+Rp \(riwayat[indexPath.row].jumlah!)"
            cell.imageStatus.image = UIImage(named: "ic_up")
            cell.jumlahText.textColor = UIColor(rgb: 0x219653)
            cell.bgImage.backgroundColor = UIColor(rgb: 0x219653).withAlphaComponent(0.2)
        } else {
            cell.jumlahText.text = "-Rp \(riwayat[indexPath.row].jumlah!)"
            cell.imageStatus.image = UIImage(named: "ic_down")
            cell.jumlahText.textColor = UIColor(rgb: 0xEB5757)
            cell.bgImage.backgroundColor = UIColor(rgb: 0xEB5757).withAlphaComponent(0.2)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailRiwayat = DetailRiwayatViewController()
        detailRiwayat.strId = riwayat[indexPath.row].id!
        detailRiwayat.strJudul = riwayat[indexPath.row].judul!
        detailRiwayat.strJumlah = riwayat[indexPath.row].jumlah!
        detailRiwayat.strTgl = riwayat[indexPath.row].tanggal!
        detailRiwayat.boolStatus = riwayat[indexPath.row].status
        detailRiwayat.indexRow = indexPath.row
        detailRiwayat.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(detailRiwayat, animated: true)
    }
    
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")
       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }
    
   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}


extension UIViewController {
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/4, y: self.view.frame.size.height/2, width: 200, height: 35))
        toastLabel.backgroundColor = UIColor.systemIndigo.withAlphaComponent(1.0)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
