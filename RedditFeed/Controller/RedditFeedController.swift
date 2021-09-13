//
//  ViewController.swift
//  RedditFeed
//
//  Created by Erickson Philip Rathina Pandi on 9/9/21.
//

import UIKit

class RedditFeedController: UIViewController {
    
    var viewModel = RedditViewModel()
    
    // To display Feed list
    lazy var feedTableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 200
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.allowsSelection = false
        view.tableFooterView = UIView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reddit Feeds"
        setUp()
        loadFeeds()
        setFeedDataSource()
    }
    
    // Pull feeds from API and reload tableview
    func loadFeeds() {
        viewModel.getRedditFeeds() { isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self.feedTableView.reloadData()
                }
            }
        }
    }
    
    // Main setup
    func setUp() {
        view.addSubview(feedTableView)
        feedTableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        feedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        feedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        feedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        registerTableViewCell()
    }
    
    func registerTableViewCell() {
        feedTableView.register(RedditFeedCell.self,
                               forCellReuseIdentifier: RedditFeedCell.cellID)
    }
    
    func setFeedDataSource() {
        feedTableView.dataSource = self
        feedTableView.delegate = self
    }

}

// Tableview datasource and delegate
extension RedditFeedController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.redditFeedCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RedditFeedCell.cellID,
                                                       for: indexPath) as? RedditFeedCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        if let model = viewModel.model?[indexPath.row] {
            cell.config(model: model.data)
        }
        
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            feedTableView.showSpinnerView()
            
            viewModel.getRedditFeeds(isLoadMore: true) { isSuccess in
                if isSuccess {
                    DispatchQueue.main.async { [self] in
                        feedTableView.hideSpinnerView()
                        feedTableView.reloadData()
                    }
                }
            }
        }
    }

}

// Post Interactive link
extension RedditFeedController: InteractiveLink {
    func linkCliked(_ sender: UITapGestureRecognizer) {
        print("Clicked")
    }
}
