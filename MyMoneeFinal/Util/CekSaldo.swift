//
//  CekSaldo.swift
//  MyMoneeFinal
//
//  Created by MacBook on 19/05/21.
//

import Foundation

//extension String {
//    var currencyStrToDouble: Double {
//        let formatter = NumberFormatter()
//        formatter.locale = Locale(identifier: "id")
//        formatter.numberStyle = .decimal
//        let number = formatter.number(from: self as String)
//        return number as! Double
//    }
//}

func currencyStrToDouble(strValue: String) -> Double {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "id")
    formatter.numberStyle = .decimal
    let number: NSNumber? = formatter.number(from: strValue) ?? 0
    return number as! Double
}

func currencyDoubleToStr(doubleValue: Double) -> String {
    let formatter = NumberFormatter()
    formatter.groupingSeparator = ""
    formatter.numberStyle = .decimal
    return formatter.string(from: NSNumber(value: doubleValue)) ?? "Rp \(doubleValue)"
}

func currencyDoubleToStrDot(doubleValue: Double) -> String {
    let formatter = NumberFormatter()
    formatter.groupingSeparator = "."
    formatter.numberStyle = .decimal
    return formatter.string(from: NSNumber(value: doubleValue)) ?? "Rp \(doubleValue)"
}

func CekSaldo() {
    var pemasukan: Double = 0
    var pengeluaran: Double = 0
    
    for n in riwayat {
        if n.status {
            pemasukan += currencyStrToDouble(strValue: n.jumlah!)
        } else {
            pengeluaran += currencyStrToDouble(strValue: n.jumlah!)
        }
    }
    
    uangIO[0].jumlah = currencyDoubleToStrDot(doubleValue: pemasukan)
    uangIO[1].jumlah = currencyDoubleToStrDot(doubleValue: pengeluaran)
    mySaldo = currencyDoubleToStrDot(doubleValue: (pemasukan - pengeluaran))
}
