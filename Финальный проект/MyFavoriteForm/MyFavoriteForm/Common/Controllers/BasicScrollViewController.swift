//
//  BasicScrollViewController.swift
//  MyFavoriteForm
//
//  Created by Artur on 23.02.2021.
//

import UIKit
import SnapKit

class BasicScrollViewController: UIViewController {
    // MARK: - GUI Properties
    private(set) lazy var mainScroll = UIScrollView()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyboardHideWhenTappedArround()
        
        self.view.addSubview(self.mainScroll)

        self.constraints()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.registerForKeybordNotifications()
    }
    
    // MARK: - Methods
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = (notification as Notification).userInfo else { return }
        guard let keyboardNSValue: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardNSValue.cgRectValue

        self.mainScroll.contentInset.bottom = keyboardFrame.size.height + 10
    }
    @objc private func keyboardWillHide() {
        self.mainScroll.contentInset.bottom = .zero
    }
    
    private func registerForKeybordNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: - Constraints
    private func constraints() {
        self.mainScroll.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
