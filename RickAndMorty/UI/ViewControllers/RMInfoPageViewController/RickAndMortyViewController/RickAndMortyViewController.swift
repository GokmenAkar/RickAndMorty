//
//  RickAndMortyViewController.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 1.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import UIKit

class RickAndMortyViewController: UIViewController {
    static let identifier: String = "rickAndMortyViewController"
    
    @IBOutlet weak var RMWorldTableView: UITableView!
    
    var rmWorld: RMWorld?
    var rmEpisode: RMEpisode?
    
    var page: Int = 1
    var category: RMCategory = .character
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigationBar()
        getRMData()
    }
    
    private func setNavigationBar() {
        var title: String = category.rawValue.capitalized
        title.removeLast()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.topItem?.title = title
    }
    
    private func setTableView() {
        let RMInfoCell = UINib(nibName: "RMInfoTableViewCell", bundle: nil)
        RMWorldTableView.register(RMInfoCell, forCellReuseIdentifier: RMInfoTableViewCell.identifier)
    }
}

extension RickAndMortyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch category {
        case .episode:
            return rmEpisode == nil ? 0 : rmEpisode!.results.count
        default:
            return rmWorld   == nil ? 0 : rmWorld!.results.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMInfoTableViewCell.identifier) as? RMInfoTableViewCell else { return UITableViewCell() }
        
        switch category {
        case .episode:
            cell.configureCell(rmEpisode: rmEpisode!.results[indexPath.row], category: category)
        default:
            cell.configureCell(rmInfo: rmWorld!.results[indexPath.row], category: category)
        }
        
        return cell
    }
}

extension RickAndMortyViewController {
    func getRMData() {
        RMWorldService().fetchRMData(page: page, category: category) { [weak self] (success, rmData, rmEpisodeData)  in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.rmWorld   = rmData
                self.rmEpisode = rmEpisodeData
                self.RMWorldTableView.reloadData()
            }
        }
    }
}
