//
//  MedicModel.swift
//  MakingConstraintsN3
//
//  Created by Kavaleuski Ivan on 15/07/2022.
//

import Foundation
import UIKit

struct MedicModel {
    let photo: UIImage?
    let name: String
    let surname: String
    let medicCategory: MedicCategory
    let city: String
    let medicParametrs: [MedicParametrs]
    let info: String
}

enum MedicCategory: String, CaseIterable {
    case familyDoctor = "Семейный доктор"
    case pediatrician = "Педиатр"
    case endocrinologist = "Эндокринолог"
}

enum MedicParametrs: String,CaseIterable {
    case kidsZeroThree = "Дети 0 - 3 г."
    case kidsZeroSixteen = "Дети 0 - 16 л."
    case kidsSevenSixteen = "Дети 7 - 16 л. "
    case adults = "Взрослые"
    case covid = "Covid-19"
}
