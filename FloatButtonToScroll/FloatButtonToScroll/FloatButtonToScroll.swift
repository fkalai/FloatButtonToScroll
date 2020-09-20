//
//  FloatButtonToScroll.swift
//  FloatButtonToScroll
//
//  Created by Fotios Kalaitzidis on 13/9/20.
//  Copyright © 2020 Fotis Kalaitzidis. All rights reserved.
//
//  Licensed under the terms of the MIT license:
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

// MARK: - ♳ Type definitions

/// An abstract protocol that defines the position
protocol Alignment {}

/// Defines a horizontal alignment for UI element
public enum HorizontalAlignment: Alignment {
    
    case left(CGFloat)
    case right(CGFloat)
    case center
    case custom
}

/// Defines a vertical alignment for UI element
public enum VerticalAlignment: Alignment {
    
    case top(CGFloat)
    case bottom(CGFloat)
    case center
    case custom
}

// MARK: - 🕹 Action Protocol

@objc public protocol FloatButtonToScrollDelegate {
    
    func didPressBackToTop(_ button: FloatButtonToScroll)
}

// MARK: - Float ButtonToScroll

/// A `UIButton` subclass that gives you the power to set very
/// easily a Button with an action to Scroll to Top or Bottom as
/// `Viber` and `WhatsApp` do.
/// You can easily set it to show on your view for example bottom/right
/// or you can set it to show in a custom constraints.
public class FloatButtonToScroll: UIButton {

    // MARK: - 🔸 Properties
    
    public var horizontalAlignment: HorizontalAlignment = .center
    public var verticalAlignment: VerticalAlignment = .top(20)
    
    open weak var delegate: FloatButtonToScrollDelegate?
    fileprivate var verticalPotitionY: CGFloat? = 0.0
    fileprivate weak var view: UIView?
    
    // Constraints
    fileprivate var topConstraint: NSLayoutConstraint?
    fileprivate var bottomConstraint: NSLayoutConstraint?
    fileprivate var centerYConstraint: NSLayoutConstraint?
    fileprivate var centerXConstraint: NSLayoutConstraint?
    fileprivate var leadingConstraint: NSLayoutConstraint?
    fileprivate var trailingConstraint: NSLayoutConstraint?
    fileprivate var heightConstraint: NSLayoutConstraint?
    fileprivate var widthConstraint: NSLayoutConstraint?
    fileprivate var savedConstraints: [NSLayoutConstraint] = []
    
    /// The constraints return func depence on Alignment sets
    private func buttonConstraints() -> [NSLayoutConstraint] {
        
        guard let parent = view else { return [] }
        
        var constraints: [NSLayoutConstraint] = []
        constraints.removeAll()
        
        heightConstraint = self.heightAnchor.constraint(equalToConstant: size)
        widthConstraint = self.widthAnchor.constraint(equalToConstant: size)
        
        switch (horizontalAlignment, verticalAlignment) {
        /// `Bottom` positions
        case (.right(let trailing), .bottom(let bottom)):
            
            trailingConstraint = parent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailing)
            bottomConstraint = parent.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom)
            
            constraints.append(contentsOf: [heightConstraint!,
                                            widthConstraint!,
                                            trailingConstraint!,
                                            bottomConstraint!])
            
            savedConstraints = constraints
            return constraints
            
        case (.left(let leading), .bottom(let bottom)):
            
            trailingConstraint = self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: leading)
            bottomConstraint = parent.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom)
            
            constraints.append(contentsOf: [heightConstraint!,
                                            widthConstraint!,
                                            trailingConstraint!,
                                            bottomConstraint!])
            
            savedConstraints = constraints
            return constraints
            
        case (.center, .bottom):
            
            return constraints
        
        /// `Top` position
        case (.right, .top):
            
            return constraints
            
        case (.left, .top):
            
            return constraints
        case (.center, .top(let top)):
            
            centerXConstraint = self.centerXAnchor.constraint(equalTo: parent.centerXAnchor)
            topConstraint = self.topAnchor.constraint(equalTo: parent.topAnchor, constant: top)
            
            constraints.append(contentsOf: [heightConstraint!,
                                            widthConstraint!,
                                            topConstraint!,
                                            centerXConstraint!])
            savedConstraints = constraints
            return constraints
            
        default: return []
        }
    }
    
    // Setable Variables
    var size: CGFloat = 32.0 {
        
        didSet {
            
            setupSize()
        }
    }
    
    /// Set the contentOffset Y where button will be shown.
    public var contentOffsetY: CGFloat = 220
    
    /**
     Initialize with default property
     */
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        self.alpha = 0
    }
    
    /**
     Initialize with custom size
     */
    public init(size: CGFloat) {
        self.size = size
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        self.alpha = 0
    }
    
    /**
     Initialize with custom frame
     */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        size = min(frame.size.width, frame.size.height)
        self.alpha = 0
    }
    
    public func addToView(_ view: UIView) {
        
        self.view = view
        view.addSubview(self)
        
        self.setImage(UIImage(named: "arrow_up.png", in: Bundle(for: type(of: self)), compatibleWith: nil), for: .normal)
        self.addTarget(self, action: #selector(backToTopButtonTouchUpInside), for: .touchUpInside)
    }
    
    private func addButtonConstraints(_ constraints: [NSLayoutConstraint]) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(buttonConstraints())
    }
        
    deinit {
        
        print("--- dealloc @<BackToTopButton> Does not has Retain Cycle")
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMoveToSuperview() {
        
        guard let _ = view else { return }

        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(buttonConstraints())
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > contentOffsetY {
            
            animatedShow()
        }
        else {
            
            animatedHide()
        }
    }
    
    func setupNSLayoutConstraints(withConstraints constraints: [NSLayoutConstraint]) {
        
        let staticConstraints = [topConstraint, bottomConstraint, centerXConstraint, centerYConstraint].compactMap { $0 }
        
        savedConstraints.append(contentsOf: staticConstraints)
        savedConstraints.append(contentsOf: self.constraints)
        
        NSLayoutConstraint.deactivate(savedConstraints)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        
        savedConstraints = constraints
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
        
        delegate?.didPressBackToTop(self)
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

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
