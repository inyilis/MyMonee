//
//  UangIO.swift
//  MyMoneeFinal
//
//  Created by MacBook on 13/05/21.
//

import Foundation

struct UangIO {
    var judul: String?
    var jumlah: String?
    var status: Bool = false
}

var uangIO: [UangIO] = [
    UangIO(judul: "Uang masuk", jumlah: "0", status: true),
    UangIO(judul: "Uang keluar", jumlah: "0", status: false)
]
