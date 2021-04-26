//
//  EquipmentHeaderView.swift
//  JarusAssigment
//
//  Created by BhumeshwerKatre on 11/04/21.
//

import UIKit
protocol EquipmentHeaderViewDelegate: class {
    func didHeaderCheckedUncheckedAtSection(section: Int)
    func didHeaderTapAtSection(section: Int)
}
class EquipmentHeaderView: UITableViewHeaderFooterView {
    static let headerID = "EquipmentHeaderView"
    let checkUncheckButton: UIButton = UIButton(type: .custom)
    let arrowPositionImageView: UIImageView = UIImageView(frame: .zero)
    var titleLabel: UILabel = UILabel()
    weak var delegate: EquipmentHeaderViewDelegate?
    var section: Int = -1
    var tapGesture: UITapGestureRecognizer!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layout()
    }
    private func layout() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        arrowPositionImageView.contentMode = .center
        checkUncheckButton.imageView?.contentMode = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowPositionImageView.translatesAutoresizingMaskIntoConstraints = false
        checkUncheckButton.translatesAutoresizingMaskIntoConstraints = false
        checkUncheckButton.addTarget(self, action: #selector(checkedUncheckedAction), for: .touchUpInside)
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapAction))
        self.addGestureRecognizer(tapGesture)
        self.contentView.addSubview(checkUncheckButton)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(arrowPositionImageView)
        
        setupConstraints()
    }
    private func setupConstraints() {
        checkUncheckButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        checkUncheckButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        checkUncheckButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        checkUncheckButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true


        titleLabel.leadingAnchor.constraint(equalTo: checkUncheckButton.trailingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true

        arrowPositionImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16).isActive = true
        arrowPositionImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        arrowPositionImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        arrowPositionImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        arrowPositionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func checkedUncheckedAction() {
        delegate?.didHeaderCheckedUncheckedAtSection(section: section)
    }
    @objc func headerTapAction() {
        delegate?.didHeaderTapAtSection(section: section)
    }
    func configureHeader(_ header: NSAttributedString, isChecked: Bool, isOpen: Bool) {
        self.titleLabel.attributedText = header
        if isChecked {
            self.checkUncheckButton.setImage(UIImage(named: "check"), for: .normal)
        } else {
            self.checkUncheckButton.setImage(UIImage(named: "uncheck"), for: .normal)
        }
        
        self.arrowPositionImageView.image = UIImage(named: "arrow-right")
        if isOpen {
            self.arrowPositionImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2));
        } else {
            self.arrowPositionImageView.transform = CGAffineTransform(rotationAngle: CGFloat(0));
        }
    }
}
