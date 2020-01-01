/*
 This the privacy view controller swift.
 
 Copyright © 2019 Nikolas Ioannou. All rights reserved.
*/

import UIKit

class PrivacyViewController: UIViewController {
    
    // MARK: - Autolayout variables
    
    let continueButtonHeight: CGFloat = 48
    
    // MARK: - Create views
    
    let privacyLabel: UILabel = {
        let label = UILabel()
        label.text = "CropBot is committed to protecting your privacy, and will never store or use any data that isn't required. Your location data, camera data, and microphone data are stored securely and never accessible to me, the developer. While we encourage that you allow access to location data, camera data, and microphone data, you can edit our permissions in Settings using the button below."
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to Settings", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.theme.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Create view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupViews()
    }
    
    // MARK: - Setup functions
    
    func setupNavigationItem() {
        // Title
        navigationItem.title = "Data & Privacy"
        
        // Bar button items - right
        let rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDismiss))
        rightBarButtonItem.tintColor = UIColor.theme.blue
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupViews() {
        // Setup
        // View
        view.backgroundColor = .white
        // Settings button
        settingsButton.layer.cornerRadius = continueButtonHeight/8
        
        // Add to view
        view.addSubview(privacyLabel)
        view.addSubview(settingsButton)
        
        // Add constraints
        // Privacy label
        privacyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        privacyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        privacyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        
        // Next button
        settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        settingsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: continueButtonHeight).isActive = true
    }
    
    // MARK: - Selector functions
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
}
