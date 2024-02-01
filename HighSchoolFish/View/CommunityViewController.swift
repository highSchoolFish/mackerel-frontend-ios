

import UIKit
import SwiftUI
import SafeAreaBrush

class CommunityViewController: UIViewController {
    
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
        naviTitleItem.rightBarButtonItems = [settingButton, findButton]
        
        naviBar.items = [naviTitleItem]
        return naviBar
    }()
    
    private lazy var naviTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "학교 게시판"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let backImage = UIImage(named: "backButton")!
        let button = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        return button
    }()
    
    private lazy var findButton: UIBarButtonItem = {
        let findImage  = UIImage(named: "findIcon")!
        let button = UIBarButtonItem(image: findImage,  style: .plain, target: self, action: #selector(findButtonTapped))
        return button
    }()
    
    private lazy var settingButton: UIBarButtonItem = {
        let menuImage  = UIImage(named: "settingTabIcon")!
        let button = UIBarButtonItem(image: menuImage,  style: .plain, target: self, action: #selector(settingButtonTapped))
        return button
    }()
    
    private lazy var noticeView: UIView = {
        var view = UIView()
        view.addSubview(noticeImageView)
        view.addSubview(noticeTitleLabel)
        view.addSubview(noticeSubTitleLabel)
        view.addSubview(noticeDateLabel)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.404, green: 0.608, blue: 1, alpha: 0.2).cgColor // 색깔
        view.layer.shadowColor = UIColor(red: 0.404, green: 0.608, blue: 1, alpha: 0.2).cgColor // 색깔
        view.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        view.layer.shadowOffset = CGSize(width: 0, height: 2) // 위치조정
        view.layer.shadowRadius = 2 // 반경
        view.layer.shadowOpacity = 1 // alpha값
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var noticeImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "notificationIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var noticeTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "공지사항 제목 자리요"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var noticeSubTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "공지 | "
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var noticeDateLabel: UILabel = {
        var label = UILabel()
        label.text = "2023.10.22"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CommunityTableViewCell", bundle: nil), forCellReuseIdentifier: "CommunityTableViewCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var writingButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("게시판 작성하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "main")
        button.addTarget(self, action: #selector(writingButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var goUpButton: UIButton = {
        var button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(goUpButtonTapped), for: .touchUpInside)
        button.tintColor = .gray
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .light)
        let image = UIImage(systemName: "arrow.up.circle", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var boards:[Boards] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setautoLayout()
        
        boards.removeAll()
        
        CommunityViewModel.shared.getCategory()
        CommunityViewModel.shared.onBoardsResult = { resultArray in
            print("in CommunityVC arr count ", resultArray.count)
            self.boards = resultArray
            self.tableView.reloadData()

        }
        self.tableView.reloadData()

    }
    
    private func configure() {
        
        view.backgroundColor = .white
        fillSafeArea(position: .top, color: UIColor(named: "main")!, gradient: false)
        
        view.addSubview(navigationBar)
        view.addSubview(noticeView)
        view.addSubview(tableView)
        view.addSubview(writingButton)
        view.addSubview(goUpButton)
    }
    
    private func setautoLayout() {
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            noticeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noticeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noticeView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20),
            noticeView.heightAnchor.constraint(equalToConstant: 60),
            
            noticeImageView.leadingAnchor.constraint(equalTo: noticeView.leadingAnchor, constant: 10),
            noticeImageView.topAnchor.constraint(equalTo: noticeView.topAnchor, constant: 10),
            noticeImageView.widthAnchor.constraint(equalToConstant: 20),
            noticeImageView.heightAnchor.constraint(equalToConstant: 20),
            
            noticeTitleLabel.leadingAnchor.constraint(equalTo: noticeImageView.trailingAnchor, constant: 10),
            noticeTitleLabel.trailingAnchor.constraint(equalTo: noticeView.trailingAnchor, constant: -10),
            noticeTitleLabel.centerYAnchor.constraint(equalTo: noticeImageView.centerYAnchor, constant: 0),
            
            noticeSubTitleLabel.topAnchor.constraint(equalTo: noticeImageView.bottomAnchor, constant: 5),
            noticeSubTitleLabel.leadingAnchor.constraint(equalTo: noticeView.leadingAnchor, constant: 10),
            noticeSubTitleLabel.bottomAnchor.constraint(equalTo: noticeView.bottomAnchor, constant: -10),
            
            noticeDateLabel.leadingAnchor.constraint(equalTo: noticeSubTitleLabel.trailingAnchor, constant: 5),
            noticeDateLabel.centerYAnchor.constraint(equalTo: noticeSubTitleLabel.centerYAnchor, constant: 0),
            noticeDateLabel.trailingAnchor.constraint(equalTo: noticeView.trailingAnchor, constant: -10),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: noticeView.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: writingButton.topAnchor, constant: -20),
            
            writingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            writingButton.heightAnchor.constraint(equalToConstant: 40),
            writingButton.widthAnchor.constraint(equalToConstant: 200),
            writingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            
            goUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            goUpButton.centerYAnchor.constraint(equalTo: writingButton.centerYAnchor, constant: 0)
            
            
        ])
    }
    
    @objc private func writingButtonTapped() {
        
        let vc = WritingBoardViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc private func goUpButtonTapped() {
        tableView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func findButtonTapped() {
        
    }
    
    @objc private func settingButtonTapped() {
        
    }
    
    func presentToDetailBoardViewController() {
        print("present View")
        
    }
    
}

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableDelegate boards count \(boards.count)")
        return boards.count
        // community 글 갯수 (cell) return
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        print("boards : \(boards)")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell", for: indexPath)as? CommunityTableViewCell else{
            print("cell error")
            return .init()
        }
        
        cell.generateCell(board: boards[indexPath.item])
        
        print("print cell index \(cell.index)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택 : \(indexPath)")
        print("boardId : \(boards[indexPath.item].boardId)")
        // 선택 후 setBoardId 호출
        DetailBoardViewModel.shared.setBoardId(boards[indexPath.item].boardId)
        
        DetailBoardViewModel.shared.getBoardComplete = { result in
            if result == true {
                print("result true")
                // board 호출 성공
                // vc 전환
                let vc = DetailBoardViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
//                self.presentToDetailBoardViewController()
            }
            else {
                // boardId 없거나 init 실패?
            }
        }
        
    }
    
}

//struct PreView: PreviewProvider {
//    static var previews: some View {
//        CommunityViewController().toPreview()
//    }
//}
//
//#if DEBUG
//extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//        let viewController: UIViewController
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        }
//    }
//
//    func toPreview() -> some View {
//        Group {
//            Preview(viewController: self)
//                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//                .previewDisplayName("iPhone 13 Pro Max")
//
//            Preview(viewController: self)
//                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//                .previewDisplayName("iPhone 8")
//
//            Preview(viewController: self)
//                .previewDevice(PreviewDevice(rawValue: "iPhone XS"))
//                .previewDisplayName("xs 미리보기")
//        }
//
//    }
//}
//#endif

