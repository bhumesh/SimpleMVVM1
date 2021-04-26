//
//  ListView.swift
//  JarusAssigment
//
//  Created by BhumeshwerKatre on 11/04/21.
//

import UIKit


class EquipmentView: UIView {
    let viewModel: EquipmentViewModel
    private let equipmentTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(EquimpmentInfoCell.self, forCellReuseIdentifier: EquimpmentInfoCell.cellID)
        tableView.register(EquipmentHeaderView.self, forHeaderFooterViewReuseIdentifier: EquipmentHeaderView.headerID)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 32.0
        tableView.estimatedSectionHeaderHeight = 48.0
        tableView.estimatedSectionFooterHeight = 1.0

        tableView.allowsMultipleSelection = true
        return tableView
    }()
    
    init(withViewModel viewModel: EquipmentViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        layout()
    }
    
    private func layout() {
        self.addSubview(equipmentTable)
        equipmentTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            equipmentTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            equipmentTable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            equipmentTable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            equipmentTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
         ])
        setupList()
    }
    private func setupList() {
        self.equipmentTable.dataSource = self
        self.equipmentTable.delegate = self
    }
    required init?(coder: NSCoder) {
        return nil
    }
}

extension EquipmentView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = self.viewModel.dataSource[section]
        if sectionModel.isOpened {
            return sectionModel.details.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EquimpmentInfoCell.cellID, for: indexPath) as?  EquimpmentInfoCell else {
            return UITableViewCell()
        }
        let sectionModel = self.viewModel.dataSource[indexPath.section]
        if sectionModel.isOpened {
            cell.textLabel?.text = sectionModel.details[indexPath.row].title
            cell.detailTextLabel?.text = sectionModel.details[indexPath.row].value
            cell.detailTextLabel?.textAlignment = .left

        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: EquipmentHeaderView.headerID) as? EquipmentHeaderView else {
            return nil
        }
        headerView.section = section
        headerView.delegate = self
        let sectionModel = self.viewModel.dataSource[section]
        headerView.configureHeader(sectionModel.attributedTitle, isChecked: sectionModel.checked, isOpen: sectionModel.isOpened)
        return headerView
    }
}
extension EquipmentView: EquipmentHeaderViewDelegate {
    func didHeaderCheckedUncheckedAtSection(section: Int) {
        var sectionModel = self.viewModel.dataSource[section]
        sectionModel.checked = !sectionModel.checked
        self.viewModel.dataSource[section] = sectionModel
        self.equipmentTable.reloadSections([section], with: .none)
    }
    
    func didHeaderTapAtSection(section: Int) {
        var sectionModel = self.viewModel.dataSource[section]
        sectionModel.isOpened = !sectionModel.isOpened
        self.viewModel.dataSource[section] = sectionModel
        self.equipmentTable.reloadSections([section], with: .none)
    }
}
extension EquipmentView {
    func refeshView() {
        DispatchQueue.main.async {
            self.equipmentTable.reloadData()
        }
    }
}
