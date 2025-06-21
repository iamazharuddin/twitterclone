//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Azharuddin 1 on 20/08/23.
//

import UIKit
import FirebaseAuth
import Combine
class HomeViewController: UIViewController {
    let viewModel = HomeViewViewModel()
    var subscriptions : Set<AnyCancellable> = []
    private lazy var composeTweetButton : UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { action in
            print("ComposeTweetButton Clicked")
            let vc = UINavigationController(rootViewController: TweetComposeViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18)), for: .normal)
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.tintColor = .white
        button.backgroundColor = .twitterBlueColor
        return button
    }()
    
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
        view.addSubview(composeTweetButton)
        view.bringSubviewToFront(composeTweetButton)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        
        configureNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapSignOut))
        bindViews()
        addcomposeTweetButtonConstraint()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        handleAuthentication()
        viewModel.retreiveUser()
        view.backgroundColor = .systemBackground 
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
    
    func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            print(user)
            if user.isUserOnboarded == false {
                self?.completeUserOnboarding()
            }
        }
        .store(in: &subscriptions)
        
        
    }
    
    
    private func addcomposeTweetButtonConstraint(){
        let composeTweetButtonConstraint = [
            composeTweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            composeTweetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            composeTweetButton.widthAnchor.constraint(equalToConstant: 60),
            composeTweetButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        NSLayoutConstraint.activate(composeTweetButtonConstraint)
    }

        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.bounds
    }
    
    private func completeUserOnboarding(){
        let vc = ProfileDataFormViewController()
        present(vc, animated: true)
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


