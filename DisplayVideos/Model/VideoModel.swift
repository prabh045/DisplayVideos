//
//  VideoModel.swift
//  DisplayVideos
//
//  Created by Prabhdeep Singh on 17/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

struct VideoModel: Codable {
    let description: String
    let id: String
    let thumb: String
    let title: String
    let url: String
}
