//
//  CustomFrameViewController.swift
//  FloatButtonToScrollExample
//
//  Created by Fotios Kalaitzidis on 20/9/20.
//  Copyright © 2020 Fotis Kalaitzidis. All rights reserved.
//

import UIKit
import FloatButtonToScroll

class CustomFrameViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var floatButtonToScroll: FloatButtonToScroll!
    
    var list = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var bottomPadding: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            
            if let bPadding = window?.safeAreaInsets.bottom {
                bottomPadding = bPadding
            }
        }

        for i in 0...200 {
            
            list.append(i)
        }
        
        // Setup you button
        let frame = CGRect(x: 0, y: 0, width: 58, height: 32)
        floatButtonToScroll = FloatButtonToScroll(frame: frame)
        
        // Set Image
        floatButtonToScroll.setImage(UIImage(named: "arrow_down"), for: .normal)
        
        // Add Delegate
        floatButtonToScroll.delegate = self
        
        // Setup the possition
        floatButtonToScroll.verticalAlignment = .bottom(bottomPadding + 28)
        floatButtonToScroll.horizontalAlignment = .right(10)
        
        // Customize your button with the default proccess
        floatButtonToScroll.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        floatButtonToScroll.layer.cornerRadius = floatButtonToScroll.frame.height / 2
        floatButtonToScroll.layer.masksToBounds = true
                
        // Add the float Button where you want
        floatButtonToScroll.addToView(self.view)
        
        tableView.reloadData()
        tableView.scrollTableViewToBottom(animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        floatButtonToScroll.contentOffsetY = tableView.contentOffset.y - (6 * 45)
    }
}

extension CustomFrameViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("The dequeued cell is not an instance of TableViewCell.")
        }
        
        if indexPath.row % 2 == 0 {
            
            cell.label.textAlignment = .left
            cell.label.text = "\(self.list[indexPath.row]): a meesage"
        }
        else {
            
            cell.label.textAlignment = .right
            cell.label.text = "\(self.list[indexPath.row]): my replay"
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        floatButtonToScroll.scrollViewDidScroll(scrollView, scrollingTo: .top)
    }
}

extension CustomFrameViewController: FloatButtonToScrollDelegate {
    
    func didPressBackToTop(_ button: FloatButtonToScroll) {
        
        tableView.scrollTableViewToBottom(animated: true)
    }
}

extension UITableView {
    func scrollTableViewToBottom(animated: Bool) {
        guard let dataSource = dataSource else { return }

        var lastSectionWithAtLeasOneElements = (dataSource.numberOfSections?(in: self) ?? 1) - 1

        while dataSource.tableView(self, numberOfRowsInSection: lastSectionWithAtLeasOneElements) < 1 {
            lastSectionWithAtLeasOneElements -= 1
        }

        let lastRow = dataSource.tableView(self, numberOfRowsInSection: lastSectionWithAtLeasOneElements) - 1

        guard lastSectionWithAtLeasOneElements > -1 && lastRow > -1 else { return }

        let bottomIndex = IndexPath(item: lastRow, section: lastSectionWithAtLeasOneElements)
        scrollToRow(at: bottomIndex, at: .bottom, animated: animated)
    }
}
