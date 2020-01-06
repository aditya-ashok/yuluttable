//
//  JsonModel.swift
//  TableYulu
//
//  Created by Aditya Ashok on 06/01/20.
//  Copyright © 2020 Aditya Ashok. All rights reserved.
//

import UIKit

class JsonModel: NSObject {
    
    var title : String!
    var subTitle : String!
    
    
    init(title : String, subTitle: String) {
           self.title = title
           self.subTitle = subTitle
       }
 
}
