//
//  RMInfoPageTableViewCell.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 1.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import UIKit

class RMInfoTableViewCell: UITableViewCell {
    
    static let identifier: String = "rMInfoTableViewCell"
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var RMImageView: UIImageView!
    
    @IBOutlet weak var nameLabel    : UILabel!
    @IBOutlet weak var statusLabel  : UILabel!
    @IBOutlet weak var speciesLabel : UILabel!
    @IBOutlet weak var typeLabel    : UILabel!
    @IBOutlet weak var genderLabel  : UILabel!
    @IBOutlet weak var originLabel  : UILabel!
    @IBOutlet weak var episodeLabel : UILabel!
    @IBOutlet weak var airDateLabel : UILabel!
    
    @IBOutlet weak var statusView   : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(rmInfo: RMWorldResult? = nil, rmEpisode: RMEpisdoseResult? = nil, category: RMCategory) {
        switch category {
        case .episode:
            episodeLabel.text = rmEpisode?.episode  ?? "-"
            airDateLabel.text = rmEpisode?.air_date ?? "-"
            getImage(with: nil)
        default:
            guard let rmInfo = rmInfo else {return}
            nameLabel   .text  = rmInfo.name             ?? "-"
            statusLabel .text  = rmInfo.status?.rawValue ?? "-"
            speciesLabel.text  = rmInfo.species          ?? "-"
            typeLabel   .text  = rmInfo.type == "" ? "unknown" : rmInfo.type
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
}
