//
//  MedicCategoryCollectionViewCell.swift
//  MakingConstraintsN3
//
//  Created by Kavaleuski Ivan on 15/07/2022.
//

import UIKit

class MedicCategoryCollectionViewCell: UICollectionViewCell {
    
    let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .systemBlue
        label.layer.borderWidth = 1
        label.layer.borderColor = CGColor(red: 0.220, green: 0.220, blue: 0.220, alpha: 0.2)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelSelected() {
        categoryNameLabel.backgroundColor = .systemBlue
        categoryNameLabel.textColor = .white
    }
    func setLabelUnSelected() {
        categoryNameLabel.backgroundColor = .white
        categoryNameLabel.textColor = .systemBlue
    }
    
    func setupName(title: String) {
        categoryNameLabel.text = title
    }
    
    private func setupCell() {
        contentView.addSubview(categoryNameLabel)
        categoryNameLabel.frame = contentView.frame
        categoryNameLabel.layer.cornerRadius = categoryNameLabel.frame.height/2.5
        categoryNameLabel.layer.masksToBounds = true
    }
}
