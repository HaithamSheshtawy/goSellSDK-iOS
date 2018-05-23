//
//  BaseViewController.swift
//  goSellSDK
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import func TapSwiftFixes.performOnMainThread
import enum UIKit.UIApplication.UIInterfaceOrientation
import struct UIKit.UIApplication.UIInterfaceOrientationMask
import class UIKit.NSLayoutConstraint.NSLayoutConstraint
import class UIKit.UIView.UIView
import struct UIKit.UIView.UIViewAnimationOptions
import class UIKit.UIViewController.UIViewController
import var UIKit.UIWindow.UIKeyboardAnimationDurationUserInfoKey
import var UIKit.UIWindow.UIKeyboardFrameEndUserInfoKey

/// Base View Controller.
internal class BaseViewController: UIViewController {
    
    // MARK: - Internal -
    // MARK: Properties
    
    internal override var shouldAutorotate: Bool {
        
        return false
    }
    
    internal override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return .portrait
    }
    
    internal override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        
        return .portrait
    }
    
    // MARK: Methods
    
    internal override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if self.topKeyboardOffsetConstraint != nil || self.bottomKeyboardOffsetConstraint != nil {
            
            self.addKeyboardObserver()
        }
    }
    
    internal override func viewDidDisappear(_ animated: Bool) {
        
        if self.topKeyboardOffsetConstraint != nil || self.bottomKeyboardOffsetConstraint != nil {
            
            self.removeKeyboardObserver()
        }
        super.viewDidDisappear(animated)
    }
    
    internal func performAdditionalAnimationsAfterKeyboardLayoutFinished() { }
    
    // MARK: - Private -
    // MARK: Properties
    
    @IBOutlet private weak var topKeyboardOffsetConstraint: NSLayoutConstraint?
    @IBOutlet private weak var bottomKeyboardOffsetConstraint: NSLayoutConstraint?
    
    // MARK: Methods
    
    private func addKeyboardObserver() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: .UIKeyboardWillChangeFrame,
                                               object: nil)
    }
    
    private func removeKeyboardObserver() {
        
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIKeyboardWillChangeFrame,
                                                  object: nil)
    }
    
    @objc private func keyboardWillChangeFrame(_ notification: NSNotification) {
        
        performOnMainThread { [weak self] in
            
            guard let strongSelf = self else { return }
            guard let userInfo = notification.userInfo else { return }
            
            guard let window = strongSelf.view.window else { return }
            guard var endKeyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            
            endKeyboardFrame = window.convert(endKeyboardFrame, to: strongSelf.view)
            
            let screenSize = window.bounds.size
            
            let keyboardIsShown = screenSize.height > endKeyboardFrame.origin.y
            let offset = keyboardIsShown ? endKeyboardFrame.size.height : 0.0
            
            let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.0
            let animationOptions: UIViewAnimationOptions = [
                
                .beginFromCurrentState,
                keyboardIsShown ? .curveEaseOut : .curveEaseIn
            ]
            
            let animations = { [weak strongSelf] in
                
                guard let strongerSelf = strongSelf else { return }
                
                strongerSelf.topKeyboardOffsetConstraint?.constant = -offset
                strongerSelf.bottomKeyboardOffsetConstraint?.constant = offset
                
                strongerSelf.view.layout()
                
                strongerSelf.performAdditionalAnimationsAfterKeyboardLayoutFinished()
            }
            
            UIView.animate(withDuration: animationDuration, delay: 0.0, options: animationOptions, animations: animations, completion: nil)
        }
    }
}
