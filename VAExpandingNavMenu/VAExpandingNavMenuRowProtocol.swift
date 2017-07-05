//
//  VAExpandingNavMenuRowProtocol.swift
//  VAExpandingNavMenu
//
//  Created by Vaibhav Aggarwal on 6/27/17.
//  Copyright © 2017 Vaibhav. All rights reserved.
//

import Foundation

/// Helper struct to enable consistent design and data handling.
/// Use this as a wrapper object, to provide UI values without giving it the knowledge 
/// of the underlying object
public struct VAExpandingNavMenuRowProtocol {
  public let title: String
  public let iconImage: UIImage?
  public let didSelectClosure: (()-> Void)
  
  public init(title: String, iconImage: UIImage?, didSelectClosure: @escaping (() -> Void)) {
    self.title = title
    self.iconImage = iconImage
    self.didSelectClosure = didSelectClosure
  }
}
