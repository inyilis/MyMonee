//
//  Riwayat.swift
//  MyMoneeFinal
//
//  Created by MacBook on 14/05/21.
//

import Foundation

//let riwayatData = UserDefaults.standard

struct Riwayat: Codable {
    var id: String?
    var judul: String?
    var jumlah: String?
    var tanggal: String?
    var status: Bool = false
}

var riwayat: [Riwayat] = []

//var riwayat: [Riwayat] = [
//    Riwayat(id: "MM-128371", judul: "Bayar Listrik Kost", jumlah: "256.000", tanggal: "10 Februari 2021 - 19.30", status: false),
//    Riwayat(id: "MM-128371", judul: "Gaji Februari", jumlah: "1.250.000", tanggal: "1 Februari 2021 - 19.30", status: true),
//    Riwayat(id: "MM-128371", judul: "Bayar Listrik", jumlah: "256.000", tanggal: "10 Januari 2021 - 19.30", status: false),
//    Riwayat(id: "MM-128371", judul: "Gaji Januari", jumlah: "1.250.000", tanggal: "1 Januari 2021 - 19.30", status: true),
//    Riwayat(id: "MM-128371", judul: "Bayar Listrik", jumlah: "256.000", tanggal: "10 Desember 2020 - 19.30", status: false),
//    Riwayat(id: "MM-128371", judul: "Gaji Desember", jumlah: "1.250.000", tanggal: "1 Desember 2020 - 19.30", status: true),
//    Riwayat(id: "MM-128371", judul: "Bayar Listrik", jumlah: "256.000", tanggal: "10 November 2020 - 19.30", status: false),
//    Riwayat(id: "MM-128371", judul: "Gaji November", jumlah: "1.250.000", tanggal: "1 November 2020 - 19.30", status: true),
//    Riwayat(id: "MM-128371", judul: "Bayar Listrik", jumlah: "256.000", tanggal: "10 Oktober 2020 - 19.30", status: false),
//    Riwayat(id: "MM-128371", judul: "Gaji Oktober", jumlah: "1.250.000", tanggal: "1 Oktober 2020 - 19.30", status: true),
//    Riwayat(id: "MM-128371", judul: "Bayar Listrik", jumlah: "256.000", tanggal: "10 September 2020 - 19.30", status: false),
//    Riwayat(id: "MM-128371", judul: "Gaji September", jumlah: "1.250.000", tanggal: "1 September 2020 - 19.30", status: true)
//]

