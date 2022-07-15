//
//  MedicsTableViewCell.swift
//  MakingConstraintsN3
//
//  Created by Kavaleuski Ivan on 15/07/2022.
//

import UIKit

extension MedicsTableViewCell: ReusableView { }

class MedicsTableViewCell: UITableViewCell {
    
    var medic: MedicModel?
    
    let viewForBorder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameInPhotoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let medicCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mappin.and.ellipse")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var medicParametrsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let medicParametrsCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return medicParametrsCollection
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupMedicParametrsCollection()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableViewCell(medic: MedicModel) {
        
        photoImageView.image = nil
        nameInPhotoLabel.text = nil
        
        if medic.photo != nil {
            photoImageView.image = medic.photo!
        } else {
            photoImageView.backgroundColor = .white
            guard let nameFirstLetter = medic.name.first else { return }
            guard let surnnameFirstLetter = medic.surname.first else { return }
            nameInPhotoLabel.text = String(nameFirstLetter) + String(surnnameFirstLetter)
        }
        
        nameLabel.text = medic.name + " " + medic.surname
        nameLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        
        medicCategoryLabel.text = medic.medicCategory.rawValue
        medicCategoryLabel.font = .systemFont(ofSize: 16, weight: .light)
        
        cityLabel.text = medic.city
        cityLabel.font = .systemFont(ofSize: 16, weight: .light)
        
        infoLabel.text = medic.info
        
        self.medic = medic
        medicParametrsCollection.reloadData()
    }
    
    private func setupMedicParametrsCollection() {
        let layout = UICollectionViewFlowLayout()
        medicParametrsCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: contentView.frame.width/2.5, height: contentView.frame.height/1.2)

        medicParametrsCollection.showsHorizontalScrollIndicator = false
        medicParametrsCollection.translatesAutoresizingMaskIntoConstraints = false
        medicParametrsCollection.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        medicParametrsCollection.delegate = self
        medicParametrsCollection.dataSource = self

        medicParametrsCollection.register(MedicParametrsCollectionViewCell.self, forCellWithReuseIdentifier: "MedicParametrsCollectionViewCell")
    }
}

extension MedicsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let medic = medic else { return 0 }
        return medic.medicParametrs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedicParametrsCollectionViewCell", for: indexPath) as? MedicParametrsCollectionViewCell {
            if medic != nil {
                cell.setupTitle(title: medic!.medicParametrs[indexPath.row].rawValue)
            }
            return cell
        }
        fatalError()
    }
}

private extension MedicsTableViewCell {
    func addSubviews() {
        contentView.addSubview(viewForBorder)
        viewForBorder.addSubview(photoImageView)
        viewForBorder.addSubview(nameInPhotoLabel)
        viewForBorder.addSubview(nameLabel)
        viewForBorder.addSubview(cityLabel)
        viewForBorder.addSubview(medicCategoryLabel)
        viewForBorder.addSubview(cityIconImageView)
        viewForBorder.addSubview(medicParametrsCollection)
        viewForBorder.addSubview(infoLabel)
    }

    func setupConstraints() {
        viewForBorder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        viewForBorder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        viewForBorder.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        viewForBorder.heightAnchor.constraint(equalToConstant: 190).isActive = true
        viewForBorder.layer.borderWidth = 1
        viewForBorder.layer.borderColor = CGColor(red: 0.220, green: 0.220, blue: 0.220, alpha: 0.1)
        viewForBorder.layoutIfNeeded()
        viewForBorder.layer.cornerRadius = viewForBorder.frame.height/10
        viewForBorder.layer.masksToBounds = true
        
        photoImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: viewForBorder.leadingAnchor, constant: 8).isActive = true
        photoImageView.topAnchor.constraint(equalTo: viewForBorder.topAnchor, constant: 8).isActive = true
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.borderColor = CGColor(red: 0.220, green: 0.220, blue: 0.220, alpha: 0.1)
        photoImageView.layoutIfNeeded()
        photoImageView.layer.cornerRadius = photoImageView.frame.width/2
        photoImageView.layer.masksToBounds = true
        
        nameInPhotoLabel.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor).isActive = true
        nameInPhotoLabel.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor).isActive = true
        nameInPhotoLabel.heightAnchor.constraint(equalTo: photoImageView.heightAnchor).isActive = true
        nameInPhotoLabel.widthAnchor.constraint(equalTo: photoImageView.widthAnchor).isActive = true
        nameInPhotoLabel.layoutIfNeeded()
        nameInPhotoLabel.layer.cornerRadius = photoImageView.frame.width/2
        nameInPhotoLabel.layer.masksToBounds = true
        
        nameLabel.topAnchor.constraint(equalTo: viewForBorder.topAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: viewForBorder.trailingAnchor, constant: -8).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        medicCategoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        medicCategoryLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10).isActive = true
        medicCategoryLabel.trailingAnchor.constraint(equalTo: viewForBorder.trailingAnchor, constant: -8).isActive = true
        medicCategoryLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        cityIconImageView.topAnchor.constraint(equalTo: medicCategoryLabel.bottomAnchor).isActive = true
        cityIconImageView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10).isActive = true
        cityIconImageView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor).isActive = true
        cityIconImageView.widthAnchor.constraint(equalTo: cityIconImageView.heightAnchor).isActive = true
        
        cityLabel.topAnchor.constraint(equalTo: medicCategoryLabel.bottomAnchor).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: cityIconImageView.trailingAnchor,constant: 8).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: viewForBorder.trailingAnchor, constant: -8).isActive = true
        
        medicParametrsCollection.leadingAnchor.constraint(equalTo: viewForBorder.leadingAnchor, constant: 8).isActive = true
        medicParametrsCollection.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10).isActive = true
        medicParametrsCollection.trailingAnchor.constraint(equalTo: viewForBorder.trailingAnchor, constant: -8).isActive = true
        medicParametrsCollection.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        infoLabel.leadingAnchor.constraint(equalTo: viewForBorder.leadingAnchor, constant: 8).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: viewForBorder.trailingAnchor, constant: -8).isActive = true
        infoLabel.topAnchor.constraint(equalTo: medicParametrsCollection.bottomAnchor, constant: 8).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: viewForBorder.bottomAnchor, constant: -8).isActive = true
    }
}
