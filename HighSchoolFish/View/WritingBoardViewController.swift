//
//  WritingBoardViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/23.
//

import UIKit
import SwiftUI
import BSImagePicker
import Photos


class WritingBoardViewController: UIViewController, UIImagePickerControllerDelegate {
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "게시판 글쓰기"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabelLine: UIView = {
        var view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lineGray")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "제목을 입력해주세요."
        textField.font = UIFont.boldSystemFont(ofSize: 15)
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var titleTextFieldLine: UIView = {
        var view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lineGray")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var anonymousStackView: UIStackView = {
        var stView = UIStackView()
        stView.addArrangedSubview(anonymousLabel)
        stView.addArrangedSubview(checkboxButton)
        stView.spacing = 10
        stView.axis = .horizontal
        stView.translatesAutoresizingMaskIntoConstraints = false
        
        return stView
    }()
    
    private lazy var anonymousViewLine: UIView = {
        var view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lineGray")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var anonymousLabel: UILabel = {
        var label = UILabel()
        label.text = "익명 작성"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var checkboxButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        button.addTarget(self, action: #selector(checkboxButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var contentTextView: UITextView = {
        var textView = UITextView()
        textView.backgroundColor = .yellow
        textView.font = UIFont.systemFont(ofSize: 13)
        textView.textAlignment = .left
        textView.contentMode = .topLeft
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var contentLabel1: UILabel = {
        var label = UILabel()
        label.text = "내용을 입력해주세요."
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(named: "lightGray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentLabel2: UILabel = {
        var label = UILabel()
        label.text = "(개인 정보 도용방지를 위해 연락처나 이메일주소, 카카오톡 아이디, 상호를 포함한 글은 사전 동의없이 삭제됩니다. 또한 비방성 글 또는 성인광고, 사이트 홍보 글을 등록하는 경우 행당 게시글 삭제 후 제한 처리 됩니다.)"
        label.numberOfLines = 6
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "lightGray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentLineView: UIView = {
        var view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lineGray")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageStackView: UIStackView = {
        var stView = UIStackView()
        stView.addArrangedSubview(addImageStackView)
        stView.addArrangedSubview(imageLabel)
        stView.axis = .vertical
        stView.spacing = 10
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var addImageStackView: UIStackView = {
        var view = UIStackView()
        view.addArrangedSubview(addView)
        view.addArrangedSubview(imageCollectionView)
        view.axis = .horizontal
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addView: UIStackView = {
        var stView = UIStackView()
        stView.addArrangedSubview(addImageView)
        stView.addArrangedSubview(addImageLabel)
        stView.layer.borderColor = UIColor(named: "gray")?.cgColor
        stView.layer.borderWidth = 1
        stView.layer.cornerRadius = 10
        stView.backgroundColor = .white
        stView.axis = .vertical
        stView.spacing = 5
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var addImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "camera")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var addImageLabel: UILabel = {
        var label = UILabel()
        label.text = "6/10"
        label.textColor = UIColor(named: "gray")
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(UINib(nibName: "BoardImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BoardImageCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var imageLabel: UILabel = {
        var label = UILabel()
        label.text = "* 사진의 10MB이하의 jpg, jpeg, gif 파일만 적용됩니다."
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "gray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageLineView: UIView = {
        var view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lineGray")!.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttonStackView: UIStackView = {
        var stView = UIStackView()
        stView.addArrangedSubview(cancelButton)
        stView.addArrangedSubview(createButton)
        stView.spacing = 20
        stView.axis = .horizontal
        stView.distribution = .fillEqually
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var cancelButton: UIButton = {
        var button = UIButton()
        button.setTitle("취소", for: .normal)
        button.layer.borderColor = UIColor(named: "gray")!.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.setTitleColor(UIColor(named: "gray"), for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var createButton: UIButton = {
        var button = UIButton()
        button.setTitle("등록", for: .normal)
        button.layer.borderColor = UIColor(named: "main")!.cgColor
        button.backgroundColor = UIColor(named: "main")
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var images: [UIImage] = []
    var selectedAssets: [PHAsset] = []
    let imagePicker = ImagePickerController()
    var imageDataArray : [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupAutoLayout()
        makeGesture()
        self.view.bringSubviewToFront(contentLabel1)
        self.view.bringSubviewToFront(contentLabel2)
        self.contentTextView.delegate = self
        view.backgroundColor = UIColor(named: "backgroundColor")
    }
    
    private func configure() {
        view.addSubview(titleLabel)
        view.addSubview(titleLabelLine)
        view.addSubview(titleTextField)
        view.addSubview(titleTextFieldLine)
        view.addSubview(anonymousStackView)
        view.addSubview(anonymousViewLine)
        view.addSubview(contentLabel1)
        view.addSubview(contentLabel2)
        view.addSubview(contentTextView)
        view.addSubview(contentLineView)
        view.addSubview(imageStackView)
        view.addSubview(imageLineView)
        view.addSubview(buttonStackView)
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        imageCollectionView.collectionViewLayout = flowLayout
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            titleLabelLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabelLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabelLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            titleLabelLine.heightAnchor.constraint(equalToConstant: 1),
            
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextField.topAnchor.constraint(equalTo: titleLabelLine.bottomAnchor, constant: 12),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            titleTextFieldLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextFieldLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextFieldLine.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 12),
            titleTextFieldLine.heightAnchor.constraint(equalToConstant: 1),
            
            anonymousStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            anonymousStackView.topAnchor.constraint(equalTo: titleTextFieldLine.bottomAnchor, constant: 12),
            anonymousStackView.heightAnchor.constraint(equalToConstant: 30),
            
            anonymousViewLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            anonymousViewLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            anonymousViewLine.topAnchor.constraint(equalTo: anonymousStackView.bottomAnchor, constant: 12),
            anonymousViewLine.heightAnchor.constraint(equalToConstant: 1),
            
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentTextView.topAnchor.constraint(equalTo: anonymousViewLine.bottomAnchor, constant: 12),
            contentTextView.bottomAnchor.constraint(equalTo: contentLineView.topAnchor, constant: -12),
            
            contentLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLabel1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentLabel1.topAnchor.constraint(equalTo: contentTextView.topAnchor, constant: 20),
            
            contentLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLabel2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentLabel2.topAnchor.constraint(equalTo: contentLabel1.bottomAnchor, constant: 20),
            
            contentLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentLineView.heightAnchor.constraint(equalToConstant: 1),
            contentLineView.bottomAnchor.constraint(equalTo: imageStackView.topAnchor, constant: -12),
            
            imageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:   -16),
            imageStackView.heightAnchor.constraint(equalToConstant: 100),
            imageStackView.bottomAnchor.constraint(equalTo: imageLineView.topAnchor, constant: -12),
            
            addView.leadingAnchor.constraint(equalTo: addImageStackView.leadingAnchor, constant: 0),
            addView.topAnchor.constraint(equalTo: addImageStackView.topAnchor, constant: 0),
            addView.heightAnchor.constraint(equalTo: addView.widthAnchor, multiplier: 1.0),
            
            imageLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageLineView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -60),
            imageLineView.heightAnchor.constraint(equalToConstant: 1),
            
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    @objc private func checkboxButtonTapped(_ sender: Any) {
        print("checkbutton \(checkboxButton.isSelected)")
        
        if checkboxButton.isSelected == false {
            print("false")
            checkboxButton.isSelected = true
            checkboxButton.setImage(UIImage(named: "checkedButton"), for: .normal)
            print("true")
            WritingBoardViewModel.shared.setAnonymous(true)
        }
        else if checkboxButton.isSelected == true {
            print("true")
            checkboxButton.setImage(UIImage(named: "uncheckedButton"), for: .normal)
            checkboxButton.isSelected = false
            print("false")
            WritingBoardViewModel.shared.setAnonymous(false)
        }
    }
    
    func makeGesture() {
        let addImageButtonViewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addImageViewTapped))
        addView.addGestureRecognizer(addImageButtonViewTapGesture)
        
    }
    
    @objc private func addImageViewTapped(_ sender: Any) {
        // [로직 처리 수행]
        DispatchQueue.main.async {
            
            // [앨범의 사진에 대한 접근 권한 확인 실시]
            PHPhotoLibrary.requestAuthorization( { status in
                switch status{
                case .authorized:
                    print("")
                    print("====================================")
                    print("상태 :: 앨범 권한 허용")
                    print("====================================")
                    print("")
                    
                    // [앨범 열기 수행 실시]
                    self.openAlbum()
                    break
                    
                case .denied:
                    print("")
                    print("====================================")
                    print("상태 :: 앨범 권한 거부")
                    print("====================================")
                    print("")
                    break
                    
                case .notDetermined:
                    print("")
                    print("====================================")
                    print("상태 :: 앨범 권한 선택하지 않음")
                    print("====================================")
                    print("")
                    break
                    
                case .restricted:
                    print("")
                    print("====================================")
                    print("상태 :: 앨범 접근 불가능, 권한 변경이 불가능")
                    print("====================================")
                    print("")
                    break
                    
                default:
                    print("")
                    print("====================================")
                    print("상태 :: default")
                    print("====================================")
                    print("")
                    break
                }
            })
            
        }
    }
    
    func openAlbum() {
        print("openAlbum images count : ", images.count)
        print("pick start ", self.selectedAssets.count)
        
        
        var deSelectedAssets: [PHAsset] = []
        self.imagePicker.settings.selection.max = 10
        self.imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        self.imagePicker.settings.theme.selectionFillColor = UIColor(named: "main")! // 선택 배경 색상 (Circle)
        self.imagePicker.settings.theme.selectionStrokeColor = .white // 선택 표시 색상 (Circle)
        presentImagePicker(self.imagePicker,
                           select: { (asset) in
            print("Selected: \(asset)")
        }, deselect: { (asset) in
            print("Deselected: \(asset)")
            // 선택 취소하면 arr에서 빼야지
            deSelectedAssets.append(asset)
        }, cancel: { (assets) in
            print("Canceled with selections: \(assets)")
        }, finish: { (assets) in
            print("Finished with selections: \(assets)")
            for i in 0..<deSelectedAssets.count {
                if let index = self.selectedAssets.firstIndex(of: deSelectedAssets[i]) {
                    self.selectedAssets.remove(at: index)
                }
            }
            for i in 0..<assets.count {
                if self.selectedAssets.contains(assets[i]) != true {
                    self.selectedAssets.append(assets[i])
                }
                // 이미 asset이 image에 존재하면 포함하면 안됨..
            }
            
            self.images.removeAll()
            self.imageDataArray.removeAll()
            for i in 0..<self.selectedAssets.count {
                self.convertAssetToImages(image: self.selectedAssets[i])
            }
            print("images count \(self.images.count)")
            self.imageCollectionView.reloadData()
            print("pick finish ", self.selectedAssets.count)
            
            for image in self.images {
                self.imageDataArray.append(image.jpegData(compressionQuality: 0.7)!)
            }
            print("imageData ", self.imageDataArray.count)
        })
        self.imageLabel.text = "\(self.imageDataArray.count)/10"
    }
    
    func convertAssetToImages(image: PHAsset) {
        let imageManager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        var thumbnail = UIImage()
        
        imageManager.requestImage(for: image,
                                  targetSize: CGSize(width: 200, height: 200),
                                  contentMode: .aspectFit,
                                  options: option) { (result, info) in
            thumbnail = result!
        }
        
        let data = thumbnail.jpegData(compressionQuality: 0.7)
        let newImage = UIImage(data: data!)
        self.images.append(newImage! as UIImage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func createButtonTapped(_ sender: Any) {
        WritingBoardViewModel.shared.setImagesArray(imageDataArray ?? [])
        WritingBoardViewModel.shared.setTitleString(self.titleLabel.text!)
        WritingBoardViewModel.shared.setContentString(self.contentTextView.text)
        WritingBoardViewModel.shared.setAnonymous(self.checkboxButton.isSelected)
        WritingBoardViewModel.shared.checkFilled()
    }
}

extension WritingBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let boardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardImageCell", for: indexPath) as? BoardImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        boardCell.imageView?.image = images[indexPath.row]
        boardCell.imageView.contentMode = .scaleAspectFill
        boardCell.imageView.clipsToBounds = true
        
        return boardCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.addView.frame.width
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.section), \(indexPath.row)")
        
        // cell 선택
        // 선택된 cell collectionView에서 삭제 --> images에서 삭제 후 view reload
        
        if let index = self.imagePicker.selectedAssets.firstIndex(of: self.selectedAssets[indexPath.row]) {
            self.imagePicker.deselect(asset: imagePicker.selectedAssets[index])
        }
        images.remove(at: indexPath.row)
        selectedAssets.remove(at: indexPath.row)
        
        print(images.count)
        print(selectedAssets.count)
        
        
        collectionView.reloadData()
    }
    
}

extension WritingBoardViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        /// 플레이스홀더
        if textView == contentTextView {
            contentLabel1.isHidden = true
            contentLabel2.isHidden = true
        }
        if textView.text == "" {
            contentLabel1.isHidden = false
            contentLabel2.isHidden = false
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        /// 플레이스홀더
        if textView == contentTextView {
            contentLabel1.isHidden = true
            contentLabel2.isHidden = true
        }
        if textView.text == "" {
            contentLabel1.isHidden = false
            contentLabel2.isHidden = false
        }
    }
}
