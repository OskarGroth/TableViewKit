//
//  HandwrittenNoteCell.swift
//  TableViewKitDemo-Mac
//
//  Created by Oskar Groth on 2017-12-12.
//  Copyright © 2017 Oskar Groth. All rights reserved.
//

import Cocoa
import TableViewKitMac

class AsdCell: NSTableCellView {
    @IBOutlet var topLabel: TextField!

}

class NoteCell: TableViewCell, ReusableViewNib, DataSetupable {

    @IBOutlet var topLabel: TextField!
    @IBOutlet var bottomLabel: TextField!
    
    struct Model: Hashable, AnyEquatable {
        var title: String
        var subtitle: String?
        
        var hashValue: Int {
            return title.hashValue ^ (subtitle?.hashValue ?? 0)
        }
    }
    
    func setup(_ model: NoteCell.Model) {
        topLabel.text = model.title
        bottomLabel.text = model.subtitle
        bottomLabel.isHidden = (model.subtitle == nil)
    }
    
    static func estimatedHeight(forWidth width: CGFloat, model: Model) -> CGFloat? {
        return 100 // TODO: Add better estimation
    }
}

func ==(lhs: NoteCell.Model, rhs: NoteCell.Model) -> Bool {
    return lhs.title == rhs.title
        && lhs.subtitle == rhs.subtitle
}
