//
//  ViewController.swift
//  KeyboarListenerDemo
//
//  Created by Frank.Chen on 2018/4/1.
//  Copyright © 2018年 frank.chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!    
    
    var keyboardHeight: CGFloat = 0 // keep 住鍵盤的高度，在每次 ChangeFrame 的時侯記錄
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 鍵盤的生命週期
        // 註冊 監聽鍵盤 frame 改變的事件
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // 註冊監聽鍵盤出現的事件
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        // 註冊監聽鍵盤消失的事件
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 關閉鍵盤
    ///
    /// - Parameters:
    ///   - touches: _
    ///   - event: _
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// 監聽鍵盤 frame 改變事件(鍵盤切換時總會觸發，不管是不是相同 type 的....例如：預設鍵盤 → 數字鍵盤)
    ///
    /// - Parameter notification: _
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        print("keyboardWillChangeFrame...")
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            self.scrollView.contentSize.height = self.scrollView.contentSize.height - self.keyboardHeight // scrollView contentSize 的高度容量扣掉鍵盤的高度
            self.keyboardHeight = keyboardFrame.cgRectValue.height // keep 住鍵盤的高度
        }
    }
    
    /// 監聽鍵盤開啟事件(鍵盤切換時總會觸發，不管是不是相同 type 的....例如：預設鍵盤 → 數字鍵盤)
    ///
    /// - Parameter notification: _
    @objc func keyboardWillShow(_ notification: Notification) {
        print("keyboardWillShow...")
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            self.scrollView.contentSize.height = self.scrollView.contentSize.height + keyboardFrame.cgRectValue.height // scrollView contentSize 的容量加上鍵盤的高度
        }
    }
    
    /// 監聽鍵盤關閉事件(鍵盤關掉時才會觸發)
    ///
    /// - Parameter notification: _
    @objc func keyboardWillHide(_ notification: Notification) {
        print("keyboardWillHide...")
        self.keyboardHeight = 0 // 鍵盤關掉，則要將 keep 住的高度歸 0。否則在下一起開啟鍵盤時，在 keyboardWillChangeFrame　扣掉上一次 keep 住的鍵盤高度
    }
}

