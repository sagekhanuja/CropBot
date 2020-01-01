/*
 This handles the basic chat functionality.
 
 Copyright © 2019 Nikolas Ioannou. All rights reserved.
*/

import UIKit
import ApiAI
import CoreLocation
import Speech

protocol CanSpeakDelegate {
   func speechDidFinish()
}

class ViewController: UIViewController {
    
    // MARK: - Class variables
    
    /*
     This is a variable that stores the
     cellId for the chat text cells.
    */
    let chatTextCellId = "chatTextCellId"
    
    /*
     This is a variable that stores the
     cellId for the chat photo cells.
    */
    let chatPhotoCellId = "chatPhotoCellId"
    
    /*
     This is a variable that stores the
     cellId for the chat photo cells.
    */
    let chatLinkCellId = "chatLinkCellId"
    
    /*
     This is an array that is populated
     when new messages are sent.
    */
    var chatMessages: [Any] = [
//        ChatText(text: "Here's my very first message", isIncoming: true),
//        ChatText(text: "I'm going to message another long message that will word wrap", isIncoming: true),
//        ChatText(text: "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false),
//        ChatText(text: "Yo, dawg, Whaddup!", isIncoming: false),
//        ChatText(text: "This message should appear on the left with a white background bubble", isIncoming: true),
//        ChatPhoto(photo: UIImage(named: "test.png")!, isIncoming: true),
//        ChatPhoto(photo: nil, isIncoming: false)
//        ChatLink(link: "www.google.com", isIncoming: false)
    ]
    
    // MARK: - Autolayout constraints
    
    /*
     This is the auto layout constraint that
     controls the bottom anchor of the
     message input container view. It is
     used to animate the container when the
     keyboard is toggled.
    */
    var messageInputContainerViewBottomConstraint: NSLayoutConstraint!
    
    /*
     This is a location manager object that
     is used to manager all the getting
     location data.
    */
    let locationManager = CLLocationManager()
    
    /*
     This is an object used to store
     the current coordinates.
    */
    var coordinates: CLLocationCoordinate2D?
    
    // MARK: - Create views
    
    /*
     This is the chat tableView.
    */
    let chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    /*
     This is the container for all the
     messaging views.
    */
    let messageInputContainerView = UIView()
    
