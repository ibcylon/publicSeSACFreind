//
//  MyPageDetail.swift
//  SLP
//
//  Created by Kanghos on 2022/02/04.
//

import UIKit
import SnapKit

final class MyPageCell: UITableViewCell {
    
    static let identifier = "MyPageCell"
    
    var title: UILabel!
    var icon: UIImageView!
    var chevron: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
           fatalError("no storyboard used!")
       }

       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupConstraints()
       }
    
    private func setupConstraints() {
        title = UILabel(frame: .zero)
        title.font = UIFont.Title1_M16
        icon = UIImageView(frame: .zero)
        chevron = UIImageView(frame: .zero)
        self.contentView.addSubview(title)
        self.contentView.addSubview(icon)
        self.contentView.addSubview(chevron)
        chevron.image = UIImage(named: "more_arrow")
        icon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        title.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        chevron.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
