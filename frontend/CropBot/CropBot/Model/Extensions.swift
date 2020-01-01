/*
 This is a struct containing information that
 is constant throughout the program.
 
 Copyright © 2019 Nikolas Ioannou. All rights reserved.
*/

import UIKit

extension UIColor {
    struct theme {
        static let blue = UIColor(red: 73/255, green: 91/255, blue: 236/255, alpha: 1)
        static let gray = UIColor(red: 232/255, green: 233/255, blue: 235/255, alpha: 1)
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
