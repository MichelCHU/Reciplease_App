//
//  Extension.swift
//  Reciplease_App
//
//  Created by Square on 24/02/2022.
//

import UIKit

// MARK: - UIIMAGE Extension

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}

extension String {
    var data: Data? {
        guard let url = URL(string: self) else { return nil}
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}
extension UIViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func dismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    public func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func activityIndicator(activityIndicator: UIActivityIndicatorView, button: UIButton, showActivityIndicator: Bool){
        activityIndicator.isHidden = !showActivityIndicator
    }
}
