//
//  EditSchoolViewController.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/17/24.
//

import Foundation
import UIKit
import SafeAreaBrush
import SwiftUI

class EditSchoolViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
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
        label.text = "학교 변경"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var schoolLabel: UILabel = {
        var label = UILabel()
        label.text = "학교"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var schoolNameTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "학교 입력"
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        tf.returnKeyType = .done
        tf.frame.size.height = 40
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var schoolTableView: UITableView = {
        var tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.isHidden = true
        tv.register(UINib(nibName: "SchoolViewCell", bundle: nil), forCellReuseIdentifier: "SchoolViewCell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var certifyLabel: UILabel = {
        var label = UILabel()
        label.text = "학생인증"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cameraImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.borderColor = UIColor(named:"gray")?.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .center
        imageView.image = UIImage(named: "camera")
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var pickImageLabel: UILabel = {
        var label = UILabel()
        label.text = "사진을 선택하세요."
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(named: "gray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageLabel: UILabel = {
        var label = UILabel()
        label.text = "* 학생 인증이 가능 학교에서 발급한 학생증 또는 온라인 학생증의 사진을 제시해주시기 바랍니다."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "gray")
        label.font = UIFont.systemFont(ofSize: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gradeLabel: UILabel = {
        var label = UILabel()
        label.text = "학년선택"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gradeStackView: UIStackView = {
        var stView = UIStackView(arrangedSubviews: [firstGradeButton, secondGradeButton, thirdGradeButton])
        stView.spacing = 10
        stView.axis = .horizontal
        stView.alignment = .fill
        stView.distribution = .fillEqually
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var firstGradeButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("1학년", for: .normal)
        button.backgroundColor = UIColor(named: "lightGray")
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(firstButtonTapped)))
        
        return button
    }()
    
    private lazy var secondGradeButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("2학년", for: .normal)
        button.backgroundColor = UIColor(named: "lightGray")
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(secondButtonTapped)))
        return button
    }()
    
    private lazy var thirdGradeButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("3학년", for: .normal)
        button.backgroundColor = UIColor(named: "lightGray")
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(thirdButtonTapped)))
        return button
    }()
    
    private lazy var schoolRequestDetailButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("신청 내역", for: .normal)
        button.setTitleColor(UIColor(named: "gray"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setUnderline()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var editButton: UIButton = {
        var button = UIButton(type: .custom)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(named: "lightGray")
        button.setTitleColor(.white, for: .normal)
        button.setTitle("수정하기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var schools:[School] = []
    var imagePickerController = UIImagePickerController()
    var userImage: UIImage = UIImage.add
    var imageData : NSData? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutoLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        schoolTableView.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("schoolVC did disappear")
        schoolTableView.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == schoolNameTextField {
            schoolTableView.isHidden = true
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == schoolNameTextField {
            schoolTableView.isHidden = true
        }
        return true
    }
    
    private func configure() {
        view.backgroundColor = .white
        fillSafeArea(position: .top, color: UIColor(named: "main")!, gradient: false)
        view.addSubview(navigationBar)
        view.addSubview(schoolLabel)
        view.addSubview(schoolNameTextField)
        view.addSubview(certifyLabel)
        view.addSubview(cameraImageView)
        view.addSubview(pickImageLabel)
        view.addSubview(imageLabel)
        view.addSubview(gradeLabel)
        view.addSubview(gradeStackView)
        view.addSubview(schoolTableView)
        view.addSubview(schoolRequestDetailButton)
        view.addSubview(editButton)
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            schoolLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            schoolLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            schoolLabel.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 50),
            
            schoolNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            schoolNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            schoolNameTextField.topAnchor.constraint(equalTo: schoolLabel.bottomAnchor, constant: 8),
            
            schoolTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            schoolTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            schoolTableView.topAnchor.constraint(equalTo: schoolNameTextField.bottomAnchor, constant: 0),
            schoolTableView.heightAnchor.constraint(equalToConstant: 200),
            
            certifyLabel.topAnchor.constraint(equalTo: schoolNameTextField.bottomAnchor, constant: 24),
            certifyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            certifyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            cameraImageView.topAnchor.constraint(equalTo: certifyLabel.bottomAnchor, constant: 8),
            cameraImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            cameraImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            cameraImageView.heightAnchor.constraint(equalToConstant: 110),
            
            pickImageLabel.bottomAnchor.constraint(equalTo: cameraImageView.bottomAnchor, constant: -5),
            pickImageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            imageLabel.topAnchor.constraint(equalTo: cameraImageView.bottomAnchor, constant: 4),
            imageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            imageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            gradeLabel.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 24),
            gradeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            gradeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            gradeStackView.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 8),
            gradeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            gradeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            gradeStackView.heightAnchor.constraint(equalToConstant: 40),
            
            schoolRequestDetailButton.topAnchor.constraint(equalTo: gradeStackView.bottomAnchor, constant: 30),
            schoolRequestDetailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            editButton.heightAnchor.constraint(equalToConstant: 40),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            editButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)

            
        ])
    }
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        print("image tapped")
        present(imagePickerController, animated: true)
    }
    
    @objc func firstButtonTapped(_ sender: UIButton) {
        print("first button tapped")
        RegisterViewModel.shared.setIsGradePicked(true)
        firstGradeButton.isSelected = true
        if firstGradeButton.isSelected == true {
            print("first \(firstGradeButton.isSelected)")
            print("second \(secondGradeButton.isSelected)")
            print("third \(thirdGradeButton.isSelected)")
            
            firstGradeButton.backgroundColor = UIColor(named: "main")
            secondGradeButton.backgroundColor = UIColor(named: "lightGray")
            thirdGradeButton.backgroundColor = UIColor(named: "lightGray")
            RegisterViewModel.shared.setGrade("HIGH_FIRST")
            firstGradeButton.isSelected = false
        }
        else {
            print("first \(firstGradeButton.isSelected)")
            print("second \(secondGradeButton.isSelected)")
            print("third \(thirdGradeButton.isSelected)")
            firstGradeButton.isSelected = true
        }
    }
    
    @objc func secondButtonTapped(_ sender: UIButton) {
        print("second button tapped")
        RegisterViewModel.shared.setIsGradePicked(true)
        secondGradeButton.isSelected = true
        if secondGradeButton.isSelected == true {
            print("first \(firstGradeButton.isSelected)")
            print("second \(secondGradeButton.isSelected)")
            print("third \(thirdGradeButton.isSelected)")
            firstGradeButton.backgroundColor = UIColor(named: "lightGray")
            secondGradeButton.backgroundColor = UIColor(named: "main")
            thirdGradeButton.backgroundColor = UIColor(named: "lightGray")
            RegisterViewModel.shared.setGrade("HIGH_SECOND")
            secondGradeButton.isSelected = false
        }
        else {
            print("first \(firstGradeButton.isSelected)")
            print("second \(secondGradeButton.isSelected)")
            print("third \(thirdGradeButton.isSelected)")
            secondGradeButton.isSelected = true
        }
    }
    
    @objc func thirdButtonTapped(_ sender: UIButton) {
        print("third button tapped")
        RegisterViewModel.shared.setIsGradePicked(true)
        thirdGradeButton.isSelected = true
        if thirdGradeButton.isSelected == true {
            print("first \(firstGradeButton.isSelected)")
            print("second \(secondGradeButton.isSelected)")
            print("third \(thirdGradeButton.isSelected)")
            firstGradeButton.backgroundColor = UIColor(named: "lightGray")
            secondGradeButton.backgroundColor = UIColor(named: "lightGray")
            thirdGradeButton.backgroundColor = UIColor(named: "main")
            RegisterViewModel.shared.setGrade("HIGH_THIRD")
            thirdGradeButton.isSelected = false
        }
        else {
            print("first \(firstGradeButton.isSelected)")
            print("second \(secondGradeButton.isSelected)")
            print("third \(thirdGradeButton.isSelected)")
            thirdGradeButton.isSelected = true
        }
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        self.schools.removeAll()
        if schoolNameTextField.text!.count == 0 {
            // 입력 없을 시
            self.schools.removeAll()
        }
        else {
            schoolTableView.isHidden = false
            print("schoolTF editing changed")
            RegisterViewModel.shared.setSchoolName(textField.text ?? "")
            RegisterViewModel.shared.setIsSchoolNameFilled(false)
        }
        RegisterViewModel.shared.onSchoolResult = { schoolsArr in
            print(schoolsArr.count)
            self.schools = schoolsArr
            if self.schools.count == 0 {
                self.schools.removeAll()
            }
            print("in VC 1 ", self.schools.count)
            self.schoolTableView.reloadData()

        }

        print("in VC 2 ", schools.count)
        self.schoolTableView.reloadData()

    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width // 새 이미지 확대/축소 비율
        let newHeight = image.size.height * scale

        print(newHeight)
        print(newWidth)
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.draw(in: CGRectMake(0, 0, newWidth, newHeight))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return image }
        UIGraphicsEndImageContext()

        print("화면 배율: \(UIScreen.main.scale)")// 배수
        print("origin: \(image), resize: \(newImage)")
