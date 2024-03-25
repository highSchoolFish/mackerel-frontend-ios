//
//  DetailCommunityViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/23.
//

import UIKit
import SwiftUI
import SafeAreaBrush

class DetailBoardViewController: UIViewController, UITextFieldDelegate {
    
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
        view.addSubview(commentTableView)
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
    
    private lazy var contextTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 13)
        textView.backgroundColor = UIColor(named: "backgroundColor")
        textView.text = "너는 항상 빛에 반짝일 테니까 멋진 말들을 전하지 못하고 아무도 관심 없는 그림이 되겠지만 달콤한 색감은 감추지 못해 터지고 있어너는 항상 빛에 반짝일 테니까 멋진 말들을 전하지 못하고 아무도 관심 없는 그림이 되겠지만 달콤한 색감은 감추지 못해 터지고 있어너는 항상 빛에 반짝일 테니까 멋진 말들을 전하지 못하고 아무도 관심 없는 그림이 되겠지만 달콤한 색감은 감추지 못해 터지고 있어너는 항상 빛에 반짝일 테니까 멋진 말들을 전하지 못하고 아무도 관심 없는 그림이 되겠지만 달콤한 색감은 감추지 못해 터지고 있어너는 항상 빛에 반짝일 테니까 멋진 말들을 전하지 못하고 아무도 관심 없는 그림이 되겠지만 달콤한 색감은 감추지 못해 터지고 있어"
        textView.showsVerticalScrollIndicator = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var photosView: UIView = {
        let view = UIView()
        // collection view 넣거나
        // uiview 이미지 갯수만큼 넣고 constraint 조정
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photosViewTapped)) // UIImageView 클릭 제스쳐
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .white
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
    
    private lazy var commentTableView: UITableView = {
        var tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(UINib(nibName: "CommentTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CommentTableHeaderView")
        tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        tableView.isScrollEnabled = false
        tableView.sectionFooterHeight = 0
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        //        view.layer.borderColor = UIColor(named: "lineGray")!.cgColor
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var commentAnonymousLabel: UILabel = {
        let label = UILabel()
        label.text = "익명"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "darkGray")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var commentAnonymousButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        button.addTarget(self, action: #selector(commentAnonymousButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonIsSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "댓글을 입력해주세요."
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.isEnabled = true
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var commentUploadButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "uploadCircleIcon"), for: .normal)
        button.addTarget(self, action: #selector(commentUploadButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func addDimmingView() {
        dimmingView = UIView(frame: self.view.bounds)
        dimmingView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView?.isHidden = true
        view.addSubview(dimmingView!)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDimmingViewTap))
        dimmingView?.addGestureRecognizer(tapGesture)
    }
    
    var images: [UIImage] = []
    var photos: [URL] = []
    var comments: [CommentContent] = []
    var totalheight: CGFloat = 0
    var bottomViewContraint: NSLayoutConstraint?
    private var dimmingView: UIView?
    private var boardBottomViewController = BoardBottomSheetViewController()
    var isViewOpen: Bool = false
    private var tableViewHeightConstraint: NSLayoutConstraint?
    var hiddenSections = [Bool]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutoLayout()
        
        bottomViewContraint = bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        bottomViewContraint?.isActive = true
        
        DetailBoardViewModel.shared.onBoardComplete = { result in
            self.setBoard(board: result)
        }
        
        settingComment()
        
        setKeyboardObserver()
        addDimmingView()
        commentAnonymousButton.isEnabled = true
        commentTextField.isUserInteractionEnabled = true
        commentUploadButton.isUserInteractionEnabled = true
        self.bottomView.bringSubviewToFront(uploadCommentView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateContentSize()
    }
    
    func settingComment() {
        DetailBoardViewModel.shared.onCommentsResult = { result in
            print("comment result ", result)
            print("comment result.data.content ", result.data.content)
            
            
            self.setComment(comment: result)
        }
    }
    
    private func configure() {
        view.backgroundColor = .white
        fillSafeArea(position: .top, color: UIColor(named: "main")!, gradient: false)
        view.addSubview(navigationBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(bottomView)
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    private func setComment(comment: Comment) {
        self.comments = comment.data.content
        hiddenSections = Array(repeating: true, count: comments.count)
        
        print("tableview height : \(calculateTotalHeight())")
        let newHeight = calculateTotalHeight()
        
        if tableViewHeightConstraint == nil {
            // 초기 제약조건 설정
            tableViewHeightConstraint = commentTableView.heightAnchor.constraint(equalToConstant: newHeight)
            tableViewHeightConstraint?.isActive = true
        } else {
            // 기존 제약조건 업데이트
            tableViewHeightConstraint?.constant = newHeight
        }
        
        // get board 정보? 너무 비싼데
        //        self.commentLabel.text = "댓글 \(comment.data.numberOfcommment)"
        
        
        print("hiddenSections \(hiddenSections)")
        print("hiddenSections.count \(hiddenSections.count)")
        self.commentTableView.reloadData()
        
    }
    
    func calculateTotalHeight() -> CGFloat {
        var totalHeight: CGFloat = 0
        
        // Add 100 for each cell
        for (index, comment) in comments.enumerated() {
            let headerHeight = calculateCommentHeight(text: comment.context, width: commentTableView.bounds.width)
            totalHeight += headerHeight + 100
            print(totalHeight)
            if hiddenSections[index] == false {
                // 숨김
                if let childComments = comment.childComments {
                    for childComment in childComments {
                        let cellHeight = calculateCommentHeight(text: childComment.context, width: commentTableView.bounds.width)
                        totalHeight += cellHeight + 80
                        print(totalHeight)
                    }
                }
            }
        }
        
        print(totalHeight)
        return totalHeight
    }
    
    func calculateCommentHeight(text: String, width: CGFloat, font: UIFont? = nil) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0 // Allow multiple lines
        label.lineBreakMode = .byWordWrapping
        
        let labelSize = label.sizeThatFits(CGSize(width: view.frame.width, height: .greatestFiniteMagnitude))
        return labelSize.height
    }
    
    private func setBoard(board: Boards) {
        print(board)
        // writerProfile -> nil?
        if board.writerProfile == nil {
            self.profileImageView.image = UIImage(named: "profileIcon")
        }
        self.nicknameLabel.text = board.writerNickname
        if board.writerNickname == "" {
            self.nicknameLabel.text = "익명"
        }
        self.timeLabel.text = createdAt(createTime: board.createdAt)
        self.titleLabel.text = board.title
        self.contextTextView.text = board.context
        self.commentLabel.text = "댓글 \(board.numberOfComments)"
        self.recommandLabel.text = "추천 \(board.numberOfLikes)"
        self.viewsLabel.text = "조회 \(board.views)"
        
        if board.isWriter {
            // 본인
            DetailBoardViewModel.shared.isWriter = true
        }
        else {
            // 일반
            DetailBoardViewModel.shared.isWriter = false
        }
        
        let photosCount = board.photos.count
        
        print("photosCount \(photosCount)")
        DetailBoardViewModel.shared.setimageArray(board.photos)
        if photosCount == 1 {
            // 1장 photosView 하나 통으로
            photosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            photosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
            photosView.topAnchor.constraint(equalTo: contextTextView.bottomAnchor, constant: 20).isActive = true
            photosView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            let imageView = UIImageView()
            let url = URL(string: "\(board.photos[0])")
            
            imageView.load(url: url!)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            photosView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.leadingAnchor.constraint(equalTo: photosView.leadingAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: photosView.topAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: photosView.trailingAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: photosView.bottomAnchor).isActive = true
        }
        else if photosCount == 2 {
            photosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            photosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
            photosView.topAnchor.constraint(equalTo: contextTextView.bottomAnchor, constant: 20).isActive = true
            photosView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            // 2장 photosView 반반 width 반 나누기 or stackView 만들어서 하나 추가?
            let imageView1 = UIImageView()
            let url1 = URL(string: "\(board.photos[0])")
            imageView1.load(url: url1!)
            imageView1.contentMode = .scaleAspectFit
            imageView1.clipsToBounds = true
            imageView1.translatesAutoresizingMaskIntoConstraints = false
            
            let imageView2 = UIImageView()
            let url2 = URL(string: "\(board.photos[1])")
            imageView2.load(url: url2!)
            imageView2.contentMode = .scaleAspectFit
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
            photosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            photosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
            photosView.topAnchor.constraint(equalTo: contextTextView.bottomAnchor, constant: 20).isActive = true
            photosView.heightAnchor.constraint(equalToConstant: 200).isActive = true
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
            print("photosView.height 0")
            photosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            photosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
            photosView.topAnchor.constraint(equalTo: contextTextView.bottomAnchor, constant: 20).isActive = true
            photosView.heightAnchor.constraint(equalToConstant: 0).isActive = true
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
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: commentTableView.bottomAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            profileHStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileHStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileHStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            profileHStackView.heightAnchor.constraint(equalToConstant: 50),
            
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 1.0),
            profileImageView.leadingAnchor.constraint(equalTo: profileHStackView.leadingAnchor, constant: 0),
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
            
            commentTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            commentTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commentTableView.topAnchor.constraint(equalTo: countLineView.bottomAnchor, constant: 20),
            commentTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomView.heightAnchor.constraint(equalToConstant: 60),
//            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            uploadCommentView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: 0),
            uploadCommentView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 0),
            uploadCommentView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 0),
            uploadCommentView.heightAnchor.constraint(equalToConstant: 55),
            
            commentAnonymousLabel.leadingAnchor.constraint(equalTo: uploadCommentView.leadingAnchor, constant: 5),
            commentAnonymousLabel.widthAnchor.constraint(equalToConstant: 30),
            commentAnonymousLabel.centerYAnchor.constraint(equalTo: uploadCommentView.centerYAnchor, constant: 0),
            
            commentAnonymousButton.heightAnchor.constraint(equalToConstant: 40),
            commentAnonymousButton.widthAnchor.constraint(equalToConstant: 40),
            commentAnonymousButton.leadingAnchor.constraint(equalTo: commentAnonymousLabel.trailingAnchor, constant: 3),
            commentAnonymousButton.centerYAnchor.constraint(equalTo: commentAnonymousLabel.centerYAnchor, constant: 0),
            
            commentTextField.leadingAnchor.constraint(equalTo: commentAnonymousButton.trailingAnchor, constant: 10),
            commentTextField.centerYAnchor.constraint(equalTo: commentAnonymousLabel.centerYAnchor, constant: 0),
            commentTextField.trailingAnchor.constraint(equalTo: commentUploadButton.leadingAnchor, constant: -10),
            commentTextField.heightAnchor.constraint(equalToConstant: 40),
            
            commentUploadButton.trailingAnchor.constraint(equalTo: uploadCommentView.trailingAnchor, constant: 0),
            commentUploadButton.centerYAnchor.constraint(equalTo: commentAnonymousLabel.centerYAnchor, constant: 0),
            commentUploadButton.heightAnchor.constraint(equalToConstant: 40),
            commentUploadButton.widthAnchor.constraint(equalToConstant: 40),
            
            commentLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            commentLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            commentLineView.heightAnchor.constraint(equalToConstant: 1),
            commentLineView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5)
        ])
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleDimmingViewTap() {
        let bottomSheetVC = self.boardBottomViewController
        
        UIView.animate(withDuration: 0.3, animations: {
            // 사이드 메뉴를 원래 위치로 되돌림.
            bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
            // 어두운 배경 뷰를 숨김.
            self.dimmingView?.alpha = 0
        }) { (finished) in
            // 애니메이션이 완료된 후 사이드 메뉴를 뷰 계층 구조에서 제거.
            bottomSheetVC.view.removeFromSuperview()
            bottomSheetVC.removeFromParent()
            self.dimmingView?.isHidden = true
        }
    }
    
    @objc func photosViewTapped(sender: UITapGestureRecognizer) {
        print("photosViewTapped")
        let view = BoardImageViewController()
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true, completion: nil)
    }
    
    @objc private func menuButtonTapped() {
        print("menu button tapped")
        
        let bottomSheetVC = self.boardBottomViewController
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        
        let sheetWidth = self.view.frame.width // 메뉴의 너비를 전체 뷰의 너비로 설정합니다.
        let sheetHeight: CGFloat = 120 // 메뉴의 높이를 설정합니다.
        
        // 사이드 메뉴의 시작 위치를 화면 하단 바로 아래로 설정합니다.
        let startPos = self.view.frame.height // 화면 하단의 y 위치
        bottomSheetVC.view.frame = CGRect(x: 0, y: startPos, width: sheetWidth, height: sheetHeight)
        
        // 어두운 배경 뷰를 보이게 합니다.
        self.dimmingView?.isHidden = false
        self.dimmingView?.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            let endPos = self.view.frame.height - sheetHeight // 화면 하단에서 메뉴 높이를 뺀 y 위치
            bottomSheetVC.view.frame = CGRect(x: 0, y: endPos, width: sheetWidth, height: sheetHeight)
            
            // 어두운 배경 뷰의 투명도를 조절합니다.
            self.dimmingView?.alpha = 0.5
        })
    }
    
    @objc func likeButtonTapped() {
        print("Like button tapped")
    }
    
    @objc func headerLikeButtonTapped(_ sender: UIButton) {
        print("headerLikeButtonTapped")
        
    }
    
    @objc func commentAnonymousButtonTapped(_ sender: UIButton) {
        print("commentAnonymousButtonTapped")
        if sender.isSelected {
            sender.isSelected = false
            commentAnonymousButton.isSelected = false
        }
        else {
            sender.isSelected = true
        }
        // 익명여부
    }
    
    @objc func buttonIsSelected(button: UIButton) {
        if self.commentAnonymousButton.isSelected == true {
            commentAnonymousButton.setImage(UIImage(named: "checkedButton"), for: .normal)
        }
        if self.commentAnonymousButton.isSelected == false {
            commentAnonymousButton.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        }
    }
    
    @objc func commentUploadButtonTapped(_ sender: UIButton) {
        print("commentUploadButtonTapped VC")
        if commentAnonymousButton.isSelected {
            print("comment anonymous true")
            DetailBoardViewModel.shared.setAnonymous(true)
        }
        else {
            print("comment anonymous false")
            DetailBoardViewModel.shared.setAnonymous(false)
        }
        print("commentAnonymous \(commentAnonymousButton.isSelected)")
        
        DetailBoardViewModel.shared.setCommentString(self.commentTextField.text ?? " ")
        
        DetailBoardViewModel.shared.commentUploadButtonTapped()
        // 답글달기 버튼 눌린거면 어떤 댓글인지 부모 댓글 id 찾아야함
        // borttomView에 commentTextField로 바로 했으면 parentId nil
        
        DetailBoardViewModel.shared.writeCommentComplete = { result in
            if result {
                // 댓글쓰기 완료 후 새로고침
                print("comment 새로고침")
                self.commentTableView.reloadData()
                DetailBoardViewModel.shared.getComment()
                self.settingComment()
                
                self.view.endEditing(true)
                self.commentTextField.text = ""
                
            }
            else {
                print("comment 새로고침 x")
            }
        }
    }
    
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    deinit {
        // 뷰 컨트롤러가 해제될 때 옵저버를 해제
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardwillshow")
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            bottomViewContraint?.constant = -keyboardHeight
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            bottomViewContraint?.constant = -20
            self.view.layoutIfNeeded()
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        return true // false를 리턴하면 편집되지 않는다.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.commentTextField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty {
            self.commentUploadButton.isEnabled = true
        } else {
            self.commentUploadButton.isEnabled = false
        }
        return true
    }
    
    // 텍스트 필드 편집이 종료될 때 호출
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 종료됩니다.")
        return true
    }
    
    //리턴키 델리게이트 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()//텍스트필드 비활성화
        return true
    }
    
    func updateContentSize() {
        // 프사height + 제목height + 내용height + 사진height + tableView height
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: recursiveUnionInDepthFor())
    }
    
    func recursiveUnionInDepthFor() -> CGFloat {
        var totalHeight: CGFloat = 0
        
        // 모든 자식 View의 컨트롤의 크기를 재귀적으로 호출하며 최종 영역의 크기를 설정
        let viewsHeight = [self.profileHStackView.frame.height, self.titleLabel.frame.height, self.contextTextView.frame.height, self.photosView.frame.height, self.viewsCountView.frame.height, self.commentTableView.frame.height]
        for viewHeight in viewsHeight {
            totalHeight += viewHeight
        }
        
        totalHeight = totalHeight + 200
        // 최종 계산 영역의 크기를 반환
        return totalHeight
    }
}

