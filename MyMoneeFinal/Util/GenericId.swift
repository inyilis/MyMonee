//
//  GenericId.swift
//  MyMoneeFinal
//
//  Created by MacBook on 17/05/21.
//

import Foundation

func GenericId() -> String {
    var id: String = ""
    for _ in 1...6 {
        let randomInt = Int.random(in: 1...9)
        id += "\(randomInt)"
    }
    return id
}
