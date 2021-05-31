//
//  UangIOCollectionViewCell.swift
//  MyMoneeFinal
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class UangIOCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var judulText: UILabel!
    @IBOutlet weak var jumlahText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = 4
    }

}
