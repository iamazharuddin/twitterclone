//
//  TweetTableViewCell.swift
//  TwitterClone
//
//  Created by Azharuddin 1 on 20/08/23.
//

import UIKit

protocol TweetTableViewCellDelegate: AnyObject {
    func replyButtonClicked()
    func retweetButtonClicked()
    func likeButtonClicked()
    func shareButtonClicked()
}

class TweetTableViewCell: UITableViewCell {
    
    weak var delegate: TweetTableViewCellDelegate?
    
    static let identifier = "TweetTableViewCell"
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let displayName: UILabel = {
        let label = UILabel()
        label.text = "Azhar"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "@iamazharuddin"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tweetTextLabel: UILabel = {
        let label = UILabel()
        label.text = "This is mockup tweet. It is going to take multiple lines. But I believe I need to add some more text but this is enough. This is mockup tweet. It is going to take multiple lines. But I believe I need to add some more text but this is enough."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let replyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        button.tintColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        button.tintColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(displayName)
        contentView.addSubview(userLabel)
        contentView.addSubview(tweetTextLabel)
        
        contentView.addSubview(replyButton)
        contentView.addSubview(retweetButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(shareButton)
        
        configureConstraints()
        setupButtonActions()
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonActions() {
        replyButton.addTarget(self, action: #selector(replyButtonClicked), for: .touchUpInside)
        retweetButton.addTarget(self, action: #selector(retweetButtonClicked), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeButtonClicked),  for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonClicked), for: .touchUpInside)
    }
    
    @objc private func replyButtonClicked() {
        delegate?.replyButtonClicked()
    }
    
    @objc private func retweetButtonClicked() {
        delegate?.retweetButtonClicked()
    }
    
    @objc private func likeButtonClicked() {
        delegate?.likeButtonClicked()
    }
    
    @objc private func shareButtonClicked() {
        delegate?.shareButtonClicked()
    }
    
    private func configureConstraints() {
        // Avatar Image View Constraints
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        // Display Name Label Constraints
        NSLayoutConstraint.activate([
            displayName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            displayName.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
        ])
        
        // User Label Constraints
        NSLayoutConstraint.activate([
            userLabel.leadingAnchor.constraint(equalTo: displayName.trailingAnchor, constant: 10),
            userLabel.centerYAnchor.constraint(equalTo: displayName.centerYAnchor)
        ])
        
        // Tweet Text Label Constraints
        NSLayoutConstraint.activate([
            tweetTextLabel.leadingAnchor.constraint(equalTo: displayName.leadingAnchor),
            tweetTextLabel.topAnchor.constraint(equalTo: displayName.bottomAnchor, constant: 10),
            tweetTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        // Reply Button Constraints
        NSLayoutConstraint.activate([
            replyButton.leadingAnchor.constraint(equalTo: tweetTextLabel.leadingAnchor),
            replyButton.topAnchor.constraint(equalTo: tweetTextLabel.bottomAnchor, constant: 16),
            replyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        // Retweet Button Constraints
        NSLayoutConstraint.activate([
            retweetButton.leadingAnchor.constraint(equalTo: replyButton.trailingAnchor, constant: 24),
            retweetButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)
        ])
        
        // Like Button Constraints
        NSLayoutConstraint.activate([
            likeButton.leadingAnchor.constraint(equalTo: retweetButton.trailingAnchor, constant: 24),
            likeButton.centerYAnchor.constraint(equalTo: retweetButton.centerYAnchor)
        ])
        
        // Share Button Constraints
        NSLayoutConstraint.activate([
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 24),
            shareButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor)
        ])
    }
}
