/*
 This handles the settings page.
 
 Copyright © 2019 Nikolas Ioannou. All rights reserved.
*/

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Class variables
    
    /*
     This is a variable that stores the
     cellId for the settings row cell.
    */
    let cellId = "cellId"
    
    /*
     This is a variable that stores the
     cellId for the settings section cell.
    */
    let headerId = "headerId"
    
    /*
     This is the super view controller. Usually
     will refer to view controller
    */
    var superViewController: UIViewController!
    
    /*
     This is the data source for the
     table view's rows.
    */
    let settingsRows: [[IconTitleSubtitle]] = [
        [
            IconTitleSubtitle(image: UIImage(systemName: "bolt.horizontal")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.theme.blue), title: "Reduce Vibrations", subtitle: ""),
            IconTitleSubtitle(image: UIImage(systemName: "cloud")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.theme.blue), title: "Data & Privacy", subtitle: "")
        ],
        [
            IconTitleSubtitle(image: UIImage(systemName: "keyboard")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.theme.blue), title: "Keyboard", subtitle: "Use the keyboard to interact with CropBot."),
//            IconTitleSubtitle(image: UIImage(systemName: "speaker.3")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.theme.blue), title: "Spoken Messages", subtitle: "Have CropBot read its messages aloud to you.")
        ]
    ]
    
    /*
     This is the data source for the
     table view's sections.
    */
    let settingsSections: [String] = [
        "MAIN",
        "VOICE ASSISTANT"
    ]
    
    // MARK: - Autolayout constraints
    
    let cellButtonDiameter: CGFloat = 32
    
    // MARK: - Create views
    
    /*
     This is the settings tableView.
    */
    let settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Init

    /*
     This function is a delegate method that
     runs when the view loads.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupTableView()
        setupViews()
    }
    
    // MARK: - Setup functions
    
    /*
     This function is used to setup the
     navigationItem.
    */
    func setupNavigationItem() {
        // Title
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Bar button items - right
        let rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
        rightBarButtonItem.tintColor = UIColor.theme.blue
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    /*
     This function is used to setup the
     settingsTableView.
    */
    func setupTableView() {
        // Set dataSource to self
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        // Register cell
        settingsTableView.register(IconTitleSubtitleCell.self, forCellReuseIdentifier: cellId)
        
        // Add to view and add constraints
        view.addSubview(settingsTableView)
        settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    /*
     This method sets up all the views.
    */
    func setupViews() {
        // Setup
        // Self
        view.backgroundColor = .white
        
        //
    }
    
    // MARK: - Selector functions
    
    /*
     This function is handles the .touchUpInside target
     for the rightBarButtonItem. This is the done
     button.
    */
    @objc func handleDone() {
        // Dismiss the settings view controller
        dismiss(animated: true, completion: nil)
    }
    
    @objc func presentPrivacyViewController() {
        let privacyViewController = PrivacyViewController()
        let navigationController = UINavigationController(rootViewController: privacyViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    
}

// MARK: - Extensions

/*
 This handles the tableView delegate methods.
*/
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    /*
     This delegate method returns the number of
     sections.
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        // Section count
        return settingsSections.count
    }
    
    /*
     This delegate method returns the number of
     cells.
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return number of cells in current section
        return settingsRows[section].count
    }
    
    /*
     This delegate method is called for each
     section.
    */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Get title
        let title = settingsSections[section]
        
        // Create the view
        let titleSectionView = TitleSectionView()
        titleSectionView.titleLabel.text = title
        
        // Return the titleSectionView
        return titleSectionView
    }
    
    /*
     This delegate method is called for each
     row.
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Define cell using deqeue
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! IconTitleSubtitleCell
        
        // Get row and section and then iconTitleSubtitle
        let row = indexPath.row
        let section = indexPath.section
        let iconTitleSubtitle = settingsRows[section][row]
        
        // Set cell.iconTitleSubtitle
        cell.iconTitleSubtitle = iconTitleSubtitle
        
        // Configure corners
        cell.configureCornerRadius(indexPath: indexPath, rowData: settingsRows, withSection: true)
        
        // Create right button
        let rightButton = UIButton()
        // Set image with tint
        rightButton.setImage(UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray), for: .normal)
        // Right button add target
        rightButton.addTarget(self, action: #selector(presentPrivacyViewController), for: .touchUpInside)
        // Setup for autolayout
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        cell.rightView = rightButton
        
        // Return cell
        return cell
    }
    
    /*
     This delegate method handles the size of
     the section.
    */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    /*
     This delegate method handles the size of
     the row.
    */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Get iconTitleSubtitle
        let row = indexPath.row
        let section = indexPath.section
        let iconTitleSubtitle = settingsRows[section][row]
        
        // Check for subtitleView
        if iconTitleSubtitle.subtitle == "" {
            return 48
        }
        // Else if it contains subtitle
        return 80
    }
    
}
