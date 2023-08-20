//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Azharuddin 1 on 20/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    
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


