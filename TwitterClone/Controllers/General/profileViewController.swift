//
//  profileViewController.swift
//  TwitterClone
//
//  Created by Azharuddin 1 on 21/08/23.
//

import UIKit
import SDWebImage
import Combine
class profileViewController: UIViewController {
    private let viewModel = ProfileViewViewModel()
    private lazy var headerView = ProfileHeaderView(frame:CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 300))
    private var subscrioption : Set<AnyCancellable> = []
    private let profileTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "profile"
        
        view.addSubview(profileTableView)
        profileTableView.dataSource = self
        profileTableView.delegate = self
        profileTableView.tableHeaderView = headerView
        configureConstraint()
        bindViews()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retreiveUser()
    }
    
    
    private func configureConstraint(){
       let profileTableViewConstraint = [
        profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
        profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
       ]
        

        
        NSLayoutConstraint.activate(profileTableViewConstraint)
    }
    
    
    private func bindViews(){
        viewModel.$user.sink { twitterUser in
            guard let twitteruser = twitterUser else { return }
            self.headerView.displayNameLabel.text = twitteruser.displayName
            self.headerView.userbioLabel.text = twitteruser.bio
            self.headerView.usernameLabel.text = "@\(twitterUser?.username ?? "")"
            self.headerView.profileAvatorImageView.sd_setImage(with: URL(string: twitteruser.avatarPath))
            
        }.store(in: &subscrioption)
    }

}


extension profileViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
