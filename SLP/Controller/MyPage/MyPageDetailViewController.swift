//
//  MyPageDetail.swift
//  SLP
//
//  Created by Kanghos on 2022/02/05.
//

import UIKit
import SnapKit
import RangeSeekSlider
import RxSwift

final class MyPageDetailViewController: UIViewController {
    
    let mainView = MyPageDetailView()
    var viewModel = MyPageDetailViewModel()
    var disposeBag = DisposeBag()
    var user: UserResponse?
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "정보 관리"
        
        self.mainView.tableView.delegate = self
        self.mainView.tableView.dataSource = self
        self.mainView.tableView.register(AssessViewCell.self, forCellReuseIdentifier: AssessViewCell.identifier)
        self.mainView.tableView.isUserInteractionEnabled = true
        self.mainView.tableView.isScrollEnabled = false
        self.mainView.tableView.reloadData()
        
        self.mainView.bottomView.ageSlider.delegate = self
        
        setLeftArrowButton()
        
        let updateUserInfoBarButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(updateUserInfoBarButtonClicked))
        updateUserInfoBarButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = updateUserInfoBarButton
        self.mainView.bottomView.manButton.addTarget(self, action: #selector(onManButtonClicked), for: .touchUpInside)
        self.mainView.bottomView.womanButton.addTarget(self, action: #selector(onWomanButtonClicked), for: .touchUpInside)
        self.mainView.bottomView.allowSearchSwitch.addTarget(self, action: #selector(allowSearchSwitchValueChanged), for: .valueChanged)
        self.mainView.bottomView.hobbyTextField.addTarget(self, action: #selector(habitTextFieldTextChanged), for: .editingChanged)
        
        let tapRecognizer = ClickListener(target: self, action: #selector(onWithDrawLabelClicked))
        self.mainView.bottomView.withDrawLabel.isUserInteractionEnabled = true
        self.mainView.bottomView.withDrawLabel.addGestureRecognizer(tapRecognizer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getUser { user, _, _ in
            
            guard let user = user else {
                return
            }
            print(user)
            self.mainView.tableView.reloadData()
            
            switch user.gender {
                
            case Gender.male.rawValue:
                self.mainView.bottomView.manButton.configuration = .fillStyle()
                self.mainView.bottomView.womanButton.configuration = .inactiveStyle()
            case Gender.female.rawValue:
                self.mainView.bottomView.manButton.configuration = .inactiveStyle()
                self.mainView.bottomView.womanButton.configuration = .fillStyle()
            default:
                self.mainView.bottomView.manButton.configuration = .inactiveStyle()
                self.mainView.bottomView.womanButton.configuration = .inactiveStyle()
            }
            
            self.mainView.bottomView.hobbyTextField.text = user.hobby
            self.mainView.bottomView.allowSearchSwitch.isOn = user.searchable == 0 ? false : true
            self.viewModel.searchable.accept((user.searchable != 0))
            self.mainView.bottomView.ageRangeLabel.text = "\(user.ageMin) - \(user.ageMax)"
            
            self.mainView.bottomView.ageSlider.selectedMaxValue = CGFloat(user.ageMax)
            self.mainView.bottomView.ageSlider.selectedMinValue = CGFloat(user.ageMin)
            
            self.mainView.bottomView.ageSlider.minValue = 17
            self.mainView.bottomView.ageSlider.maxValue = 65
            
            self.mainView.bottomView.reloadInputViews()
        }
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func withDrawSign() {

    }
    func bind() {
        self.mainView.bottomView.hobbyTextField
            .rx.text.orEmpty
            .asDriver()
            .drive(viewModel.hobby)
            .disposed(by: disposeBag)
        self.mainView.bottomView.allowSearchSwitch.rx.isOn
            .asDriver()
            .drive(viewModel.searchable)
            .disposed(by: disposeBag)
    }
    
    @objc func onManButtonClicked() {
        viewModel.gender.accept(Gender.male)
        self.mainView.bottomView.manButton.configuration = .fillStyle()
        self.mainView.bottomView.womanButton.configuration = .disableStyle()
    }
    
    @objc func onWomanButtonClicked() {
        viewModel.gender.accept(Gender.female)
        
        self.mainView.bottomView.womanButton.configuration = .fillStyle()
        self.mainView.bottomView.manButton.configuration = .disableStyle()
        
    }
    
    @objc func updateUserInfoBarButtonClicked() {
        
    }
    
    @objc func habitTextFieldTextChanged() {
        viewModel.hobby.accept(self.mainView.bottomView.hobbyTextField.text ?? "")
        
    }
    
    @objc func allowSearchSwitchValueChanged(searchSwitch: UISwitch) {
        
    }
    
    @objc func onWithDrawLabelClicked() {
        let alert = UIAlertController(title: "회원탈퇴", message: "정말로 회원 탈퇴를 진행하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
            self.withDrawSign()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
}
extension MyPageDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AssessViewCell.identifier, for: indexPath) as? AssessViewCell else { return UITableViewCell() }
        
        viewModel.userModel?.bind {
            cell.nicknameLabel.text = $0.nick
        }.disposed(by: disposeBag)
        
        cell.layoutIfNeeded()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
}

extension MyPageDetailViewController: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        viewModel.minAge.accept(Int(minValue))
        
        viewModel.maxAge.accept(Int(maxValue))
        self.mainView.bottomView.ageRangeLabel.text = "\(Int(minValue)) - \(Int(maxValue))"
    }
    
}
