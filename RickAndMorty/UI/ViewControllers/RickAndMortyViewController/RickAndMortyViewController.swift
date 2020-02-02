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
    
    var rmWorld  : RMWorld?
    var rmEpisode: RMEpisode?
    
    var category: RMCategory = .character
    var page: Int = 1
    
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
        navigationController?.navigationBar.topItem?.title = title
        
        navigationController?.hero.isEnabled = true 
    }
    
    private func setTableView() {
        let RMInfoCell = UINib(nibName: "RMInfoTableViewCell", bundle: nil)
        RMWorldTableView.register(RMInfoCell, forCellReuseIdentifier: RMInfoTableViewCell.identifier)
    }
    
    private func getMoreRMData(current count: Int, indexPath: IndexPath) {
        let lastElement = count - 1
        if indexPath.row == lastElement {
            page += 1
            getRMData()
        }
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
            if let count = rmEpisode?.results.count, let infoCount = rmEpisode?.info?.count, count > 1, count < infoCount {
                getMoreRMData(current: count, indexPath: indexPath)
            }
            cell.configureCell(rmEpisode: rmEpisode!.results[indexPath.row], category: category)
        default:
            if let count = rmWorld?.results.count, let infoCount = rmWorld?.info?.count, count > 1, count < infoCount {
                getMoreRMData(current: count, indexPath: indexPath)
            }
            cell.configureCell(rmInfo: rmWorld!.results[indexPath.row], category: category)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RMInfoTableViewCell else { return }
        if let detailViewController = getViewController(storyboard: "RMInfo", storyboardId: "rMDetailViewController") as? RMDetailViewController {
            detailViewController.characterImage = cell.RMImageView.image
            let id: Int = category == .episode ? rmEpisode!.results[indexPath.row].id : rmWorld!.results[indexPath.row].id!
            detailViewController.heroId = category.rawValue + id.description
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension RickAndMortyViewController {
    func getRMData() {
        RMWorldService().fetchRMData(page: page, category: category) { [weak self] (success, rmData, rmEpisodeData)  in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if self.rmWorld != nil {
                    self.rmWorld!.results += rmData!.results
                    self.RMWorldTableView.reloadData()
                    return
                }
                
                if self.rmEpisode != nil {
                    self.rmEpisode!.results += rmEpisodeData!.results
                    self.RMWorldTableView.reloadData()
                    return
                }
                
                self.rmWorld   = rmData
                self.rmEpisode = rmEpisodeData
                self.RMWorldTableView.reloadData()
            }
        }
    }
}
