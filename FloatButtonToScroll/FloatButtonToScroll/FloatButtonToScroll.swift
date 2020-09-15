//
//  FloatButtonToScroll.swift
//  FloatButtonToScroll
//
//  Created by Fotios Kalaitzidis on 13/9/20.
//  Copyright © 2020 Fotis Kalaitzidis. All rights reserved.
//

import UIKit

protocol FloatButtonToScrollDelegate: NSObjectProtocol {
    func didPressBackToTop()
}

public class FloatButtonToScroll: UIButton {

    weak var delegate: FloatButtonToScrollDelegate?
    fileprivate var verticalPotitionY: CGFloat? = 0.0
    fileprivate weak var parentView: UIView?
    
    fileprivate var topConstraint: NSLayoutConstraint?
    fileprivate var bottomConstraint: NSLayoutConstraint?
    fileprivate var centerYConstraint: NSLayoutConstraint?
    fileprivate var centerXConstraint: NSLayoutConstraint?
    fileprivate var newConstraints: [NSLayoutConstraint] = []
    
    // Setable Variables
    var size: CGFloat = 32.0 {
        
        didSet {
            
            setupSize()
        }
    }
    
    var contentOffsetY: CGFloat = 220
        
    public required init(_ parentView: UIView, verticalPotiotionY: CGFloat) {
        super.init(frame: .zero)
        
        self.parentView = parentView
        self.verticalPotitionY = verticalPotiotionY + 3
        
        self.setImage(UIImage(named: "backToTopArrow"), for: .normal)
        self.addTarget(self, action: #selector(backToTopButtonTouchUpInside), for: .touchUpInside)
        self.alpha = 0
        
        parentView.addSubview(self)
    }
    
    deinit {
        
        print("--- dealloc @<BackToTopButton> Does not has Retain Cycle")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMoveToSuperview() {
        
        guard let parent = parentView, let verticalPotitionY = verticalPotitionY else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        centerXConstraint = self.centerXAnchor.constraint(equalTo: parent.centerXAnchor)
        topConstraint = self.topAnchor.constraint(equalTo: parent.topAnchor, constant: verticalPotitionY)
        NSLayoutConstraint.activate([

            self.heightAnchor.constraint(equalToConstant: size),
            self.widthAnchor.constraint(equalToConstant: size),
            topConstraint!,
            centerXConstraint!
        ])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > contentOffsetY {
            
            animatedShow()
        }
        else {
            
            animatedHide()
        }
    }
    
    func setupNSLayoutConstraints(withConstraints constraints: [NSLayoutConstraint]) {
        
        let staticConstraints = [topConstraint, bottomConstraint, centerXConstraint, centerYConstraint].compactMap { $0 }
        
        newConstraints.append(contentsOf: staticConstraints)
        newConstraints.append(contentsOf: self.constraints)
        
        NSLayoutConstraint.deactivate(newConstraints)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        
        newConstraints = constraints
    }
    
    func setupSize() {
        
        let constraints = self.constraints
        
        for constraint in constraints {
            if constraint.isActive && (constraint.firstAnchor.isEqual(heightAnchor) || constraint.firstAnchor.isEqual(widthAnchor)) {
                
                constraint.constant = size
            }
        }
        
        NSLayoutConstraint.deactivate(self.constraints)
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: Action
    @objc func backToTopButtonTouchUpInside() {
        
        delegate?.didPressBackToTop()
    }
    
    // MARK: Animations
    func animatedShow() {
        
        UIView.animate(withDuration: 0.6) {

            self.alpha = 1
        }
    }
    
    func animatedHide() {
        
        UIView.animate(withDuration: 0.6) {
            
            self.alpha = 0
        }
    }
}
