//
//  VideosViewController.swift
//  DisplayVideos
//
//  Created by Prabhdeep Singh on 17/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit

class VideosViewController: UIViewController {
    
    //MARK: Properties
    var videoTableSource = TableDataSource()
    
    lazy var videosTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(VideoCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 190
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var videos: Array<VideoModel> = []
    weak var coordinator: MainCoordinator?
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(videosTableView)
        self.navigationItem.title = "Videos"
        videosTableView.dataSource = videoTableSource
        videosTableView.delegate = videoTableSource
        videoTableSource.viewController = self
        setupConstraints()
        fetchVideos()
    }
    
    //MARK: Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            videosTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videosTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            videosTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            videosTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    private func fetchVideos() {
        VideoService.fetchVideos { [weak self] (videos, error) in
            
            if let error = error {
                print("Error fetching Videos \(error.localizedDescription)")
                return
            }
            self?.videos = videos ?? []
            self?.videoTableSource.videos = videos ?? []
            DispatchQueue.main.async {
                self?.videosTableView.reloadData()
            }
        }
    }    
}
