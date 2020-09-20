//
//  ViewController.swift
//  FloatButtonToScrollExample
//
//  Created by Fotios Kalaitzidis on 15/9/20.
//  Copyright © 2020 Fotis Kalaitzidis. All rights reserved.
//

import UIKit

public enum FloatButtonCell {
    
    case defaultCase
    case customFrameCase
    case sizeCase
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var sectionDescription: [FloatButtonCell] = []
    
    var list = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSections()
        tableView.reloadData()
    }
    
    func setupSections() {
        
        sectionDescription.removeAll()
        sectionDescription.append(contentsOf: [.defaultCase,
                                               .customFrameCase,
                                               .sizeCase])
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionDescription.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch sectionDescription[section] {
        case .defaultCase:          return 1
        case .customFrameCase:      return 1
        case .sizeCase:             return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch sectionDescription[indexPath.section] {
        case .defaultCase:          return 44
        case .customFrameCase:      return 44
        case .sizeCase:             return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("The dequeued cell is not an instance of TableViewCell.")
        }
        
        switch sectionDescription[indexPath.section] {
        case .defaultCase:
            
            cell.label.text = "Default FloatButton"
            return cell
            
        case .customFrameCase:
            
            cell.label.text = "Custom FloatButton"
            return cell
            
        case .sizeCase:
            
            cell.label.text = "Size FloatButton"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch sectionDescription[indexPath.section] {
        case .defaultCase:
            
            let vc = storyboard.instantiateViewController(withIdentifier: "DefaultPropertiesViewController") as! DefaultPropertiesViewController
            self.present(vc, animated: true, completion: nil)
            
            break
            
        case .customFrameCase:
            
            let vc = storyboard.instantiateViewController(withIdentifier: "CustomFrameViewController") as! CustomFrameViewController
            self.present(vc, animated: true, completion: nil)
            
            break
            
        case .sizeCase:
            
            let vc = storyboard.instantiateViewController(withIdentifier: "SizeToFitViewController") as! SizeToFitViewController
            self.present(vc, animated: true, completion: nil)
            
            break
        }
    }
}
