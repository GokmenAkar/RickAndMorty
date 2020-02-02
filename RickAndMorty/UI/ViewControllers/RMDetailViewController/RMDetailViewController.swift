//
//  RMDetailViewController.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 2.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import UIKit

class RMDetailViewController: UIViewController {
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    var detailType: RMCategory = .character
    
    var characterImage: UIImage!
    var heroId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewCell()
    }
    
    private func setCollectionViewCell() {
        
        
        let infoNib      = UINib(nibName: "CharacterInfoCollectionViewCell", bundle: nil)
        let characterNib = UINib(nibName: "CharactersCollectionViewCell", bundle: nil)
        
        detailCollectionView.register(infoNib, forCellWithReuseIdentifier: CharacterInfoCollectionViewCell.identifier)
        detailCollectionView.register(characterNib, forCellWithReuseIdentifier: CharactersCollectionViewCell.identifier)
    }
}

extension RMDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCollectionViewCell.identifier, for: indexPath) as? CharacterInfoCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(image: characterImage, heroId: heroId)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.identifier, for: indexPath) as? CharactersCollectionViewCell else { return UICollectionViewCell() }
            //            cell.backgroundColor = indexPath.row % 2 == 0 ? .red : .blue
            return cell
        }
    }
}
    
extension RMDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width, height: 445)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
}


