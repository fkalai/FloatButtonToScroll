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

        // Setup you button
        floatButtonToScroll = FloatButtonToScroll()
        
        // Set Image
        floatButtonToScroll.setImage(UIImage(named: "arrow_up"), for: .normal)
        
        // Set backgroundColor
        floatButtonToScroll.backgroundColor = UIColor.lightGray
        floatButtonToScroll.layer.cornerRadius = floatButtonToScroll.frame.height / 2
        
        // Add Delegate
        floatButtonToScroll.delegate = self
        floatButtonToScroll.addObserver(tableView, scrollingTo: .bottom)
        
        // Setup the possition
        floatButtonToScroll.verticalAlignment = .top(topPadding + (self.navigationController?.navigationBar.frame.height ?? 0.0) + 26)
        floatButtonToScroll.horizontalAlignment = .center
        
        // Set your image
        //floatButtonToScroll.setImage(image, for: .normal)
        
        // Setup the contentOffsetY, the default is 220
        // It's abbout to shown after the cell 90 dissapears
        floatButtonToScroll.contentOffsetY =  120
        
        // Add the float Button where you want
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
}

extension DefaultPropertiesViewController: FloatButtonToScrollDelegate {
    
    func didPressBackToTop(_ button: FloatButtonToScroll) {
        
        let topRow = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: topRow, at: .top, animated: true)
    }
}
