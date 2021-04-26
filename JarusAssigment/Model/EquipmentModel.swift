//
//  EquipmentModel.swift
//  JarusAssigment
//
//  Created by BhumeshwerKatre on 11/04/21.
//

import Foundation

struct EquipmentElement: Codable {
    let id: Int
    let vin: String
    let year: Int
    let make: String
    let value, length: Double
}

typealias Equipment = [EquipmentElement]
