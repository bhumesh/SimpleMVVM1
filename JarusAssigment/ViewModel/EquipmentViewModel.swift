//
//  ListViewModel.swift
//  JarusAssigment
//
//  Created by BhumeshwerKatre on 11/04/21.
//

import Foundation
import UIKit

struct EquipmentDetails {
    let title: String
    let value: String
}
struct EquipmentSection {
    var isOpened: Bool = false
    var checked: Bool = false
    let attributedTitle: NSAttributedString
    let details: [EquipmentDetails]
}
class EquipmentViewModel {
    var dataSource: [EquipmentSection] = [EquipmentSection]()

    var fetcher: DataFetcher
    init(withDataFetcher fetcher: DataFetcher) {
        self.fetcher = fetcher
    }
    func getEquipmentList(completion: @escaping() -> Void) {
        fetcher.getDataForRequest("assignment") { (result: Result<[EquipmentElement], APIError>) in
            switch result {
            case .success(let model):
                self.prepareUIModels(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    func prepareUIModels(_ array: [EquipmentElement]) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        self.dataSource = array.map { (model) -> EquipmentSection in
            let valueFomatted = formatter.string(from: NSNumber(value: model.value)) ?? "$0.00"
            let details = [EquipmentDetails(title: "VIN", value: model.vin),
                           EquipmentDetails(title: "Year", value: "\(model.year)"),
                           EquipmentDetails(title: "Make", value: "\(model.make)"),
                           EquipmentDetails(title: "Value", value: "\(valueFomatted)"),
                           EquipmentDetails(title: "Length", value: "\(model.value)")]
            let text = "\(model.id) \(model.make)"
            var attributedString = NSMutableAttributedString(string: text,  attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
            let range = (text as NSString).range(of: "\(model.id)")
            attributedString.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], range: range)

            let section = EquipmentSection(attributedTitle: attributedString, details: details)
            return section
        }
    }
}
