//
//  DetailCommunityViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/23.
//

import UIKit
import SwiftUI
import SafeAreaBrush

class DetailBoardViewController: UIViewController {
    
    private lazy var navigationBar: UINavigationBar = {
        let naviBar = UINavigationBar()
        naviBar.translatesAutoresizingMaskIntoConstraints = false
        naviBar.tintColor = .white
        naviBar.backgroundColor = UIColor(named:"main")
        naviBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        naviBar.shadowImage = UIImage()
        let naviTitleItem = UINavigationItem(title: "")
        let customBarButtonItem = UIBarButtonItem(customView: self.naviTitleLabel)
        
        naviTitleItem.leftBarButtonItems = [backButton, customBarButtonItem]
        naviTitleItem.rightBarButtonItem = naviMenuButton
        
        naviBar.items = [naviTitleItem]
        return naviBar
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let backImage = UIImage(named: "backButton")!
        let button = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        return button
    }()
    
    private lazy var naviTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "학교 게시판"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var naviMenuButton: UIBarButtonItem = {
        let menuImage  = UIImage(named: "menuIcon")!
        let button = UIBarButtonItem(image: menuImage,  style: .plain, target: self, action: #selector(menuButtonTapped))
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.addSubview(profileHStackView)
        view.addSubview(profileLineView)
        view.addSubview(titleLabel)
        view.addSubview(titleLineView)
        view.addSubview(contextTextView)
        view.addSubview(photosView)
        view.addSubview(imageLineView)
        view.addSubview(commentCountView)
        view.addSubview(recommandCountView)
        view.addSubview(viewsCountView)
        view.addSubview(countLineView)
        view.addSubview(commentCollectionView)
        view.addSubview(commentView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var profileHStackView: UIStackView = {
        var stView = UIStackView()
        stView.addArrangedSubview(profileImageView)
        stView.addArrangedSubview(profileVStackView)
        stView.axis = .horizontal
        stView.distribution = .fill
        stView.spacing = 10
        stView.alignment = .leading
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "launchScreenTopIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var profileVStackView: UIStackView = {
        let stView = UIStackView()
        stView.addArrangedSubview(nicknameLabel)
        stView.addArrangedSubview(timeLabel)
        stView.axis = .vertical
        stView.distribution = .fillEqually
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "익명"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "몇시간 전"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileLineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lineGray")!.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목 자리입니다만"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lineGray")!.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var textViewStackView: UIStackView = {
        let stView = UIStackView()
        stView.addArrangedSubview(contextTextView)
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var contextTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 13)
        textView.backgroundColor = UIColor(named: "backgroundColor")
        textView.text = "hello\nooo"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var photosView: UIView = {
        let view = UIView()
        // collection view 넣거나
        // uiview 이미지 갯수만큼 넣고 constraint 조정
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageLineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lineGray")!.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recommandCountView: UIStackView = {
        let stView = UIStackView()
        stView.addArrangedSubview(recommandImageView)
        stView.addArrangedSubview(recommandLabel)
        stView.spacing = 5
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var recommandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultLikeIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var recommandLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 3"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var commentCountView: UIStackView = {
        var stView = UIStackView()
        stView.addArrangedSubview(commentImageView)
        stView.addArrangedSubview(commentLabel)
        stView.spacing = 5
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var commentImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "defaultCommentIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var commentLabel: UILabel = {
        var label = UILabel()
        label.text = "댓글 4"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewsCountView: UIStackView = {
        let stView = UIStackView()
        stView.addArrangedSubview(viewsImageView)
        stView.addArrangedSubview(viewsLabel)
        stView.spacing = 5
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var viewsImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "defaultInquiryIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var viewsLabel: UILabel = {
        var label = UILabel()
        label.text = "조회 120"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countLineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lineGray")!.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var commentView: UIStackView = {
        let stView = UIStackView()
        stView.backgroundColor = .yellow
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var commentCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        //        collectionView.register(CommentHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CommentHeader")
        collectionView.register(UINib(nibName: "CommentHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CommentHeader")
        
        collectionView.register(UINib(nibName: "CommentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CommentCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blue
        return collectionView
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.addSubview(commentLineView)
        view.addSubview(uploadCommentView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var commentLineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lineGray")!.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var uploadCommentView: UIView = {
        let view = UIView()
        view.addSubview(commentAnonymousLabel)
        view.addSubview(commentAnonymousButton)
        view.addSubview(commentTextField)
        view.addSubview(commentUploadButton)
        print("border")
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        print("back")
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var commentAnonymousLabel: UILabel = {
        let label = UILabel()
        label.text = "익명"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "darkGray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var commentAnonymousButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "댓글을 입력해주세요."
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.isEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var commentUploadButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "uploadCircleIcon"), for: .normal)
        //            button.addTarget(self, action: #selector(thumbsUpButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var images: [UIImage] = []
    var photos: [URL] = []
    var comments: [CommentContent] = []
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutoLayout()
        
        DetailBoardViewModel.shared.onBoardComplete = { result in
            self.setBoard(board: result)
        }
        
        DetailBoardViewModel.shared.onCommentsResult = { result in
            print("comment result ", result)
            print("comment result.data.content ", result.data.content)
            self.setComment(comment: result)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.updateContentSize()
    }
    
    private func configure() {
        view.backgroundColor = .white
        fillSafeArea(position: .top, color: UIColor(named: "main")!, gradient: false)
        view.addSubview(navigationBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(bottomView)
        view.addSubview(uploadCommentView)
        commentTextField.delegate = self
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
//        flowLayout.estimatedItemSize = CGSize(width: commentCollectionView.bounds.width, height: 100)
        commentCollectionView.collectionViewLayout = flowLayout
        commentCollectionView.backgroundColor = .red
    }
    
    private func setComment(comment: Comment) {
        self.comments = comment.data.content
        commentCollectionView.reloadData()
        commentCollectionView.isHidden = comments.isEmpty
        
        print(commentCollectionView.isHidden) // Check the output in the console
        print(commentCollectionView.frame) // Check the frame in the console
        let newHeight = calculateTotalHeight()
        commentCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(newHeight)).isActive = true
        print("dd ", commentCollectionView.frame) // Check the frame in the console
        
        commentCollectionView.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    func calculateTotalHeight() -> CGFloat {
        var totalHeight: CGFloat = 0
        
        // Add 100 for each cell
        for comment in comments {
            let headerHeight = calculateCommentHeight(text: comment.context, width: commentCollectionView.bounds.width) // Implement your logic to calculate cell height
            totalHeight += headerHeight + 100
            print(totalHeight)
            
            if let childComments = comment.childComments {
                for childComment in childComments {
                    let cellHeight = calculateCommentHeight(text: childComment.context, width: commentCollectionView.bounds.width) // Implement your logic to calculate cell height
                    totalHeight += cellHeight + 50
                    print(totalHeight)
                }
            }
            
        }
        print(totalHeight)
        return totalHeight
    }
    
    private func setBoard(board: Boards) {
        print(board)
        // writerProfile -> nil?
        if board.writerProfile == nil {
            self.profileImageView.image = UIImage(named: "profileIcon")
        }
        self.nicknameLabel.text = board.writerNickname
        self.timeLabel.text = createdAt(createTime: board.createdAt)
        self.titleLabel.text = board.title
        self.contextTextView.text = board.context
        self.commentLabel.text = "댓글 \(board.numberOfComments)"
        self.recommandLabel.text = "추천 \(board.numberOfLikes)"
        self.viewsLabel.text = "조회 \(board.views)"
        
        let photosCount = board.photos.count
        if photosCount == 1 {
            // 1장 photosView 하나 통으로
            
            let imageView = UIImageView()
            let url = URL(string: "\(board.photos[0])")
            imageView.load(url: url!)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            photosView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.leadingAnchor.constraint(equalTo: photosView.leadingAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: photosView.topAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: photosView.trailingAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: photosView.bottomAnchor).isActive = true
        }
        else if photosCount == 2 {
            // 2장 photosView 반반 width 반 나누기 or stackView 만들어서 하나 추가?
            let imageView1 = UIImageView()
            let url1 = URL(string: "\(board.photos[0])")
            imageView1.load(url: url1!)
            imageView1.contentMode = .scaleToFill
            imageView1.clipsToBounds = true
            imageView1.translatesAutoresizingMaskIntoConstraints = false
            
            let imageView2 = UIImageView()
            let url2 = URL(string: "\(board.photos[1])")
            imageView2.load(url: url2!)
            imageView2.contentMode = .scaleAspectFill
            imageView2.clipsToBounds = true
            imageView2.translatesAutoresizingMaskIntoConstraints = false
            let stackView = UIStackView()
            stackView.addArrangedSubview(imageView1)
            stackView.addArrangedSubview(imageView2)
            stackView.axis = .horizontal
            stackView.spacing = 8
            stackView.distribution = .fillEqually
            photosView.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.leadingAnchor.constraint(equalTo: photosView.leadingAnchor).isActive = true
            stackView.topAnchor.constraint(equalTo: photosView.topAnchor).isActive = true
            stackView.trailingAnchor.constraint(equalTo: photosView.trailingAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: photosView.bottomAnchor).isActive = true
        }
        else if photosCount >= 3 {
            // 3이상
            let imageView1 = UIImageView()
            let url1 = URL(string: "\(board.photos[0])")
            imageView1.load(url: url1!)
            imageView1.contentMode = .scaleAspectFill
            imageView1.clipsToBounds = true
            
            let imageView2 = UIImageView()
            let url2 = URL(string: "\(board.photos[1])")
            imageView2.load(url: url2!)
            imageView2.contentMode = .scaleAspectFill
            imageView2.clipsToBounds = true
            
            let imageView3 = UIImageView()
            let url3 = URL(string: "\(board.photos[2])")
            imageView3.load(url: url3!)
            imageView3.contentMode = .scaleAspectFill
            imageView3.clipsToBounds = true
            
            let vStackView = UIStackView()
            vStackView.addArrangedSubview(imageView2)
            vStackView.addArrangedSubview(imageView3)
            vStackView.axis = .vertical
            vStackView.spacing = 8
            vStackView.distribution = .fillEqually
            vStackView.translatesAutoresizingMaskIntoConstraints = false
            
            let hStackView = UIStackView()
            hStackView.addArrangedSubview(imageView1)
            hStackView.addArrangedSubview(vStackView)
            hStackView.axis = .horizontal
            hStackView.spacing = 8
            hStackView.distribution = .fillEqually
            hStackView.translatesAutoresizingMaskIntoConstraints = false
            
            photosView.addSubview(hStackView)
            
            hStackView.leadingAnchor.constraint(equalTo: photosView.leadingAnchor).isActive = true
            hStackView.topAnchor.constraint(equalTo: photosView.topAnchor).isActive = true
            hStackView.trailingAnchor.constraint(equalTo: photosView.trailingAnchor).isActive = true
            hStackView.bottomAnchor.constraint(equalTo: photosView.bottomAnchor).isActive = true
            
            if photosCount >= 4 {
                imageView3.alpha = 0.6
                let button = UIButton(type: .custom)
                button.setTitle("+ \(photosCount-3)", for: .normal)
                button.setTitleColor(.white, for: .normal)
                photosView.addSubview(button)
                button.bringSubviewToFront(photosView)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.centerXAnchor.constraint(equalTo: imageView3.centerXAnchor, constant: 0).isActive = true
                button.centerYAnchor.constraint(equalTo: imageView3.centerYAnchor, constant: 0).isActive = true
            }
        }
        else {
            self.photosView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
    }
    
    private func createdAt(createTime: String) -> String {
        // 시간계산
        return createTime
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navigationBar.heightAnchor.constraint(equalToConstant: 40),
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            profileHStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileHStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileHStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            profileHStackView.heightAnchor.constraint(equalToConstant: 50),
            
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 1.0),
            profileImageView.leadingAnchor.constraint(equalTo: profileHStackView.leadingAnchor, constant: 0),
            //            profileImageView.centerYAnchor.constraint(equalTo: profileHStackView.centerYAnchor, constant: 0),
            
            //            profileVStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 0),
            profileVStackView.trailingAnchor.constraint(equalTo: profileHStackView.trailingAnchor, constant: 0),
            
            profileLineView.topAnchor.constraint(equalTo: profileHStackView.bottomAnchor, constant: 8),
            profileLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            profileLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            profileLineView.heightAnchor.constraint(equalToConstant: 1),
            
            titleLabel.topAnchor.constraint(equalTo: profileLineView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            titleLineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            titleLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            titleLineView.heightAnchor.constraint(equalToConstant: 1),
            
            contextTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contextTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contextTextView.topAnchor.constraint(equalTo: titleLineView.bottomAnchor, constant: 10),
            
            photosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            photosView.topAnchor.constraint(equalTo: contextTextView.bottomAnchor, constant: 20),
            
            imageLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageLineView.topAnchor.constraint(equalTo: photosView.bottomAnchor, constant: 15),
            imageLineView.heightAnchor.constraint(equalToConstant: 1),
            
            commentCountView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            commentCountView.topAnchor.constraint(equalTo: imageLineView.bottomAnchor, constant: 10),
            commentCountView.heightAnchor.constraint(equalToConstant: 20),
            
            recommandCountView.centerYAnchor.constraint(equalTo: commentCountView.centerYAnchor, constant: 0),
            recommandCountView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recommandCountView.heightAnchor.constraint(equalToConstant: 20),
            
            viewsCountView.centerYAnchor.constraint(equalTo: commentCountView.centerYAnchor, constant: 0),
            viewsCountView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            recommandCountView.heightAnchor.constraint(equalToConstant: 20),
            
            countLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            countLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            countLineView.topAnchor.constraint(equalTo: commentCountView.bottomAnchor, constant: 8),
            countLineView.heightAnchor.constraint(equalToConstant: 1),
            
            commentCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            commentCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            commentCollectionView.topAnchor.constraint(equalTo: countLineView.bottomAnchor, constant: 20),
            
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomView.heightAnchor.constraint(equalToConstant: 50),
            
            uploadCommentView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: 0),
            uploadCommentView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 0),
            uploadCommentView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 0),
            
            commentAnonymousLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 5),
            commentAnonymousLabel.centerYAnchor.constraint(equalTo: uploadCommentView.centerYAnchor, constant: 0),
            
            commentUploadButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 0),
            commentUploadButton.centerYAnchor.constraint(equalTo: commentAnonymousLabel.centerYAnchor, constant: 0),
            commentUploadButton.heightAnchor.constraint(equalToConstant: 40),
            commentUploadButton.widthAnchor.constraint(equalToConstant: 40),
            
            commentAnonymousButton.leadingAnchor.constraint(equalTo: commentAnonymousLabel.trailingAnchor, constant: 3),
            commentAnonymousButton.centerYAnchor.constraint(equalTo: commentAnonymousLabel.centerYAnchor, constant: 0),
            
            commentTextField.leadingAnchor.constraint(equalTo: commentAnonymousButton.trailingAnchor, constant: 10),
            commentTextField.centerYAnchor.constraint(equalTo: commentAnonymousLabel.centerYAnchor, constant: 0),
            
            commentLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            commentLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            commentLineView.heightAnchor.constraint(equalToConstant: 1)
            
        ])
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func menuButtonTapped() {
        print("menu button tapped")
    }
    
    @objc func viewTap() {
        print("view tapped")
        DetailBoardViewModel.shared.moreCommentButtonTapped()
        // Handle the tap gesture
    }
}

extension UIScrollView {
    func updateContentSize() {
        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
        // 계산된 크기로 컨텐츠 사이즈 설정
        self.contentSize = CGSize(width: self.frame.width, height: unionCalculatedTotalRect.height)
    }
    
    private func recursiveUnionInDepthFor(view: UIView) -> CGRect {
        var totalRect: CGRect = .zero
        
        // 모든 자식 View의 컨트롤의 크기를 재귀적으로 호출하며 최종 영역의 크기를 설정
        //        print("view \(view)", view.frame.height)
        
        for subView in view.subviews {
            totalRect = totalRect.union(recursiveUnionInDepthFor(view: subView))
        }
        
        // 최종 계산 영역의 크기를 반환
        return totalRect.union(view.frame)
    }
}

extension DetailBoardViewController: UITextFieldDelegate {
    
}

extension DetailBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func calculateCommentHeight(text: String, width: CGFloat, font: UIFont? = nil) -> CGFloat {
        
        
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0 // Allow multiple lines
        label.lineBreakMode = .byWordWrapping
        
        let labelSize = label.sizeThatFits(CGSize(width: view.frame.width, height: .greatestFiniteMagnitude))
        
        return labelSize.height
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        DetailBoardViewModel.shared.onCommentsCount = { result in
            print("onCommentsCount \(result)")
            return result
        }
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let comment = comments[section]
        
        let commentText = comment.context
        let headerHeight = calculateCommentHeight(text: commentText, width: collectionView.bounds.width)
        if comment.childComments == nil {
            // childComment가 없다면
            return CGSize(width: collectionView.frame.width, height: headerHeight + 80)
        }
        return CGSize(width: collectionView.frame.width, height: headerHeight + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CommentHeader", for: indexPath) as? CommentHeaderReusableView else {
                fatalError("Unable to dequeue header view")
            }
            let comment = comments[indexPath.section]
            print("headerComment context ", comment.context)
            // ok
            headerView.backView.backgroundColor = .systemTeal
            headerView.isUserInteractionEnabled = true
            headerView.showMoreView.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTap))
            headerView.showMoreView.addGestureRecognizer(gesture)
            headerView.generateCell(comment: comment)
            
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let childCommentsCount = comments[section].childComments?.count {
            print("section: \(section) childComment: \(childCommentsCount)")
            return childCommentsCount
            
        }
        print("fail")
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let commentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as? CommentCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let childComment = self.comments[indexPath.section].childComments?[indexPath.item] {
            print("childComment context ", childComment.context)
            commentCell.contextLabel.numberOfLines = 0
            commentCell.contextLabel.lineBreakMode = .byWordWrapping
            commentCell.generateCell(comment: childComment)
        }
//        commentCell.contextLabel.numberOfLines = 0
//        commentCell.contextLabel.lineBreakMode = .byWordWrapping
//        commentCell.backView.backgroundColor = .blue

//
//        DetailBoardViewModel.shared.onMoreCommentResult = { result in
//            if result == false {
//                print("result false")
//                // 더보기 x
//                commentCell.isHidden = true
//           \
//            else if result == true {
//                print("result true")
//                // 더보기 ㅇ
//                commentCell.isHidden = false
//                if let childComment = self.comments[indexPath.section].childComments?[indexPath.item] {
//                    print("childComment context ", childComment.context)
//                    commentCell.generateCell(comment: childComment)
//                } else {
//                    print("fail to load childComment")
//                }
//            }
//            
//        }
        return commentCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let comment = comments[indexPath.section].childComments?[indexPath.item] else {
            return CGSize(width: view.bounds.width, height: 0)
        }
        let cellHeight = calculateCommentHeight(text: comment.context, width: collectionView.bounds.width)
        print("comment :\(comment.context)\n", cellHeight)
        
        
        print("childcell width bounds \(collectionView.bounds.width)")
        print("childcell width frame \(collectionView.frame.width)")
        return CGSize(width: collectionView.bounds.width, height: cellHeight + 80)
    }
}

struct PreView: PreviewProvider {
    static var previews: some View {
        DetailBoardViewController().toPreview()
    }
}

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Group {
            Preview(viewController: self)
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
                .previewDisplayName("iPhone 13 Pro Max")
            
            Preview(viewController: self)
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
            
            Preview(viewController: self)
                .previewDevice(PreviewDevice(rawValue: "iPhone XS"))
                .previewDisplayName("xs 미리보기")
        }
        
    }
}
#endif

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

