//
//  TableDataSource.swift
//  DisplayVideos
//
//  Created by Prabhdeep Singh on 19/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit

class TableDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var videos: Array<VideoModel> = []
    weak var viewController:UIViewController?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? VideoCell else {fatalError("Failed")}
        cell.configureCell(video: videos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = viewController as? VideosViewController {
            vc.coordinator?.openDetailVc(videos: videos,selectedVideoIndex: indexPath.row)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
