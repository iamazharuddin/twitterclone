//
//  TweetComposeViewController.swift
//  TwitterClone
//
//  Created by Azharuddin 1 on 02/12/23.
//

import UIKit

class TweetComposeViewController: UIViewController, UITextViewDelegate {
    private let tweetButton : UIButton = {
        let button  = UIButton(type: .system, primaryAction: UIAction(handler: { action in
            print("tweetButton clicked")
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tweet", for: .normal)
        button.layer.cornerRadius = 30
        button.backgroundColor = .twitterBlueColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    private let tweetTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 8
        textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        textView.text = "What's happening"
        textView.textColor = .gray
        textView.font = .systemFont(ofSize: 16)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tweet"
        view.addSubview(tweetButton)
        view.addSubview(tweetTextView)
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonClick))
        
        
        tweetTextView.delegate = self
    }
    
   @objc private func cancelButtonClick(){
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addConstraint()
    }
    
    private func addConstraint(){
        let tweetButtonConstraint = [
            tweetButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            tweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tweetButton.widthAnchor.constraint(equalToConstant: 120),
            tweetButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        
        let tweetTextViewConstraint = [
            tweetTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tweetTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tweetTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tweetTextView.bottomAnchor.constraint(equalTo: tweetButton.topAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(tweetButtonConstraint)
        NSLayoutConstraint.activate(tweetTextViewConstraint)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if  textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .gray
            textView.text = "What's happening"
        }
    }

}



