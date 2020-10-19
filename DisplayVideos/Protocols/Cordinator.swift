//
//  Cordinator.swift
//  DisplayVideos
//
//  Created by Prabhdeep Singh on 19/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}


