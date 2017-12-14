//
//  LabelCell.swift
//  TableViewKitDemo-Mac
//
//  Created by Oskar Groth on 2017-12-12.
//  Copyright © 2017 Oskar Groth. All rights reserved.
//

import Cocoa
import TableViewKitMac

class LabelCell: TableViewCell, ReusableViewClass, DataSetupable {
    
    struct Model: Hashable, AnyEquatable {
        let text: String
        
        var hashValue: Int {
            return text.hashValue
        }
    }
    
    override init(style: TableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: Model) {
        textField?.text = model.text
    }
    
}

func ==(lhs: LabelCell.Model, rhs: LabelCell.Model) -> Bool {
    return lhs.text == rhs.text
}
