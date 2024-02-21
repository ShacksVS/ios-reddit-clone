//
//  HideBarButton.swift
//  Reddit
//
//  Created by Viktor Sovyak on 2/18/24.
//

import UIKit


extension UIViewController{
    func actionOnBar(isHidden: Bool) {
        guard let navigationController = self.navigationController else {
            return
        }
        
        navigationController.isNavigationBarHidden = isHidden
    }
}