//        cameraImageView.image = newImage
        return newImage
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension EditSchoolViewController: UIImagePickerControllerDelegate {
    //이미지가 지정되었을 때 호출되는 델리게이트 메소드를 만들어줍니다.
    // picker : 우리가 실행한 UIImagePickerController입니다.
    // info : 카메라로 찍은 소스 이미지입니다. 타입은 Any입니다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.imagePickerController.dismiss(animated: true)
        // 선택된 이미지(소스)가 없을수도 있으니 옵셔널 바인딩해주고, 이미지가 선택된게 없다면 오류를 발생시킵니다.
        guard let userPickedImage = info[.originalImage] as? UIImage else {
            fatalError("선택된 이미지를 불러오지 못했습니다 : userPickedImage의 값이 nil입니다. ")
            
            
        }
            userImage = resizeImage(image: userPickedImage, newWidth: cameraImageView.frame.width)
        self.cameraImageView.image = userImage
        RegisterViewModel.shared.setIsImagePicked(true)
        
        //화질 떨어트리기
            imageData = userImage.jpegData(compressionQuality: 0.7) as NSData?
        RegisterViewModel.shared.imageData = imageData
    }
}

extension EditSchoolViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("school count : \(schools.count)")
        return schools.count
    }
    
    // TableView Cell의 Object
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("in table")
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolViewCell", for: indexPath)as? SchoolViewCell else{
            print("cell error")
            return .init()
        }
        
        cell.generateCell(school: schools[indexPath.item])

        print("print cell index \(cell.index)")
                
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택 : \(indexPath)")
        print("선택1 : \(schools[indexPath.item].schoolName)")
        print("선택1 : \(schools[indexPath.item].address)")

        schoolTableView.deselectRow(at: indexPath, animated: true)
        schoolNameTextField.text = schools[indexPath.item].schoolName
        schoolTableView.isHidden = true
        RegisterViewModel.shared.setSchoolName(schools[indexPath.item].schoolName)
        RegisterViewModel.shared.setIsSchoolNameFilled(true)
        RegisterViewModel.shared.setSchoolId(schools[indexPath.item].schoolId)
    }
}


struct PreView: PreviewProvider {
    static var previews: some View {
        EditSchoolViewController().toPreview()
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
                Preview(viewController: self)
        }
}
#endif




