//
//  MyPageDetail.swift
//  SLP
//
//  Created by Kanghos on 2022/02/04.
//

import UIKit
import SnapKit

final class MyPageDetailView: UIView, ViewRepresentable {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let backgroundView = BackgourndView()
    
    let tableView = UITableView()
    let settingView = UIView()
    let bottomView = MyPageBottomView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        
        
        bottomView.backgroundColor = .white
        
        scrollView.backgroundColor = .white
        contentView.backgroundColor = .white
    }
    
    func setupConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        [backgroundView, tableView, bottomView].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(310)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    
}
