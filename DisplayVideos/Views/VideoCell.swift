//
//  MovieCell.swift
//  DisplayVideos
//
//  Created by Prabhdeep Singh on 17/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import Kingfisher

class VideoCell: UITableViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        print("configure")
        return view
    }()
    
    let thumbNailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "avengers")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(containerView)
        containerView.addSubview(thumbNailImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        containerView.addSubview(stackView)
        setupConstarints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(video: VideoModel) {
        titleLabel.text = video.title
        descriptionLabel.text = video.description
        guard let thumbUrl = URL(string: video.thumb) else {return}
        thumbNailImageView.kf.setImage(with: thumbUrl)
    }
    
    private func setupConstarints() {
        //Container View
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            containerView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
            
        ])
        
        
        //Image View
        NSLayoutConstraint.activate([
            thumbNailImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 10),
            thumbNailImageView.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 10),
            thumbNailImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            thumbNailImageView.widthAnchor.constraint(equalToConstant: 150),
            thumbNailImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        
        //stack view
        NSLayoutConstraint.activate([
//            stackView.centerXAnchor.constraint(equalTo: thumbNailImageView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 10),
            stackView.leadingAnchor.constraint(equalTo: thumbNailImageView.trailingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -10)
        ])
        
        
    }
    
}
