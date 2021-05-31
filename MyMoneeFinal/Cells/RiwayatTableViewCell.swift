//
//  RiwayatTableViewCell.swift
//  MyMoneeFinal
//
//  Created by MacBook on 14/05/21.
//

import UIKit

class RiwayatTableViewCell: UITableViewCell {

    @IBOutlet weak var bgImage: UIView!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var judulText: UILabel!
    @IBOutlet weak var tanggalText: UILabel!
    @IBOutlet weak var jumlahText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgImage.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
