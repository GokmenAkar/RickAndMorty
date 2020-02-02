//
//  UIViewController+Extensions.swift
//  RickAndMorty
//
//  Created by GÖKMEN AKAR on 2.02.2020.
//  Copyright © 2020 GÖKMEN AKAR. All rights reserved.
//

import UIKit

extension UIViewController {
    func getViewController(storyboard: String, storyboardId: String) -> UIViewController {
        let vc = UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: storyboardId)
        return vc
    }
}
