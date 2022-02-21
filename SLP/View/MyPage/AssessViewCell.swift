//
//  AssessView.swift
//  SLP
//
//  Created by Kanghos on 2022/02/08.
//

import UIKit
import SnapKit
import Then

struct BadgeState {
    let title: String
    let isOn: Bool
}

final class AssessViewCell: UITableViewCell, ViewRepresentable {
    
    static let identifier = "AssessViewCell"
    
    let nicknameLabel = UILabel()
    let toggleButton = UIButton()
    
    let stackView = UIStackView()
    let titleContainerView = UIView()
    let sesacTitleLabel = UILabel()
    
    var collectionView: UICollectionView!
    
    let reviewLabel = UILabel()
    let reviewTextView = UITextView()
    var sesacTitles: [BadgeState] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        sesacTitles = [
            BadgeState(title: "좋은 매너", isOn: false),
            BadgeState(title: "정확한 시간 약속", isOn: false),
            BadgeState(title: "빠른 응답", isOn: false),
            BadgeState(title: "친절한 성격", isOn: false),
            BadgeState(title: "능숙한 취미 실력", isOn: false),
            BadgeState(title: "유익한 시간", isOn: false)
            
        ]
        
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.gray2?.cgColor
        self.layer.borderWidth = 1
        
        nicknameLabel.textColor = .black
        nicknameLabel.font = .Title1_M16
        
        sesacTitleLabel.textColor = .black
        sesacTitleLabel.font = .Title6_R12
        sesacTitleLabel.text = "새싹 타이틀"

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 8
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SesacTitleCell.self, forCellWithReuseIdentifier: SesacTitleCell.identifier)
        collectionView.isScrollEnabled = false

        reviewLabel.textColor = .black
        reviewLabel.font = .Title6_R12
        reviewLabel.text = "새싹 리뷰"
        
        reviewTextView.textColor = .gray6
        reviewTextView.font = .Body3_R14
        reviewTextView.text = "첫 리뷰를 기다리는 중이에요\ndasfasdf\nasdfdsaf\nasdfasd"
        reviewTextView.isEditable = false
        
        stackView.axis = .vertical
        stackView.distribution = .fill
    }
    
    private func setupConstraints() {
        [nicknameLabel, toggleButton, reviewLabel, reviewTextView, stackView].forEach {
            addSubview($0)
        }
        stackView.addArrangedSubview(titleContainerView)
        titleContainerView.addSubview(sesacTitleLabel)
        titleContainerView.addSubview(collectionView)
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(toggleButton.snp.leading).inset(16)
            
        }
        
        toggleButton.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(160)
        }
        
        sesacTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sesacTitleLabel.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            
        }
        
        reviewTextView.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            
        }
    }
}

extension AssessViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SesacTitleCell.identifier, for: indexPath) as? SesacTitleCell
        else { return UICollectionViewCell() }
        
        let badge = sesacTitles[indexPath.row]
        
        if badge.isOn {
            cell.badge.configuration = .fillStyle()
            cell.badge.configuration?.title = badge.title
        } else {
            cell.badge.configuration = .inactiveStyle()
            cell.badge.configuration?.title = badge.title
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let inset: CGFloat = 16
        let padding: CGFloat = 16
        let spacing: CGFloat = 8
        let width = (UIScreen.main.bounds.width - (inset * 2) - (padding * 2) - spacing - 5) / 2
        return CGSize(width: width, height: 32)
    }
}
