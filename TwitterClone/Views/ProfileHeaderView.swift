//
//  ProfileHeaderView.swift
//  TwitterClone
//
//  Created by Azharuddin 1 on 21/08/23.
//

import UIKit

class ProfileHeaderView: UIView {
    let joinDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Joined May 2022"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let joiningDateImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userbioLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "iOS Developer"
        label.numberOfLines = 3
        label.textColor = .label
        return label
    }()
    
   let usernameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "iamazharuddin"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    let displayNameLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Azhar"
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    let profileAvatorImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .yellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "header")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        addSubview(profileAvatorImageView)
        addSubview(displayNameLabel)
        addSubview(usernameLabel)
        addSubview(userbioLabel)
        addSubview(joiningDateImageView)
        addSubview(joinDateLabel)
        configureConstraint()
    }
    
    required init(coder:NSCoder) {
        fatalError()
    }
    
    private func configureConstraint(){
        let profileImageViewConstarint = [
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        let profileAvatorImageViewConstraint = [
            profileAvatorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatorImageView.centerYAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            profileAvatorImageView.heightAnchor.constraint(equalToConstant: 80),
            profileAvatorImageView.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let displayNameLabelConstraint = [
            displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatorImageView.leadingAnchor),
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatorImageView.bottomAnchor, constant: 20)
        ]
        
        let usernameLabelConstraint = [
            usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor, constant: 0),
            usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5)
        ]
        
        let userbioLabelConstraint = [
            userbioLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            userbioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            userbioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5)
        ]
        
        let joiningDateImageViewConstraint = [
            joiningDateImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
                
            joiningDateImageView.topAnchor.constraint(equalTo: userbioLabel.bottomAnchor, constant: 5)
        ]
        
        let joingDateLabelConstarint = [
            joinDateLabel.leadingAnchor.constraint(equalTo: joiningDateImageView.trailingAnchor, constant: 2),
            joinDateLabel.bottomAnchor.constraint(equalTo: joiningDateImageView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(profileImageViewConstarint)
        NSLayoutConstraint.activate(profileAvatorImageViewConstraint)
        NSLayoutConstraint.activate(displayNameLabelConstraint)
        NSLayoutConstraint.activate(usernameLabelConstraint)
        NSLayoutConstraint.activate(userbioLabelConstraint)
        NSLayoutConstraint.activate(joiningDateImageViewConstraint)
        NSLayoutConstraint.activate(joingDateLabelConstarint)
    }

}
