//
//  RMInfoPageTableViewCell.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 1.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import UIKit
import Hero

class RMInfoTableViewCell: UITableViewCell {
    
    static let identifier: String = "rMInfoTableViewCell"
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var RMImageView: UIImageView!
    
    @IBOutlet weak var nameLabel     : UILabel!
    @IBOutlet weak var statusLabel   : UILabel!
    @IBOutlet weak var speciesLabel  : UILabel!
    @IBOutlet weak var typeLabel     : UILabel!
    @IBOutlet weak var genderLabel   : UILabel!
    @IBOutlet weak var originLabel   : UILabel!
    @IBOutlet weak var episodeLabel  : UILabel!
    @IBOutlet weak var airDateLabel  : UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!
    
    @IBOutlet weak var statusView   : UIView!
    @IBOutlet weak var shadowView   : UIView!

    @IBOutlet weak var nameStackView     : UIStackView!
    @IBOutlet weak var episodeStackView  : UIStackView!
    @IBOutlet weak var airDateStackView  : UIStackView!
    @IBOutlet weak var statusStackView   : UIStackView!
    @IBOutlet weak var speciesStackView  : UIStackView!
    @IBOutlet weak var typeStackView     : UIStackView!
    @IBOutlet weak var genderStackView   : UIStackView!
    @IBOutlet weak var originStackView   : UIStackView!
    @IBOutlet weak var dimensionStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(rmInfo: RMWorldResult? = nil, rmEpisode: RMEpisdoseResult? = nil, category: RMCategory) {
        switch category {
        case .episode:
            guard let rmEpisode = rmEpisode else {return}
            RMImageView.hero.id = category.rawValue + rmEpisode.id.description
//            shadowView.hero.id  = category.rawValue + rmEpisode.id.description
            
            showStackViews(sv: [episodeStackView, airDateStackView])
            episodeLabel.text = rmEpisode.episode
            airDateLabel.text = rmEpisode.air_date
            getImage(with: nil)
        case .location:
            guard let rmInfo = rmInfo else {return}
            RMImageView.hero.id = category.rawValue + rmInfo.id!.description
//            shadowView.hero.id  = category.rawValue + rmInfo.id!.description

            showStackViews(sv: [nameStackView, typeStackView, dimensionStackView])
            nameLabel   .text   = rmInfo.name      ?? "-"
            typeLabel   .text   = rmInfo.type      ?? "-"
            dimensionLabel.text = rmInfo.dimension ?? "-"
            
            getImage(with: rmInfo.image)
        default:
            guard let rmInfo = rmInfo else {return}
            RMImageView.hero.id = category.rawValue + rmInfo.id!.description
//            shadowView.hero.id  = category.rawValue + rmInfo.id!.description

            showStackViews(sv: [nameStackView, statusStackView, speciesStackView, typeStackView, genderStackView, originStackView])
            
            nameLabel   .text  = rmInfo.name             ?? "-"
            statusLabel .text  = rmInfo.status?.rawValue ?? "-"
            speciesLabel.text  = rmInfo.species          ?? "-"
            typeLabel   .text  = rmInfo.type             ?? "-"
            genderLabel .text  = rmInfo.gender?.rawValue ?? "-"
            originLabel .text  = rmInfo.origin?.name     ?? "-"
            
            switch rmInfo.status {
            case .alive:
                statusView.backgroundColor = .systemGreen
            case .dead:
                statusView.backgroundColor = .systemRed
            case .unknown:
                statusView.backgroundColor = .systemOrange
            default:
                statusView.isHidden = true
            }
            
            getImage(with: rmInfo.image)
        }
        

    }
    
    func showStackViews(sv: [UIStackView]) {
        sv.forEach { $0.isHidden = false }
    }
    
    func getImage(with URLString: String?) {
        guard URLString != nil else {
            activityIndicator.stopAnimating()
            RMImageView.image = UIImage(named: "ic_placeholder")
            return
        }
        RMImageView.getImage(url: URLString!) { (finished) in
            DispatchQueue.main.async {
                finished ? self.activityIndicator.stopAnimating() : self.activityIndicator.startAnimating()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateSize(isCellSelected: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animateSize(isCellSelected: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        animateSize(isCellSelected: false)
    }
    
    func animateSize(isCellSelected: Bool) {
        if isCellSelected {
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                            self.RMImageView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                                .translatedBy(x: self.contentView.frame.midX - self.RMImageView.frame.size.width*1.25/2,
                                              y: self.contentView.frame.midY - self.RMImageView.frame.size.height*1.25/2)
                            self.shadowView .transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                                .translatedBy(x: self.contentView.frame.midX - self.shadowView.frame.size.width*1.25/2,
                                              y: self.contentView.frame.midY - self.shadowView.frame.size.height*1.25/2)
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                            self.RMImageView.transform = .identity
                            self.shadowView .transform = .identity
            }, completion: nil)
        }
    }
}
