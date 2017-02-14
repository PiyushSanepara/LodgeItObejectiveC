//
//  ThemeLabel.swift
//  MySampleApp
//
//  Created by piyushMac on 10/02/17.
//
//

import UIKit

@objc class ThemeLabelTitle: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = UIFont.systemFont(ofSize: 22.0)
        self.textColor = themeColor
    }
}

@objc class ThemeLabelDetail: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = UIFont.systemFont(ofSize: 14)
    }
}

@objc class ThemeLabelDetailBold: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if #available(iOS 8.2, *) {
            self.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        } else {
            // Fallback on earlier versions
        }
    }
}
