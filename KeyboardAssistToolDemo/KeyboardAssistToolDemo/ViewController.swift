//
//  ViewController.swift
//  KeyboardAssistToolDemo
//
//  Created by 也许、 on 2016/11/30.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

let screenW = UIScreen.main.bounds.width
let screenH = UIScreen.main.bounds.height

class ViewController: UIViewController {
    
    // textView
    lazy var textView:UITextView = {
        
        let textView:UITextView = UITextView(frame: CGRect(x: 0, y: 20, width: screenW, height: screenH - 20))
        textView.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        textView.delegate = self
        // 设置垂直方向可拖动
        textView.alwaysBounceVertical = true
        textView.keyboardDismissMode = .onDrag
        return textView
    
    }()
    
    // 占位符label
    lazy var placeHolderLabel:UILabel = {
        
        let label:UILabel = UILabel(frame: CGRect(x: 5, y: 0, width: screenW - 10, height: 30))
        label.textColor = UIColor.darkGray
        label.text = "请输入内容"
        return label
 
    }()
    
    // toolBar的约束
    var toolBarConstant:NSLayoutConstraint?
    
    // toolBar
    lazy var toolBar:UIToolbar = {
        
        let toolBar:UIToolbar = UIToolbar()
        
        var items:[UIBarButtonItem] = []
        
        let itemsInfo:[String] = ["compose_addbutton_background", "compose_camerabutton_background", "compose_trendbutton_background", "compose_toolbar_video"]
        
        for item in itemsInfo {
            items.append(UIBarButtonItem(iconName: item))
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        toolBar.items = items
        
        return toolBar
    
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 接收键盘位置改变的通知
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // 初始化UI
        setupUI()
        
    }

}

extension ViewController {

    // 初始化UI
    func setupUI() {
    
        // 添加textView
        self.view.addSubview(textView)
        
        // 添加占位label
        textView.addSubview(placeHolderLabel)
        
        // 添加toolBar
        self.view.addSubview(toolBar)
        // toolBar布局
        let cons = toolBar.xmg_AlignInner(type: .BottomLeft, referView: self.view, size: CGSize(width: screenW, height: 44))
        // 获取toolBar底部约束
        self.toolBarConstant = toolBar.xmg_Constraint(constraintsList: cons, attribute: .bottom)
        
        
    }
    
    // 键盘位置改变通知触发的方法
    func keyboardChange(notification:Notification) {
        print(notification.userInfo!)
        let keyboardDict = notification.userInfo!
        let keyboardRect = (keyboardDict["UIKeyboardFrameEndUserInfoKey"] as! NSValue).cgRectValue
        let duration = keyboardDict["UIKeyboardAnimationDurationUserInfoKey"] as! NSNumber
        
        let toolBarY = -(screenH - keyboardRect.origin.y)
        UIView.animate(withDuration: TimeInterval(duration.intValue), animations: {
            self.toolBarConstant?.constant = toolBarY
            self.view.layoutIfNeeded()
        })
        
    }
    
}

extension ViewController : UITextViewDelegate {
    
    // textView 文字改变触发该事件
    func textViewDidChange(_ textView: UITextView) {
        self.placeHolderLabel.isHidden = true
    }
    
}

