//
//  CharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 2.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import UIKit

class CharacterInfoCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "characterInfoCollectionViewCell"
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configureCell(image: UIImage, heroId: String) {
        characterImageView.hero.id = heroId
        characterImageView.image = image
    }

}