    /*
     This is the text field which you
     can type in to send messages.
    */
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ask CropBot"
        textField.tintColor = UIColor.theme.blue
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    /*
     This is the button that sends your
     text in the text field.
    */
    let sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.theme.blue
        button.setImage(UIImage(systemName: "arrow.up")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /*
     This is an ImagePickerController that is pushed
     when a chatPhoto cell doesn't have a uiimage.
    */
    let imagePickerController = UIImagePickerController()
    
    // MARK: - Init

    /*
     This function is a delegate method that
     runs when the view loads.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Run setup functions
        startAll()
        if !UserDefaults.standard.bool(forKey: "firstLoad") {
            sendDailyUpdate()
        } else {
            presentStartViewController()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup functions
    
    /*
     This function is used to setup the
     navigationItem.
    */
    func setupNavigationItem() {
        // Title
        navigationItem.title = "Ask CropBot"
        
        // Bar button items - left
        let leftButton = UIButton(type: .system)
        leftButton.setImage(UIImage(systemName: "info.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.theme.blue), for: .normal)
        leftButton.addTarget(self, action: #selector(handleLeftBarButtonItem), for: .touchUpInside)
        let leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        // Bar button items - right
//        let rightButton = UIButton(type: .system)
//        rightButton.setImage(UIImage(systemName: "gear")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.theme.blue), for: .normal)
//        rightButton.addTarget(self, action: #selector(handleRightBarButtonItem), for: .touchUpInside)
//        let rightBarButtonItem = UIBarButtonItem(customView: rightButton)
//        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupLocationManager() {
        // Request use
        locationManager.requestWhenInUseAuthorization()
        // Set delegate
        locationManager.delegate = self
        // Set accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    /*
     This function is used to setup the
     chatTableView.
    */
    func setupTableView() {
        // Set dataSource and delegate to self
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        // Register cell
        chatTableView.register(ChatTextCell.self, forCellReuseIdentifier: chatTextCellId)
        chatTableView.register(ChatPhotoCell.self, forCellReuseIdentifier: chatPhotoCellId)
        
        // Add to view and add constraints
        view.addSubview(chatTableView)
        chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chatTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        chatTableView.bottomAnchor.constraint(equalTo: messageInputContainerView.topAnchor).isActive = true
    }
    
    /*
     This function is used to setup the
     inputComponents, which include the
     inputTextField and sendButton.
    */
    func setupInputComponents() {
        // Configure messageInputContainerView for auto layout
        messageInputContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add target to sendButton
        sendButton.addTarget(self, action: #selector(handleSendButton), for: .touchUpInside)
        
        // Create borderView
        let borderView = UIView()
        borderView.backgroundColor = .lightGray
        borderView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup input text field
        inputTextField.delegate = self
        
        // Add subviews
        view.addSubview(messageInputContainerView)
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addSubview(sendButton)
        messageInputContainerView.addSubview(borderView)
        
        // Constraints
        // messageInputContainerView
        messageInputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        messageInputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        messageInputContainerViewBottomConstraint = messageInputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        messageInputContainerViewBottomConstraint.isActive = true
        messageInputContainerView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        // inputTextField
        inputTextField.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor, constant: 16).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor).isActive = true
        inputTextField.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor).isActive = true
        
        // sendButton
        sendButton.trailingAnchor.constraint(equalTo: messageInputContainerView.trailingAnchor, constant: -16).isActive = true
        sendButton.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor, constant: 8).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor, constant: -8).isActive = true
        sendButton.widthAnchor.constraint(equalTo: sendButton.heightAnchor).isActive = true
        
        // borderView
        borderView.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor).isActive = true
        borderView.trailingAnchor.constraint(equalTo: messageInputContainerView.trailingAnchor).isActive = true
        borderView.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor).isActive = true
        borderView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    /*
     This method sets up all the views.
    */
    func setupViews() {
        // Setup
        // Self
        view.backgroundColor = .white
        
        // Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /*
     This function sends the daily update messages.
    */
    func sendDailyUpdate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.handleSend(message: ChatText(text: "Hello, here is your daily update:", isIncoming: true))
            let apiManager = APIManager()
            apiManager.getRequest(with: "http://127.0.0.1:8080/info?latitude=\(String(self.coordinates!.latitude))&&longitude=\(String(self.coordinates!.longitude))") { (results) in
                if let results = results {
                    let temp = results["temperature"] as! Int
                    let humidity = results["humidity"] as! Double
                    let visibility = results["visibility"] as! Double
                    let pressure = results["pressure"] as! Double
                    let precipitation = results["day_precipitation"] as! Double
                    let weather = results["weather"] as! String
                    DispatchQueue.main.async {
                        let dailyUpdate = "Temperature: \(temp)\nHumidity: \(humidity)\nVisibility: \(visibility)\nPresure: \(pressure)\nPrecipitation: \(precipitation)\nWeather: \(weather)\n"
                        print(weather)
                        self.handleSend(message: ChatText(text: dailyUpdate, isIncoming: true))
                    }
                }
            }
        }
    }
    
    /*
     This function starts all.
    */
    func startAll() {
        setupNavigationItem()
        setupLocationManager()
        setupInputComponents()
        setupTableView()
        setupViews()
    }
    
    /*
     This function sets up the Introduction View
    controller.
    */
    func presentStartViewController() {
        let startViewController = StartViewController()
        startViewController.superViewController = self
        let navigationController = UINavigationController(rootViewController: startViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Functions
    
    /*
     This function sends a messsage.
    */
    func handleSend(message: Any) {
        // Append to chatMessages
        chatMessages.append(message)
        // Create index path
        let item = chatMessages.count - 1
        let indexPath = IndexPath(item: item, section: 0)
        // Check cases
        if let chatText = message as? ChatText {
            let rowAnimation: UITableView.RowAnimation = chatText.isIncoming ? .left : .right
            chatTableView.insertRows(at: [indexPath], with: rowAnimation)
            chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            if !chatText.isIncoming {
                handleRespond(toMessage: chatText)
            }
        } else if let chatPhoto = message as? ChatPhoto {
            let rowAnimation: UITableView.RowAnimation = chatPhoto.isIncoming ? .left : .right
            chatTableView.insertRows(at: [indexPath], with: rowAnimation)
            chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            if !chatPhoto.isIncoming {
                handleRespond(toMessage: chatPhoto)
            }
        }
    }
    
    /*
     This function responds to a message.
    */
    func handleRespond(toMessage: Any) {
        // Check type
        if let toChatText = toMessage as? ChatText {
            // Declare request
            let request = ApiAI.shared().textRequest()
            request?.query = toChatText.text
            request?.setMappedCompletionBlockSuccess({ (request, response) in
                let response = response as! AIResponse
                if let message = response.result.fulfillment.messages?[0] {
                    let text = message["speech"] as! String
                    self.checkForIntents(response: text)
                }
            }, failure: { (request, error) in
                print(error!)
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                ApiAI.shared().enqueue(request)
            }
        } else if let toChatPhoto = toMessage as? ChatPhoto {
        }
    }
    
    func checkForIntents(response: String) {
        let apiManager = APIManager()
        switch response {
            // DONE
        case Intent.bestCrop.rawValue:
            apiManager.getRequest(with: "http://127.0.0.1:8080/info?latitude=\(String(self.coordinates!.latitude))&&longitude=\(String(self.coordinates!.longitude))") { (results) in
                if let results = results {
                    let bestCrop = results["best_crop"] as! String
                    DispatchQueue.main.async {
                        self.handleSend(message: ChatText(text: "Based on location data, the best crop to plant is \(bestCrop).", isIncoming: true))
                    }
                }
            }
        case Intent.cropDisease.rawValue:

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.handleSend(message: ChatText(text: "Please upload a photo of your crop as shown below:", isIncoming: true))
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.handleSend(message: ChatPhoto(photo: UIImage(named: "cropDiseaseSample.png"), isIncoming: true, intent: .cropDisease))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.handleSend(message: ChatPhoto(photo: nil, isIncoming: false, intent: .cropDisease))
                    }
                }
            }
            // DONE
        case Intent.drought.rawValue:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.handleSend(message: ChatText(text: "Here is my advice:", isIncoming: true))
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.handleSend(message: ChatText(text: "Drip irrigation systems deliver water directly to a plant’s roots, reducing the evaporation that happens with spray watering systems.", isIncoming: true))
                }
            }
            // DONE
        case Intent.flood.rawValue:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.handleSend(message: ChatText(text: "Here is my advice:", isIncoming: true))
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.handleSend(message: ChatText(text: "Many pests tend to flourish after floods. To prevent this remove residue from over  rows. This will help plants grow out of the ground.", isIncoming: true))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.handleSend(message: ChatText(text: "Plant crops less deep in the soil to allow water to more easily reach roots.", isIncoming: true))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.handleSend(message: ChatText(text: "The soil’s nutrient composition may be slightly messed up as a result of the flood. Planting crops less deeply will help the seedlings emerge more quickly.", isIncoming: true))
                        }
                    }
                }
            }
            // DONE
        case Intent.tutorial.rawValue:
            self.handleSend(message: ChatText(text: "You can learn more by pressing the information icon in the top left corner.", isIncoming: true))
        case Intent.pricePrediction.rawValue:
            self.handleSend(message: ChatText(text: "This feature will be implemented in the future!", isIncoming: true))
        case Intent.weedDetection.rawValue:
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.handleSend(message: ChatText(text: "Please upload a photo of your crop as shown below:", isIncoming: true))
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.handleSend(message: ChatPhoto(photo: UIImage(named: "new.png"), isIncoming: true, intent: .weedDetection))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.handleSend(message: ChatPhoto(photo: nil, isIncoming: false, intent: .weedDetection))
                    }
                }
            }
        default:
            self.handleSend(message: ChatText(text: response, isIncoming: true))
        }
    }
    
    // MARK: - Selector functions
    
    /*
     This function is handles the .touchUpInside target
     for the leftBarButtonItem. This is thee info.
    */
    @objc func handleLeftBarButtonItem() {
        presentStartViewController()
    }
    
    /*
     This function is handles the .touchUpInside target
     for the rightBarButtonItem. This is the settings.
    */
    @objc func handleRightBarButtonItem() {
        let settingsViewController = SettingsViewController()
        settingsViewController.superViewController = self
        let navigationController = UINavigationController(rootViewController: settingsViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    /*
     This function is handles the .touchUpInside target
     for the send button.
    */
    @objc func handleSendButton() {
        if inputTextField.text != "" {
            let text = inputTextField.text!
            let chatMessage = ChatText(text: text, isIncoming: false)
            handleSend(message: chatMessage)
            // Clear input text field
            inputTextField.text = nil
        }
    }
    
    /*
     This function handles the .touchUpInside target
     for a chatPhoto cell that doesn't have an image.
    */
    @objc func handleCamera() {
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    /*
     This function is called when the keyboard
     is toggled.
    */
    @objc func handleKeyboardNotification(notification: Notification) {
        // Safely unwrap user info
        if let userInfo = notification.userInfo {
            // Get keyboard frame
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            // Get bottom constant
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            let trueBottomConstant = -keyboardFrame.height
            let bottomConstant = isKeyboardShowing ? trueBottomConstant : 0
            
            // Setup bottom constraint
            messageInputContainerViewBottomConstraint.isActive = false
            messageInputContainerViewBottomConstraint = messageInputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottomConstant)
            messageInputContainerViewBottomConstraint.isActive = true
            
            // Animate
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (completed) in
                if isKeyboardShowing {
                    // Get index path of latest message
                    let item = self.chatMessages.count - 1
                    let indexPath = IndexPath(item: item, section: 0)
                    
                    // Scroll to latest message
                    self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
    }
    
}

// MARK: - Extensions

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    /*
     This delegate method returns the number of
     cells.
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return chatMessages count
        return chatMessages.count
    }
    
    /*
     This delegate method is called for each
     row.
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let chatText = chatMessages[indexPath.row] as? ChatText {
            let cell = tableView.dequeueReusableCell(withIdentifier: chatTextCellId, for: indexPath) as! ChatTextCell
            cell.chatText = chatText
            return cell
        } else if let chatPhoto = chatMessages[indexPath.row] as? ChatPhoto {
            let cell = tableView.dequeueReusableCell(withIdentifier: chatPhotoCellId, for: indexPath) as! ChatPhotoCell
            cell.chatPhoto = chatPhoto
            if chatPhoto.photo == nil {
                cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCamera)))
            }
            return cell
        }
        return UITableViewCell()
    }
    
    /*
     This delegate method handles the size of
     the row.
    */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Get chatMessage
        let row = indexPath.row
        let chatMessage = chatMessages[row]
        
        // Handle cases
        if let chatText = chatMessage as? ChatText {
            // Set default size
            let size = CGSize(width: 250, height: 1000)
            // Set options and estimate frame
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: chatText.text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)], context: nil)
            // Return estimated frame height
            return estimatedFrame.height + 29
        } else if let chatPhoto = chatMessage as? ChatPhoto {
            if let photo = chatPhoto.photo {
                let photoSize = photo.size
                if photoSize.width > photoSize.height {
                    return 264 * photoSize.height / photoSize.width + 14
                }
                return 280
            }
            return 78
        }
        return 0
    }
}

