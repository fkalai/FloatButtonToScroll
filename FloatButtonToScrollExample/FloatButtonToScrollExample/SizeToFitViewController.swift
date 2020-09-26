//
//  SizeToFitViewController.swift
//  FloatButtonToScrollExample
//
//  Created by Fotios Kalaitzidis on 20/9/20.
//  Copyright © 2020 Fotis Kalaitzidis. All rights reserved.
//

import UIKit
import FloatButtonToScroll

class SizeToFitViewController: UIViewController {
    
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

        // Setup Size FloatButtonToScroll will set both height and width to has
        // the same size value
        floatButtonToScroll = FloatButtonToScroll(size: 48)
        
        // Setup an Image the FloatButtonToScroll
        floatButtonToScroll.setImage(UIImage(named: "arrow_up"), for: .normal)
        
        // Setup an Image the FloatButtonToScroll
        // Here I've made something like Viber button
        floatButtonToScroll.backgroundColor = UIColor(red: 102 / 255, green: 92 / 255, blue: 172 / 255, alpha: 1.0)
        floatButtonToScroll.layer.cornerRadius = floatButtonToScroll.frame.height / 2
        floatButtonToScroll.layer.masksToBounds = true
        
        // Setup the possition
        floatButtonToScroll.verticalAlignment = .bottom(bottomPadding + 28)
        floatButtonToScroll.horizontalAlignment = .right(8)
        
        // Setup the contentOffsetY for scrolling, the default is 220
        // it depends when you need the FloatButtonToScroll to show
        floatButtonToScroll.contentOffsetY = 4 * 45 // Cell * CellHeight
        
        // Set the delegate to self for the FloatButtonToScroll Action
        // Or set your own target
        floatButtonToScroll.delegate = self
        
        // Add the float Button where you want
        floatButtonToScroll.setTargetView(view: self.view)
        
        tableView.reloadData()
    }

    func setButtonDone() {
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(dismissTap))
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func dismissTap() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SizeToFitViewController: UITableViewDataSource, UITableViewDelegate {
    
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

extension SizeToFitViewController: FloatButtonToScrollDelegate {
    
    func didPressBackToTop(_ button: FloatButtonToScroll) {
        
        let topRow = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: topRow, at: .top, animated: true)
    }
}
