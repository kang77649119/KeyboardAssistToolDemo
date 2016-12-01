//
//  UIBarButtonItem+Extension.swift
//  KeyboardAssistToolDemo
//
//  Created by 也许、 on 2016/11/30.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(iconName:String) {
        
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: iconName), for: .normal)
        btn.sizeToFit()
        self.init(customView: btn)
        
    }
    
}
