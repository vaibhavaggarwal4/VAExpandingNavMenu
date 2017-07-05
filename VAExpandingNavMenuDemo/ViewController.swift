//
//  ViewController.swift
//  VAExpandingNavMenuDemo
//
//  Created by Vaibhav Aggarwal on 6/27/17.
//  Copyright © 2017 Vaibhav. All rights reserved.
//

import UIKit
import VAExpandingNavMenu

class ViewController: UIViewController {
  
  var expandingMenu: VAExpandingNavMenu?
  let titleButton: UIButton =  UIButton(type: UIButtonType.custom)
  let imageView: UIImageView =  UIImageView()
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.lightGray
    titleButton.translatesAutoresizingMaskIntoConstraints = false
    titleButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
    titleButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    titleButton.backgroundColor = UIColor.blue
    titleButton.setTitle("Expanding menu!", for: .normal)
    titleButton.addTarget(self, action: #selector(ViewController.buttonTapped), for: .touchUpInside)
    self.navigationItem.titleView = titleButton
    
    self.view.addSubview(self.imageView)
    self.imageView.image = UIImage(named: "bg")
    self.imageView.translatesAutoresizingMaskIntoConstraints = false
    self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    self.imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    self.imageView.contentMode = .scaleAspectFill
    
  }
  

  func buttonTapped() {
  
    if let _ = self.expandingMenu, self.expandingMenu!.isPresented {
      self.expandingMenu?.dismiss {
        
      }
      return
    }
    
    // create rows
    let row1 = VAExpandingNavMenuRowProtocol(title: "San Francisco", iconImage: nil) {
      self.titleButton.setTitle("San Francisco", for: .normal)
      self.fadeInImageWithName(name: "SF")
    }
    
    let row2 = VAExpandingNavMenuRowProtocol(title: "Sydney", iconImage: nil) {
      self.titleButton.setTitle("Sydney", for: .normal)
      self.fadeInImageWithName(name: "Sydney")
    }
    
    let row3 = VAExpandingNavMenuRowProtocol(title: "Shanghai", iconImage: nil) {
      self.titleButton.setTitle("Shanghai", for: .normal)
      self.fadeInImageWithName(name: "Shanghai")
    }
    
    let row4 = VAExpandingNavMenuRowProtocol(title: "New Delhi", iconImage: nil) {
      self.titleButton.setTitle("New Delhi", for: .normal)
      self.fadeInImageWithName(name: "Delhi")
    }
    
    
    // present the menu with the rows
    self.expandingMenu = VAExpandingNavMenu(rows: [row1, row2, row3, row4])
    self.expandingMenu?.present(inViewController: self, withCompletion: {})
    
  }
  
  func fadeInImageWithName(name: String) {
    self.imageView.alpha = 0.2
    self.imageView.image = UIImage(named: name)
    UIView.animate(withDuration: 0.4, animations: {
      self.imageView.alpha = 1.0
    }) { (success) in
      
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

