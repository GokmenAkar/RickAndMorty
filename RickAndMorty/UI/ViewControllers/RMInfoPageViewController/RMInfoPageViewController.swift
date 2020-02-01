//
//  ViewController.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 1.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import UIKit
class RMInfoPageViewController: UIPageViewController {

    var rmInfoViewController  : RickAndMortyViewController!
    var locationViewController: RickAndMortyViewController!
    var episodeViewController : RickAndMortyViewController!
    
    var orderedViewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate   = self
        dataSource = self
        
        viewControllersSetup()
        
        setViewControllers([orderedViewControllers.first!], direction: .forward, animated: true, completion: nil)
    }
    private func getRMViewController() -> RickAndMortyViewController {
        return UIStoryboard(name: "RMInfo", bundle: nil).instantiateViewController(identifier: RickAndMortyViewController.identifier)
    }
    
    private func viewControllersSetup() {
        rmInfoViewController   = getRMViewController()
        locationViewController = getRMViewController()
        episodeViewController  = getRMViewController()
        
        rmInfoViewController  .category = .character
        locationViewController.category = .location
        episodeViewController .category = .episode
        
        orderedViewControllers.append(UINavigationController(rootViewController: rmInfoViewController))
        orderedViewControllers.append(UINavigationController(rootViewController: locationViewController))
        orderedViewControllers.append(UINavigationController(rootViewController: episodeViewController))
    }
}

extension RMInfoPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex != orderedViewControllers.count else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}

extension RMInfoPageViewController: UIPageViewControllerDelegate {
    
}

