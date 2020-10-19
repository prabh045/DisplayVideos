//
//  MainCoordinator.swift
//  DisplayVideos
//
//  Created by Prabhdeep Singh on 19/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let vc = ViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func openVideosVc(){
        let vc = VideosViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openDetailVc(videos: [VideoModel], selectedVideoIndex: Int) {
        let vc = VideoDetailController()
        vc.coordinator = self
        vc.videos = videos
        vc.selectedVideoIndex = selectedVideoIndex
        navigationController.pushViewController(vc, animated: true)
    }
}
