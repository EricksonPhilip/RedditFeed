//
//  RedditFeedCell.swift
//  RedditFeed
//
//  Created by Erickson Philip Rathina Pandi on 9/11/21.
//

import UIKit
import SDWebImage

protocol InteractiveLink: NSObject {
    func linkCliked(_ sender: UITapGestureRecognizer)
}

class RedditFeedCell: UITableViewCell {
    
    // Cell Identifier
    static let cellID = "RedditFeedCell"
    
    // Main vertical stackview
    lazy var mainVStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    // To display post title
    lazy var postTitleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 24)
        view.textColor = UIColor(named: "titleColor")
        view.text = "[-Title-]"
        view.numberOfLines = 0
        return view
    }()
    
    // To display post sub title
    lazy var postSubTitleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .darkGray
        view.font = UIFont.italicSystemFont(ofSize: 17)
        view.text = "[ - user - Name - ]"
        return view
    }()
    
    // To display post image (thumbnail)
    lazy var postImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "")
        view.clipsToBounds = true
        return view
    }()
    
    // To display post link
    lazy var linkLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .lightGray
        view.numberOfLines = 0
        view.isHidden = true
        return view
    }()
    
    // To display non-interative view (number of comments and up and votes)
    lazy var nonInteractiveStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    
    // To view number of comments
    lazy var commentView: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect.zero
        button.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: "Commment_ico") {
            button.applyStyle(image: image, title: "Comment")
        }
        
        button.ButtonWithTrailingImage()
        button.setTitleColor(UIColor(named: "titleColor"), for: .normal)
        return button
    }()
    
    // To see UpVote count
    lazy var upScoreView: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect.zero
        button.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: "upVote") {
            button.applyStyle(image: image, title: "0")
        }
        button.ButtonWithTrailingImage()
        button.setTitleColor(UIColor(named: "titleColor"), for: .normal)
        return button
    }()
    
    // To see downVote count
    lazy var downScoreView: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect.zero
        button.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: "downVote") {
            button.applyStyle(image: image, title: "0")
        }
        button.ButtonWithTrailingImage()
        button.setTitleColor(UIColor(named: "titleColor"), for: .normal)
        return button
    }()
    
    // To display divider
    lazy var divider: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "dividerColor")
        return view
    }()
    
    // Image dynamic height and width
    var imageHeightConstraints: NSLayoutConstraint?
    var imageWidthConstraints: NSLayoutConstraint?
    weak var delegate: InteractiveLink?
    
    // Construct main stackview
    func addMainStackView() {
        self.contentView.addSubview(mainVStackView)
        let topAnchor = mainVStackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10)
        topAnchor.priority = .init(999)
        topAnchor.isActive = true
        mainVStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        mainVStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        let bottomAnch = mainVStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10)
        bottomAnch.priority = .init(999)
        bottomAnch.isActive = true
    }
    
    // Create Title
    func addTitleDetails(){
        mainVStackView.addArrangedSubview(postTitleLabel)
        mainVStackView.addArrangedSubview(postSubTitleLabel)
    }
    
    // Create Content
    func addContentDetails() {
        mainVStackView.addArrangedSubview(linkLabel)
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.handleLinkTap(_:)))
        tap.numberOfTapsRequired = 1
        linkLabel.addGestureRecognizer(tap)
    }
    
    // Create post image
    func addPostImage(){
        mainVStackView.addArrangedSubview(postImage)
        imageHeightConstraints = postImage.heightAnchor.constraint(equalToConstant: 100)
        imageHeightConstraints!.isActive = true
        imageWidthConstraints = postImage.widthAnchor.constraint(equalToConstant: 100)
        imageWidthConstraints!.isActive = true
    }
    
    // Create divider
    func addBottomDivider(){
        mainVStackView.addArrangedSubview(divider)
        divider.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
    }
    
    func addInteractiveView(){
        mainVStackView.addArrangedSubview(nonInteractiveStackView)
        nonInteractiveStackView.addArrangedSubview(commentView)
        nonInteractiveStackView.addArrangedSubview(upScoreView)
        nonInteractiveStackView.addArrangedSubview(downScoreView)
    }
    
    // Main Setup
    func setUp(){
        addMainStackView()
        addTitleDetails()
        addContentDetails()
        addPostImage()
        addInteractiveView()
        addBottomDivider()
    }
    
    // Configure cell while run time
    func config(model: FeedDataChildrenData) {
        postTitleLabel.text = model.title
        postSubTitleLabel.text = model.subRedditPrefix
        commentView.setTitle(String(model.comments), for: .normal)
        upScoreView.setTitle(String(model.ups), for: .normal)
        downScoreView.setTitle(String(model.downs), for: .normal)
        
        if model.postHint != "" {
            if model.postHint == "image" {
                postImage.sd_setImage(with: URL(string: model.thumbnail),
                                           placeholderImage: UIImage(named: "DefaultProfileImage"))
                linkLabel.isHidden = true
                imageHeightConstraints?.constant = CGFloat(model.thumbnailHieght)
                imageWidthConstraints?.constant = CGFloat(model.thumbnailWidth)
            } else {
                linkLabel.isHidden = false
                linkLabel.text = model.imageOrLink
                imageHeightConstraints?.constant = .zero
                imageWidthConstraints?.constant = .zero
            }
        }
    }
    
    // Initilaization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    // Handle link
    @objc func handleLinkTap(_ sender: UITapGestureRecognizer? = nil) {
        if let tapGestSender = sender {
            delegate?.linkCliked(tapGestSender)
        }
    }
}
