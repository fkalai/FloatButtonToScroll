//
//  DefaultPropertiesViewController.swift
//  FloatButtonToScrollExample
//
//  Created by Fotios Kalaitzidis on 20/9/20.
//  Copyright © 2020 Fotis Kalaitzidis. All rights reserved.
//

import UIKit
import FloatButtonToScroll

class DefaultPropertiesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var floatButtonToScroll: FloatButtonToScroll!
    
    var list = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var topPadding: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            
            if let tPadding = window?.safeAreaInsets.top {
                topPadding = tPadding
            }
        }
        
        for i in 0...200 {
            
            list.append(i)
        }

        // Setup Default FloatButtonToScroll. The default value for both
        // height and width is 32
        floatButtonToScroll = FloatButtonToScroll()
        
        // Setup an Image the FloatButtonToScroll
        floatButtonToScroll.setImage(UIImage(named: "arrow_up"), for: .normal)
        
        // Setup the backgroundColor if needed
        floatButtonToScroll.backgroundColor = UIColor.lightGray
        floatButtonToScroll.layer.cornerRadius = floatButtonToScroll.frame.height / 2
        
        // Setup the position. With the below settings the FloatButtonToScroll
        // Will appear on the top/center of the View.
        // Does not need to add any Constraints because the constraints will be
        // set after the addToView(_ view: UIView) is called.
        floatButtonToScroll.verticalAlignment = .top(topPadding + (self.navigationController?.navigationBar.frame.height ?? 0.0) + 26)
        floatButtonToScroll.horizontalAlignment = .center
        
        // Setup the contentOffsetY for scrolling, the default is 220
        // it depends when you need the FloatButtonToScroll to show
        floatButtonToScroll.contentOffsetY =  120
        
        // Set the delegate to self for the FloatButtonToScroll Action
        // Or set your own target
        floatButtonToScroll.delegate = self
        
        // Finally with addToView() we say the FloatButtonToScroll in which view
        // will be added as a subview
        floatButtonToScroll.addToView(self.view)
        
        tableView.reloadData()
    }
}

extension DefaultPropertiesViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        cell.label.text = "Cell Number: \(self.list[indexPath.row])"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        floatButtonToScroll.scrollViewDidScroll(scrollView, scrollingTo: .bottom)
    }
}

extension DefaultPropertiesViewController: FloatButtonToScrollDelegate {
    
    func didPressBackToTop(_ button: FloatButtonToScroll) {
        
        let topRow = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: topRow, at: .top, animated: true)
    }
}
