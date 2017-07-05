//
//  VAAnimatedNavigationTitleView.swift
//  VAExpandingNavMenu
//
//  Created by Vaibhav Aggarwal on 6/29/17.
//  Copyright © 2017 Vaibhav. All rights reserved.
//

import Foundation

public class VAAnimatedNavigationTitleView: UIView {
  
  let arrowImage: UIImageView = UIImageView(image: UIImage(named: "ic_keyboard_arrow_down_white.png"))
  let titleLabel: UILabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func setTitle(title: String) {
    self.titleLabel.text = title
  }
  
  internal func setup() {
  
    self.addSubview(self.arrowImage)
    self.addSubview(self.titleLabel)
    self.titleLabel.numberOfLines = 2
    self.titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
    self.titleLabel.textColor = UIColor.white
    self.arrowImage.translatesAutoresizingMaskIntoConstraints = false
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
    self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
    self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 12).isActive = true
    self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
    self.arrowImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.arrowImage.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
    self.arrowImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
    self.arrowImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
    
  }
}
