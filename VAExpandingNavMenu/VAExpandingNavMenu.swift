//
//  VAExpandingNavMenu.swift
//  VAExpandingNavMenu
//
//  Created by Vaibhav Aggarwal on 6/27/17.
//  Copyright © 2017 Vaibhav. All rights reserved.
//

import Foundation
import UIKit

/// Holds variables to with UI configuration
public struct ExpandingMenuConfigurator {
  var titleFont: UIFont?
  var titleTextColor: UIColor?
}


/// A subclass of UIViewController that configures, presents and manages the lifecycle for the expanding menu
public class VAExpandingNavMenu: UIViewController {
  

  fileprivate var configuration: ExpandingMenuConfigurator?
  fileprivate let tableView: UITableView = UITableView()
  fileprivate var rows: [VAExpandingNavMenuRowProtocol] = [VAExpandingNavMenuRowProtocol]()
  fileprivate weak var viewController: UIViewController?
  
  // Asserts weather the menu is being currently presented
  public var isPresented: Bool = true
  
  // If set to false, menu will not dismiss automatically
  public var dismissOnCellTap: Bool = true
  
  public init(rows: [VAExpandingNavMenuRowProtocol]) {
    self.rows = rows
    super.init(nibName: nil, bundle: nil)
  }
  
  /// Configures the menu with set parameters as defined in ExpandingMenuConfigurator
  public func configure(_ configuration: ExpandingMenuConfigurator) {
    self.configuration = configuration
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
  }
  
  internal func setup() {
    self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    self.view.clipsToBounds = true
    self.tableView.backgroundColor = UIColor.clear
    self.tableView.separatorStyle = .none
    self.tableView.tableFooterView = nil
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(self.tableView)
    self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    
    // cell setup
    self.tableView.register(VAExpandingNavMenuTableCell.self, forCellReuseIdentifier: "VAExpandingNavMenuTableCell")
    self.tableView.estimatedRowHeight = 60
    self.tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  override public func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    if self.isPresented {
      var frame = self.view.frame
      guard let vc = self.viewController else { return }
      frame.size.height = vc.view.frame.size.height * 2/3
      self.view.frame = frame
    }
  }
  
  //MARK: - Present and dismiss
  
  /// Present the expanding menu from the nav bar
  public func present(inViewController viewController: UIViewController, withCompletion: (() -> Void)) {
    self.viewController = viewController
    viewController.addChildViewController(self)
    viewController.view.addSubview(self.view)
    self.didMove(toParentViewController: viewController)
    self.view.frame = CGRect(x: 0, y: 0, width: viewController.view.frame.size.width, height: 0)
    var frame = self.view.frame
    frame.size.height = viewController.view.frame.size.height * 2/3
    UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: [.curveEaseInOut, .allowUserInteraction], animations: {
      self.view.frame = frame
    }, completion: nil)
    self.isPresented = true
  }
  
  /// Dismisses the expanding menu from the nav bar
  public func dismiss(withCompletion: (() -> Void)) {
    
    UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction], animations: {
      self.view.frame.size.height = 0

    }) { (success) in
      self.willMove(toParentViewController: nil)
      self.view.removeFromSuperview()
      self.removeFromParentViewController()
    }
    self.isPresented = false
  }
}

// MARK: -  Tableview datasource and delegate
extension VAExpandingNavMenu: UITableViewDataSource, UITableViewDelegate {

  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.rows.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: "VAExpandingNavMenuTableCell") as? VAExpandingNavMenuTableCell {
      if self.rows.count > indexPath.row {
        let row: VAExpandingNavMenuRowProtocol = self.rows[indexPath.row]
        var textFont: UIFont?
        var textColor: UIColor?
        if let font = self.configuration?.titleFont {
          textFont = font
        }
        if let color = self.configuration?.titleTextColor {
          textColor = color
        }
        cell.configure(title: row.title, font: textFont, textColor: textColor)
        return cell
      }
    }
    
    // fallback on dummy
    let cell = UITableViewCell(style: .default, reuseIdentifier: "dummy")
    cell.textLabel?.text = self.rows[indexPath.row].title
    cell.backgroundColor = UIColor.clear
    return cell
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if self.rows.count > indexPath.row {
      let row: VAExpandingNavMenuRowProtocol = self.rows[indexPath.row]
      row.didSelectClosure()
      if self.dismissOnCellTap {
        self.dismiss {}
      }
    }
  }
}