extension ViewController: UITextFieldDelegate {
    /*
     This delegate method is when the return
     key is pressed.
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSendButton()
        return false
    }
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true) {
            if let photo = info[.originalImage] as? UIImage {
//                self.handleSendPhoto(photo: photo)
                for chatMessageIndex in 0..<self.chatMessages.count {
                    if let chatPhoto = self.chatMessages[chatMessageIndex] as? ChatPhoto {
                        if chatPhoto.photo == nil {
                            self.chatMessages[chatMessageIndex] = ChatPhoto(photo: photo, isIncoming: false, intent: .cropDisease)
                            DispatchQueue.main.async {
                                self.chatTableView.reloadData()
                            }
                            
                            let apiManager = APIManager()
                            
                            if chatPhoto.intent == .cropDisease {
                                apiManager.postRequest(with: "http://127.0.0.1:8080/cropImageModel", image: photo) { (string) in
                                    DispatchQueue.main.async {
                                        self.handleSend(message: ChatText(text: "CropBot predicts " + string!, isIncoming: true))
                                    }
                                }
                            } else if chatPhoto.intent == .weedDetection {
                                apiManager.postRequest(with: "http://127.0.0.1:8080/weedImageModel", image: photo) { (string) in
                                    DispatchQueue.main.async {
                                        self.handleSend(message: ChatText(text: "CropBot finds " + string!, isIncoming: true))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        coordinates = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    }
}
