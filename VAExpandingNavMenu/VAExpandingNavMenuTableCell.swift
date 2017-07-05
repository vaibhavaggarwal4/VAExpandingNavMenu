//
//  VAExpandingNavMenuTableCell.swift
//  VAExpandingNavMenu
//
//  Created by Vaibhav Aggarwal on 6/29/17.
//  Copyright © 2017 Vaibhav. All rights reserved.
//

import Foundation

class VAExpandingNavMenuTableCell: UITableViewCell {
  
  fileprivate let titleLabel: UILabel = UILabel()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  internal func setup() {
    self.backgroundColor = UIColor.clear
    self.contentView.addSubview(self.titleLabel)
    self.titleLabel.numberOfLines = 2
    self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
    self.titleLabel.textColor = UIColor.white
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
    self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25).isActive = true
    self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 20).isActive = true
    self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
    self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20).isActive = true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    let view: UIView = UIView()
    view.backgroundColor = UIColor.clear
    self.selectedBackgroundView = view
  }
  
  public func configure(title: String, font: UIFont?, textColor: UIColor?) {
    self.titleLabel.text = title
    if let color = textColor  {
      self.titleLabel.textColor = color
    }
    if let font = font  {
      self.titleLabel.font = font
    }
    self.contentView.setNeedsLayout()
  }
}
