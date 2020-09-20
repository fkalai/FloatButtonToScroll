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
        
        for i in 0...200 {
            
            list.append(i)
        }

        // Setup you button
        floatButtonToScroll = FloatButtonToScroll()
        
        // Add Delegate
        floatButtonToScroll.delegate = self
        
        // Setup the possition
        floatButtonToScroll.verticalAlignment = .bottom(80)
        floatButtonToScroll.horizontalAlignment = .right(12)
        
        // Setup the contentOffsetY, the default is 220
        // It's abbout to shown after the cell 90 dissapears
        floatButtonToScroll.contentOffsetY = CGFloat(((list.count / 2) - 10) * 45) // 100 * cell height
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        floatButtonToScroll.scrollViewDidScroll(scrollView)
    }
}

extension DefaultPropertiesViewController: FloatButtonToScrollDelegate {
    
    func didPressBackToTop(_ button: FloatButtonToScroll) {
        
        print("Go to Scroll")
    }
}
