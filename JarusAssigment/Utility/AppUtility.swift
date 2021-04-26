//
//  AppUtility.swift
//  JarusAssigment
//
//  Created by BhumeshwerKatre on 11/04/21.
//

import Foundation
class Utility {
    class func loadDataFromFile(_ file: String) -> Data? {
        if let url = Bundle.main.url(forResource: file, withExtension: "json") {
            do {
                return try Data(contentsOf: url, options: .mappedIfSafe)
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
