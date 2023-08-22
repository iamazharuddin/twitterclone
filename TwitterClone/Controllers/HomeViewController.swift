//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Azharuddin 1 on 20/08/23.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    private func configureNavigationBar(){
            let logoImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
            logoImageView.contentMode = .scaleAspectFill
           logoImageView.image = UIImage(named: "twitterLogo")
            
           let middleView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
           middleView.addSubview(logoImageView)
        
        navigationItem.titleView = middleView
        
        let profileimage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileimage, style: .plain, target: self, action: #selector(didTapProfile))
    }
    
    @objc private func didTapProfile(){
        let vc  = profileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private let timelineTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timelineTableView)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        
        configureNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapSignOut))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        handleAuthentication()
    }
    
    
    @objc private func didTapSignOut() {
        try? Auth.auth().signOut()
        handleAuthentication()
    }
    
    private func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }

        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.bounds
    }

}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeViewController : TweetTableViewCellDelegate {
    func replyButtonClicked() {
        print("replyButtonClicked")
    }
    
    func retweetButtonClicked() {
        print("retweetButtonClicked")
    }
    
    func likeButtonClicked() {
        print("likeButtonClicked")
    }
    
    func shareButtonClicked() {
        print("shareButtonClicked")
    }
    
     
}


