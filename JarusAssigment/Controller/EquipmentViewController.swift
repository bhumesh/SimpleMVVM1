//
//  EquipmentViewController.swift
//  JarusAssigment
//
//  Created by BhumeshwerKatre on 11/04/21.
//

import UIKit

class EquipmentViewController: UIViewController {
    let viewModel: EquipmentViewModel
    lazy var equipmentView: EquipmentView = {
        return EquipmentView(withViewModel: self.viewModel)
    }()
    required init(withViewModel vm: EquipmentViewModel) {
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(equipmentView)
        equipmentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            equipmentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            equipmentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            equipmentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            equipmentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        // Do any additional setup after loading the view.
        self.title = "Choose Equipment"
        viewModel.getEquipmentList { [weak self] in
            // refersh the UI
            self?.equipmentView.refeshView()
        }
    }
}
