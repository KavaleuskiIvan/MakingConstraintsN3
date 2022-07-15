//
//  MedicParametrsCollectionViewCell.swift
//  MakingConstraintsN3
//
//  Created by Kavaleuski Ivan on 15/07/2022.
//

import UIKit

class MedicParametrsCollectionViewCell: UICollectionViewCell {
    
    let parametrLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .systemBlue
        label.layer.borderWidth = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitle(title: String) {
        parametrLabel.text = title
    }
    
    private func setupCell() {
        contentView.addSubview(parametrLabel)
        parametrLabel.frame = contentView.bounds
        parametrLabel.layer.cornerRadius = parametrLabel.frame.height/2.5
        parametrLabel.layer.borderColor = CGColor(red: 0.220, green: 0.220, blue: 0.220, alpha: 0.2)
        parametrLabel.layer.masksToBounds = true
    }
}
