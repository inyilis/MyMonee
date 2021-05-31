//
//  ImpianTableViewCell.swift
//  MyMoneeFinal
//
//  Created by MacBook on 14/05/21.
//

import UIKit

protocol ButtonCellDelegate {
    func done(_ sender: UIButton)
    func del(_ sender: UIButton)
}

class ImpianTableViewCell: UITableViewCell {
    
    var btnDelegate: ButtonCellDelegate?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var judulText: UILabel!
    @IBOutlet weak var progressMenabung: UIProgressView!
    @IBOutlet weak var tabunganText: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnDel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        self.btnDelegate?.done(sender)
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
        self.btnDelegate?.del(sender)
    }
    
}