extension DetailBoardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSections")
        print("comments.count \(comments.count)")
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("viewForHeaderInSection")
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CommentTableHeaderView") as? CommentTableHeaderView else {
            // Header View를 dequeue하지 못한 경우 또는 캐스팅 실패 시 빈 UIView 반환
            return UIView()
        }
        
        headerView.showMoreViewButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        
        let comment = comments[section]
        print("comment.text \(comment.context)")
        if comment.childComments!.count >= 1 {
            headerView.showMoreView.isHidden = false
            headerView.showMoreView.heightAnchor.constraint(equalToConstant: 15).isActive = true
            if hiddenSections[section] == true {
                // 숨김
                headerView.showMoreViewButton.setTitle("답글 \(comment.childComments!.count)개", for: .normal)
            }
            if hiddenSections[section] == false {
                headerView.showMoreViewButton.setTitle("답글 숨기기", for: .normal)
            }
        }
        else {
            headerView.showMoreView.isHidden = true
        }
        headerView.isUserInteractionEnabled = true
        headerView.showMoreView.isUserInteractionEnabled = true
        
        headerView.generateCell(comment: comment)
        
        headerView.commentDeleteConfigure(section: section) {
            self.headerDeleteButtonTapped(section: section)
        }
        headerView.commentWirteConfigure(section: section) {
            self.commentWriteButtonTapped(section: section)
        }
        headerView.moreButtonConfigure(section: section) {
            self.showMoreViewButtonTapped(section: section)
        }
        headerView.likeButtonConfigure(section: section) {
            self.likeButtonTapped(section: section)
        }
        
        if comment.isWriter {
            print("same id")
            headerView.swipeConfigure(section: section) {
                self.headerSwipeForDelete(section: section)
            }
        }
        else {
            print("not same")
        }
        
        headerView.contentView.backgroundColor = .white
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        if let childCommentsCount = comments[section].childComments?.count {
            print("section: \(section) childComment: \(childCommentsCount)")
            return childCommentsCount
        }
        print("fail")
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt")
        
        guard let commentCell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        if hiddenSections[indexPath.section] == false {
            print("section hidden false")
            commentCell.isHidden = false
        }
        if hiddenSections[indexPath.section] == true {
            print("section hidden true")
            commentCell.isHidden = true
        }
        
        if let childComment = self.comments[indexPath.section].childComments?[indexPath.item] {
            
            print("name \(childComment.name)")
            print("childComment context ", childComment.context)
            //            commentCell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            commentCell.commentWriteConfigure(section: indexPath.section) {
                // 클로저 내에서 버튼이 선택되었을 때의 동작을 정의합니다.
                self.commentWriteButtonTapped(section: indexPath.section)
            }
            
            if childComment.isWriter {
                print("cell same id")
                commentCell.swipeConfigure(indexPath: indexPath) {
                    self.cellSwipeForDelete(indexPath: indexPath)
                }
            }
            else {
                print("not same id")
            }
            
            commentCell.commentDeleteConfigure(indexPath: indexPath) {
                self.cellDeleteButtonTapped(indexPath: indexPath)
            }
            
            commentCell.generateCell(comment: childComment)
        }
        
        self.commentTableView.layoutIfNeeded()
        return commentCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if hiddenSections[indexPath.section] {
            print("hidden section height set 0")
            return 0 // 숨겨진 셀의 높이를 0으로 설정
        } else {
            return UITableView.automaticDimension // 기본 높이
        }
    }
    
    func commentWriteButtonTapped(section: Int) {
        // 여기에서 선택된 섹션 값을 사용하여 작업을 수행합니다.
        print("Button tapped in section VC \(section)")
        self.commentTextField.becomeFirstResponder()
        // VM 전달
        DetailBoardViewModel.shared.setHeaderSection(section)
    }
    
    func showMoreViewButtonTapped(section: Int) {
        // 여기에서 선택된 섹션 값을 사용하여 작업을 수행합니다.
        print("Button tapped in section VC \(section)")
        // VM 전달
        DetailBoardViewModel.shared.setHeaderSection(section)
        hiddenSections[section] = !hiddenSections[section] // 숨김 상태 토글
        print("hiddenSections \(hiddenSections)")
        let indexSet = IndexSet(arrayLiteral: section)
        
        
        self.commentTableView.reloadSections(indexSet, with: .fade)
        
        print("tableview height : \(calculateTotalHeight())")
        let newHeight = calculateTotalHeight()
        
        tableViewHeightConstraint?.constant = newHeight
    }
    
    func headerSwipeForDelete(section: Int) {
        print("swipe header")
        var headerComment = comments[section]
        DetailBoardViewModel.shared.setCommentIdString(headerComment.id)
    }
    
    func headerDeleteButtonTapped(section: Int) {
        print("delete header btn tapped")
            let comment = self.comments[section]
            print("comment.text \(comment.context)")
            // 대댓글 있는 경우 다 지워야함
            var idStringArr: [String] = []
        DispatchQueue.main.async {
            DetailBoardViewModel.shared.deleteButtonTapped(comment: comment)

        }
            DetailBoardViewModel.shared.onCommentDeleteButtonComplete = { result in
                print("result \(result)")
                if result {
                    if comment.childComments!.count >= 1 {
                        // 대댓글이 있으면
                        for item in comment.childComments! {
                            idStringArr.append(item.id)
                        }
                    }
                    // 대댓글 없으면
                    idStringArr.append(comment.id)
                    
                    print("idStringArr \(idStringArr)")
                    
                    DetailBoardViewModel.shared.setIdStringArr(idStringArr)
                    
                    
                    
                    // 삭제 눌림
                    let alert = AlertStatusViewModel.shared.AlertForCheck(checkStatus: .deleteComment)
                    CustomAlertViewModel.shared.setAlertStatus(alertStatus: .deleteComment)
                    
                    let customAlertVC = CustomAlertViewController()
                    customAlertVC.show(alertTitle: alert.alertTitle, alertMessage: alert.alertMessage, alertType: alert.alertType, on: self)
                    
                }

                DetailBoardViewModel.shared.onCommentDeleteComplete = { result in
                    if result {
                        // 댓 삭제 완료
                        
                        print("댓 삭제 완료 result \(result)")
                        DispatchQueue.main.async {
                            DetailBoardViewModel.shared.getComment()
                            self.settingComment()
                        }
                    }
                }
            }
        
        
    }
    
    func cellDeleteButtonTapped(indexPath: IndexPath) {
        print("delete cell btn tapped")
        DispatchQueue.main.async {
            
            if let cellComment = self.comments[indexPath.section].childComments?[indexPath.row] {
                print("cellCommentId \(cellComment.id)")
                print("cellComment.name \(cellComment.name)")
                DetailBoardViewModel.shared.deleteButtonTapped(comment: cellComment)
                
                DetailBoardViewModel.shared.onCommentDeleteButtonComplete = { result in
                    if result {
                        // 삭제 눌림
                        var idStringArr: [String] = []
                        
                        // 대댓글 없으면
                        idStringArr.append(cellComment.id)
                        
                        print("idStringArr \(idStringArr)")
                        
                        DetailBoardViewModel.shared.setIdStringArr(idStringArr)
                        
                        
                        let alert = AlertStatusViewModel.shared.AlertForCheck(checkStatus: .deleteComment)
                        CustomAlertViewModel.shared.setAlertStatus(alertStatus: .deleteComment)
                        
                        let customAlertVC = CustomAlertViewController()
                        customAlertVC.show(alertTitle: alert.alertTitle, alertMessage: alert.alertMessage, alertType: alert.alertType, on: self)
                    }
                }
                
                
                DetailBoardViewModel.shared.onCommentDeleteComplete = { result in
                    if result {
                        // 댓 삭제 완료
                        
                        print("댓 삭제 완료 result \(result)")
                        DispatchQueue.main.async {
                            DetailBoardViewModel.shared.getComment()
                            self.settingComment()
                        }
                    }
                }
            }
        }
    }
    
    
    func cellSwipeForDelete(indexPath: IndexPath) {
        print("swipe cell")
        if let cellComment = comments[indexPath.section].childComments?[indexPath.row] {
            print("cellCommentId \(cellComment.id)")
            print("cellComment.name \(cellComment.name)")
            DetailBoardViewModel.shared.setCommentIdString(cellComment.id)
            
        }
    }
    
    func likeButtonTapped(section: Int) {
        print("likeButtonTapped")
        
        DetailBoardViewModel.shared.setHeaderSection(section)
    }
    
    
}
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
