//
//  IANotificationBar.swift
//  MySwaasthNew
//
//  Created by preeti rani on 03/05/17.
//  Copyright © 2017 Innotical. All rights reserved.
//

import Foundation
import UIKit

class IANotificationBar:UIVisualEffectView{
    let SCREEN_WIDTH = UIScreen.main.bounds.width
    static let sharedInstance = IANotificationBar.init(effect: UIBlurEffect.init(style: UIBlurEffectStyle.light))
    static let frameOfView = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
    var animatedDuration:Int! = 0
    let keyWindow = UIApplication.shared.keyWindow
    typealias completionBlock = ((Bool) -> Void)?
    private var timer:Timer?
    var callBack:((Bool) -> Void)?
    private var title:String?
    private var descriptionn:String?
    public var profileImage:UIImage?{
        didSet{
            if let image = self.profileImage{
                self.profileImageView.image = image
            }
        }
    }
    
    private let profileImageView:UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: 8, y: 25, width: 40, height: 40))
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 56, y:25, width: self.SCREEN_WIDTH - 76, height: 20))
        label.font = UIFont.init(name: "Helvetica Neue", size: 13)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var descriptionLabel:UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 56, y: 45, width: self.SCREEN_WIDTH - 84, height: 55))
        label.textColor = .lightGray
        label.font = UIFont.init(name: "Helvetica Neue", size: 11)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bottomLayer:UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 99, width: self.SCREEN_WIDTH, height: 0.5))
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        self.timer = Timer.init()
        self.frame = CGRect.init(x: 0, y: -100, width: SCREEN_WIDTH - 0, height: 100)
        self.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.handleTap(tap:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showMessage(title:String?,description:String?,completion:completionBlock?) {
        IANotificationBar.sharedInstance.addSubview(profileImageView)
        IANotificationBar.sharedInstance.addSubview(titleLabel)
        IANotificationBar.sharedInstance.addSubview(descriptionLabel)
        IANotificationBar.sharedInstance.addSubview(bottomLayer)
        self.titleLabel.text = self.title
        self.descriptionLabel.text = self.descriptionn
        keyWindow?.addSubview(IANotificationBar.sharedInstance)
        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            IANotificationBar.sharedInstance.frame = IANotificationBar.frameOfView
        }) { (completedAnimation) in
            self.animatedDuration = 0
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.observeValueOfTimer), userInfo: nil, repeats: true)
        }
    }
    
    func showMessage(title:String?,description:String?){
        self.title = title
        self.descriptionn = description
        self.hideBarView(isShown: true)
        self.callBack = nil
    }
    
    func showMessagewithHandler(title:String?,description:String?, completionHandler: completionBlock){
        self.title = title
        self.descriptionn = description
        self.callBack = completionHandler
        self.hideBarView(isShown: true)
    }
    
    @objc private func handleTap(tap:UITapGestureRecognizer){
        self.callBack?(true)
        self.hideBarView(isShown: false)
    }
    
    private func hideBarView(isShown:Bool){
        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            IANotificationBar.sharedInstance.frame = CGRect.init(x: 0, y: -100, width: self.SCREEN_WIDTH, height: 100)
        }) { (completedAnimation) in
            self.animatedDuration = 0
            self.timer?.invalidate()
            self.timer = nil
            IANotificationBar.sharedInstance.removeFromSuperview()
            self.profileImageView.removeFromSuperview()
            self.titleLabel.removeFromSuperview()
            self.descriptionLabel.removeFromSuperview()
            if isShown{
                self.showMessage(title: self.title, description: self.description, completion: self.callBack)
            }
        }
    }
    
    @objc private func observeValueOfTimer(){
        self.animatedDuration = animatedDuration + 1
        if animatedDuration == 5{
            self.animatedDuration = 0
            self.timer?.invalidate()
            self.timer = nil
            self.hideBarView(isShown: false)
        }
    }
    
}
