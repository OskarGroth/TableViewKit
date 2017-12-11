//
//  NSView+LoadFromNib.swift
//  TableViewKitMac
//
//  Created by Oskar Groth on 2017-12-11.
//  Copyright © 2017 TableViewKit. All rights reserved.
//

import Cocoa

public extension NSView {
    
    /// Load a view from a Nib file.
    ///
    /// - parameter  named: The name of the Nib file.
    /// - parameter bundle: The bundle of the Nib file. Defaults to `nil`.
    public class func loadFromNib<T>(named nibName: String, bundle : Bundle? = nil) -> T? {
        var objects: NSArray?
        guard NSNib(
            nibNamed: NSNib.Name(nibName),
            bundle: bundle
        )?.instantiate(withOwner: nil, topLevelObjects: &objects) ?? false else { return nil }
        return objects?.firstObject as? T
    }
    
}
