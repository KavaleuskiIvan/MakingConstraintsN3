//
//  ViewController.swift
//  MakingConstraintsN3
//
//  Created by Kavaleuski Ivan on 15/07/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let medicParametrsCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return medicParametrsCollection
    }()
    
    let tableView = UITableView()
    
    let medics: [MedicModel] = [MedicModel(photo: nil,
                                           name: "Анастасия",
                                           surname: "Городищенко",
                                           medicCategory: .familyDoctor,
                                           city: "Ровно",
                                           medicParametrs: [.kidsZeroSixteen,.adults,.covid],
                                           info: "Доктор специализирующийся на семейной медицине"),
                                MedicModel(photo: nil,
                                           name: "Галина",
                                           surname: "Дмитренко",
                                           medicCategory: .pediatrician,
                                           city: "Каменец-Подольский",
                                           medicParametrs: [.kidsZeroThree,.adults],
                                           info: "Проводить первичный лечащий патронаж новорожденного"),
                                MedicModel(photo: UIImage(named: "default-user-image"),
                                           name: "Инна",
                                           surname: "Омельчук",
                                           medicCategory: .familyDoctor,
                                           city: "Одесса",
                                           medicParametrs: [.kidsZeroSixteen,.adults,.covid],
                                           info: "Ведет прием детей с рождения"),
                                MedicModel(photo: nil,
                                           name: "Ольга",
                                           surname: "Латишева",
                                           medicCategory: .familyDoctor,
                                           city: "Днепр",
                                           medicParametrs: [.adults,.covid],
                                           info: "Диагностика и лечение болезные взрослых, консультации по поводу вакцинации/ Диагностика и лечение болезные взрослых, консультации по поводу вакцинации"),
                                MedicModel(photo: nil,
                                           name: "Павло",
                                           surname: "Швець",
                                           medicCategory: .familyDoctor,
                                           city: "Львов",
                                           medicParametrs: [.kidsSevenSixteen,.adults,.covid],
                                           info: "Совершает прием пациентов амбулаторно")]
    
    lazy var filteredMedics: [MedicModel] = medics
    
    var currentMedicCategory: MedicCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Медик Онлайн"
        
        setupCollectionView()
        setupTableView()
        
        setupLeftBarButtonItem()
    }
    
    func setupLeftBarButtonItem() {
        let image = UIImage(systemName: "arrow.left")
        let button = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(leftBarButtonItemPressed))
        button.tintColor = .red
        navigationItem.leftBarButtonItem = button
    }
    
    @objc func leftBarButtonItemPressed() {
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        view.addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.height/15).isActive = true
        layout.itemSize = CGSize(width: view.frame.width/2.5, height: view.frame.height/16)

        
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(MedicCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "MedicCategoryCollectionViewCell")
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MedicsTableViewCell.self, forCellReuseIdentifier: MedicsTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MedicCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedicCategoryCollectionViewCell", for: indexPath) as? MedicCategoryCollectionViewCell {
            cell.setupName(title: MedicCategory.allCases[indexPath.row].rawValue)
            if currentMedicCategory == MedicCategory.allCases[indexPath.row] {
                cell.setLabelSelected()
            } else {
                cell.setLabelUnSelected()
            }
            return cell
        }
        fatalError()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMedicCategory = MedicCategory.allCases[indexPath.row]
        filteredMedics = []
        if selectedMedicCategory == currentMedicCategory {
            currentMedicCategory = nil
        } else {
            currentMedicCategory = selectedMedicCategory
        }
        for medic in medics {
            if currentMedicCategory == nil {
                filteredMedics.append(medic)
            } else {
                if medic.medicCategory == currentMedicCategory {
                    filteredMedics.append(medic)
                }
            }
        }
        collectionView.reloadData()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMedics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MedicsTableViewCell.reuseIdentifier, for: indexPath) as? MedicsTableViewCell {
            cell.selectionStyle = .none
            cell.setupTableViewCell(medic: filteredMedics[indexPath.row])
            return cell
        }
        fatalError()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220
    }
}
