//
//  MyPageView.swift
//  SLP
//
//  Created by Kanghos on 2022/02/04.
//

import UIKit
import SnapKit

final class MyPageView: UIView, ViewRepresentable {
    
    var tableView = UITableView()
    var header = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.tableView.register(MyPageCell.self, forCellReuseIdentifier: MyPageCell.identifier)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func setupConstraints() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
