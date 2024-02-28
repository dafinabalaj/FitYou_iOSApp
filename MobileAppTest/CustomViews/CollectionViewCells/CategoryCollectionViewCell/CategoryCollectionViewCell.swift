//
//  CategoryCollectionViewCell.swift
//  MobileAppTest
//
//  Created by THIS on 28.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryImageview: UIImageView!
    
    @IBOutlet weak var categoryTitlelb: UILabel!
    
    func setup(category: DishCategory){
        categoryTitlelb.text = category.name
        //kod per me setImage me url..
    }
    
}
