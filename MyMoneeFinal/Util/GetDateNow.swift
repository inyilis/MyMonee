//
//  GetDateNow.swift
//  MyMoneeFinal
//
//  Created by MacBook on 16/05/21.
//

import Foundation

//func getDate() -> String {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "dd MMM yyy - HH.mm"
//    let dateNow = dateFormatter.string(from: Date())
//    return "\(dateNow)"
//}

extension String {
    var getDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self
        let dateNow = dateFormatter.string(from: Date())
        return "\(dateNow)"
    }
}

let dateNow: String = "dd MMM yyy - HH.mm"
