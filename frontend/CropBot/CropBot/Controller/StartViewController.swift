/*
 This the starting instruction view controller.
 
 Copyright © 2019 Nikolas Ioannou. All rights reserved.
*/

import UIKit

class StartViewController: UIViewController {
    
    // MARK: - Class variables
    
    /*
     This is the super view controller. Usually
     will refer to view controller
    */
    var superViewController: ViewController!
    
    /*
     This is the data source for the
     table view's rows.
    */
    let iconTitleSubtitleRows: [IconTitleSubtitle] = [
        IconTitleSubtitle(image: UIImage(systemName: "calendar")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.theme.blue), title: "Daily Update", subtitle: "A daily update includes relevant live agricultural information."),
        IconTitleSubtitle(image: UIImage(systemName: "leaf.arrow.circlepath")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.theme.blue), title: "Crop disease classification", subtitle: "\"My crops have fungus.\""),
        IconTitleSubtitle(image: UIImage(systemName: "shield")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.theme.blue), title: "Weed classification", subtitle: "\"There are weeds in my crops.\""),
        IconTitleSubtitle(image: UIImage(systemName: "dollarsign.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.theme.blue), title: "Crop price prediction", subtitle: "\"What are my crops worth?\""),
        IconTitleSubtitle(image: UIImage(systemName: "cart")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.theme.blue), title: "Best crop predictor", subtitle: "\"What is the best crop to plant?\""),
        IconTitleSubtitle(image: UIImage(systemName: "bolt")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.theme.blue), title: "Disaster assistance", subtitle: "\"My crops are being flooded?\""),
    ]
    
    // MARK: - Autolayout variables
    
    /*
     This is a variable that stores the
     cellId for the settings row cell.
    */
    let cellId = "cellId"
    
    var cellHeight: CGFloat = 80
    let continueButtonHeight: CGFloat = 48
    
    // MARK: - Create view
    
    /*
     This is the settings tableView.
    */
    let startTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.theme.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupTableView()
        setupViews()
    }
    
    /*
     This function is used to setup the
     navigationItem.
    */
    func setupNavigationItem() {
        // Setup title
        navigationItem.title = "Welcome to CropBot"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /*
     This function is used to setup the
     settingsTableView.
    */
    func setupTableView() {
        // Set dataSource to self
        startTableView.delegate = self
        startTableView.dataSource = self
        
        // Register cell
        startTableView.register(IconTitleSubtitleCell.self, forCellReuseIdentifier: cellId)
        
        // Add to view and add constraints
        view.addSubview(startTableView)
        startTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        startTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        startTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
    }
    
    func setupViews() {
        //Setup
        // View
        view.backgroundColor = .white
        // Continue button
        if !UserDefaults.standard.bool(forKey: "firstLoad") {
            continueButton.setTitle("Done", for: .normal)
        }
        continueButton.layer.cornerRadius = continueButtonHeight/8
        continueButton.addTarget(self, action: #selector(handleContinueButton), for: .touchUpInside)
        // Configure for small iPhone
        if view.frame.height <= 667 {
            cellHeight = 64
        }
        
        // Add subviews
        view.addSubview(startTableView)
        view.addSubview(continueButton)
        
        // Add constraints
        // Next button
        continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: continueButtonHeight).isActive = true
        // Collection view
        startTableView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -16).isActive = true
    }
    
    @objc func handleContinueButton() {
        dismiss(animated: true) {
            if UserDefaults.standard.bool(forKey: "firstLoad") {
                self.superViewController.sendDailyUpdate()
                UserDefaults.standard.set(false, forKey: "firstLoad")
            }
        }
    }
    
}

/*
 This handles the tableView delegate methods.
*/
extension StartViewController: UITableViewDataSource, UITableViewDelegate {
    
    /*
     This delegate method returns the number of
     cells.
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return number of cells in current section
        return iconTitleSubtitleRows.count
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
        let iconTitleSubtitle = iconTitleSubtitleRows[row]
        
        // Configure corners
        cell.configureCornerRadius(indexPath: indexPath, rowData: [iconTitleSubtitleRows], withSection: false)
        
        // Set cell.iconTitleSubtitle
        cell.iconTitleSubtitle = iconTitleSubtitle
        
        // Return cell
        return cell
    }
    
    /*
     This delegate method handles the size of
     the row.
    */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
