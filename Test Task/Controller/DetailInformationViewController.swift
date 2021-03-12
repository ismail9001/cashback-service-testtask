//
//  DetailInformationViewController.swift
//  Test Task
//
//  Created by macbook on 10.02.2021.
//

import UIKit

class DetailInformationViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    var tapGestureRecogniser: UITapGestureRecognizer!
    var titleText: String = ""
    var urlText: String = ""
    let pasteboard = UIPasteboard.general
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelsConfigure()
        tapGestureConfigure()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        pasteboard.string = urlText
        guard let copiedText = pasteboard.string else { return }
        let alert = UIAlertController(title: "URL copied", message: "URL: \(copiedText)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    //MARK: - Functions
    
    func tapGestureConfigure() {
        tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tapGestureRecogniser.numberOfTapsRequired = 1
        urlLabel.isUserInteractionEnabled = true
        urlLabel.addGestureRecognizer(tapGestureRecogniser)
    }
    
    func labelsConfigure() {
        titleLabel.text = "Title: \(titleText)"
        urlLabel.text = "Url: \(urlText)"
    }

}
