//
//  ImpianViewController.swift
//  MyMoneeFinal
//
//  Created by MacBook on 14/05/21.
//

import UIKit

class ImpianViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddImpian: UIButton!
    @IBOutlet weak var dataKosongView: DataKosong!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        btnAddImpian.layer.cornerRadius = 18
        dataKosongView.btnAct.layer.cornerRadius = 20
        dataKosongView.btnAct.setTitle("Buat Impian", for: .normal)
        dataKosongView.contentView.backgroundColor = UIColor(rgb: 0xF3F5FA)
        dataKosongView.delegate = self
        dataKosongView.isHidden = true
        
        let uiNIbImpian = UINib(nibName: String(describing: ImpianTableViewCell.self), bundle: nil)
        tableView.register(uiNIbImpian, forCellReuseIdentifier: String(describing: ImpianTableViewCell.self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    func loadData(){
        self.loading.isHidden = false
        serviceImpian.loadImpianList { (impianList) in
            DispatchQueue.main.async {
                self.loading.isHidden = true
                impian = impianList
                self.tableView.reloadData()
                self.getDataKosongView()
            }
        }
    }
    
    @IBAction func btnActAddImpian(_ sender: Any) {
        let addImpian = AddImpianViewController()
        addImpian.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addImpian, animated: true)
    }
    
    func getDataKosongView(){
        if impian.count == 0 {
            dataKosongView.isHidden = false
            tableView.isHidden = true
        } else {
            dataKosongView.isHidden = true
            tableView.isHidden = false
        }
    }
    
}

extension ImpianViewController: UITableViewDelegate, UITableViewDataSource, ButtonCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return impian.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImpianTableViewCell.self), for: indexPath) as! ImpianTableViewCell
        cell.judulText.text = impian[indexPath.row].judul
        cell.progressMenabung.progress = progressImpian(strSaldo: mySaldo, strTarget: impian[indexPath.row].target!)
        cell.tabunganText.text = "IDR \(mySaldo) / IDR \(impian[indexPath.row].target!)"
        
        cell.btnDelegate = self
        cell.btnDone.tag = indexPath.row
        cell.btnDel.tag = Int(impian[indexPath.row].id!)!
        
        if progressImpian(strSaldo: mySaldo, strTarget: impian[indexPath.row].target!) == 1 {
            cell.btnDone.isEnabled = true
            cell.btnDone.setImage(UIImage(named: "ic_done"), for: .normal)
        } else {
            cell.btnDone.isEnabled = false
            cell.btnDone.setImage(UIImage(named: "ic_undone"), for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailImpian = DetailImpianViewController(nibName: String(describing: DetailImpianViewController.self), bundle: nil)
        detailImpian.strId = impian[indexPath.row].id!
        detailImpian.strJudul = impian[indexPath.row].judul!
        detailImpian.strTarget = impian[indexPath.row].target!
        detailImpian.progressMenabung = progressImpian(strSaldo: mySaldo, strTarget: impian[indexPath.row].target!)
        detailImpian.strTabungan = "IDR \(mySaldo) / IDR \(impian[indexPath.row].target!)"
        detailImpian.indexRow = indexPath.row
        detailImpian.hidesBottomBarWhenPushed = true
        
//        self.present(detailRiwayat, animated: true, completion: nil)
        self.navigationController?.pushViewController(detailImpian, animated: true)
//        print(riwayat[indexPath.row])
    }
    
    
    func progressImpian(strSaldo: String, strTarget: String) -> Float {
        var progress = Float(currencyStrToDouble(strValue: strSaldo) / currencyStrToDouble(strValue: strTarget) * 100 / 100)
        if progress >= 1 {
            progress = 1
        }
        if progress < 0 {
            progress = 0
        }
        return progress
    }
    
    func done(_ sender: UIButton) {
        print(sender.tag)
        showKonfirmasi(indexRow: (sender.tag))
    }
    
    func showKonfirmasi(indexRow: Int) {
        let alert = UIAlertController(title: "Konfirmasi Impian", message: "Apakah anda yakin mengkonfirmasi \n “Impian ini”?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: {
            action in print("Tapped Dismiss")
        }))
        
        alert.addAction(UIAlertAction(title: "Iya Dong!", style: .default, handler: {
            action in print("Tapped Iya")
//            riwayat.insert(
//                Riwayat(
//                    id: "MM-\(GenericId())",
//                    judul: "\(impian[indexRow].judul!)",
//                    jumlah: currencyDoubleToStrDot(doubleValue: currencyStrToDouble(strValue: impian[indexRow].target!)),
//                    tanggal: dateNow.getDate,
//                    status: false
//                ), at: 0
//            )
//
//            impian.remove(at: indexRow)
            
            serviceRiwayat.addRiwayatList(
                uploadDataModel: Riwayat(
                    judul: impian[indexRow].judul,
                    jumlah: currencyDoubleToStrDot(doubleValue: currencyStrToDouble(strValue: impian[indexRow].target!)),
                    tanggal: dateNow.getDate,
                    status: false
                )) {
                DispatchQueue.main.async {
                    serviceImpian.delImpianList(id: impian[indexRow].id!) {
                        DispatchQueue.main.async {
                            self.showToast(message: "Berhasil menambah data", font: .systemFont(ofSize: 16.0))
                            self.loadData()
                        }
                    }
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
    func del(_ sender: UIButton) {
        print(sender.tag)
        showAlertDel(indexRow: sender.tag)
    }
    
    func showAlertDel(indexRow: Int) {
        let alert = UIAlertController(title: "Menghapus Impian", message: "Apakah anda yakin menghapus\n“Impian ini”?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: {
            action in print("Tapped Dismiss")
        }))
        
        alert.addAction(UIAlertAction(title: "Hapus", style: .destructive, handler: {
            action in print("Tapped Delete")
//            impian.remove(at: indexRow)
            
            serviceImpian.delImpianList(id: "\(indexRow)") {
                DispatchQueue.main.async { [self] in
                    showToast(message: "Berhasil menghapus data", font: .systemFont(ofSize: 16.0))
                    loadData()
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
}

extension ImpianViewController: DataKosongDelegate {
    
    func add() {
        btnActAddImpian("")
    }
}
