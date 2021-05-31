//
//  DataKosong.swift
//  MyMoneeFinal
//
//  Created by MacBook on 16/05/21.
//

import UIKit

protocol DataKosongDelegate {
    func add()
}

class DataKosong: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var btnAct: UIButton!
    
    var delegate: DataKosongDelegate?
    
    // Constractor untuk pembuatan programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    // Constractor untuk pembuatan
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("DataKosong", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    @IBAction func btnActCustom(_ sender: Any) {
        self.delegate?.add()
    }
}
