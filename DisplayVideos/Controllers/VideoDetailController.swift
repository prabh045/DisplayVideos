//
//  VideoDetailController.swift
//  DisplayVideos
//
//  Created by Prabhdeep Singh on 18/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import AVFoundation

class VideoDetailController: UIViewController {
    
    //MARK: Views and Properties
    let playerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let playerView: PlayerView = {
        let view = PlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "Bunny Yo"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "I am a bunny. Eh Whats up doc!?"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let relatedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.text = "Related Videos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var videosTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(VideoCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 190
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    weak var coordinator: MainCoordinator?
    var videos: Array<VideoModel> = []
    var videosToDisplay: Array<VideoModel> = []
    var selectedVideoIndex: Int?
    var videoTableSource = TableDataSource()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupViewsData()
        // Do any additional setup after loading the view.
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(playerContainerView)
        playerContainerView.addSubview(playerView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        videosTableView.dataSource = videoTableSource
        videosTableView.delegate = videoTableSource
        videoTableSource.viewController = self
        
        view.addSubview(stackView)
        view.addSubview(relatedLabel)
        view.addSubview(videosTableView)
    }
    
    private func setupViewsData() {
        guard let index = selectedVideoIndex else {return}
        let video = videos[index]
        titleLabel.text = video.title
        descriptionLabel.text = video.description
        if let videoUrl = URL(string: video.url) {
            playerView.play(with: videoUrl)
        }
        for index in 0..<videos.count {
            if index != selectedVideoIndex {
                videosToDisplay.append(videos[index])
            }
        }
        videoTableSource.videos = videosToDisplay
        self.navigationItem.title = video.title
        videosTableView.reloadData()
    }
    
    //MARK: Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            playerContainerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            playerContainerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            playerContainerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            playerContainerView.heightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
            
            playerView.topAnchor.constraint(equalTo: playerContainerView.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: playerContainerView.heightAnchor),
            playerView.widthAnchor.constraint(equalTo: playerContainerView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: playerContainerView.bottomAnchor,constant: 0),
            stackView.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor,constant: -10),
            
            relatedLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 10),
            relatedLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            relatedLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            videosTableView.topAnchor.constraint(equalTo: relatedLabel.bottomAnchor,constant: 10),
            videosTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            videosTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            videosTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

