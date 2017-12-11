//
//  Common-macOS.swift
//  TableViewKitMac
//
//  Created by Oskar Groth on 2017-12-11.
//  Copyright © 2017 TableViewKit. All rights reserved.
//

#if os(OSX)
    import Cocoa
    public typealias TableView = NSTableView
    public typealias Nib = NSNib
    public typealias TextField = NSTextField
    public typealias TableViewHeaderFooterView = MacHeaderFooterView
    
    open class MacHeaderFooterView: NSTableCellView {
        
        public var textLabel: TextField? {
            return textField
        }
        
        public var detailTextLabel: TextField? {
            return nil // Todo
        }
        
    }
    
    public extension NSTextField {

        public var text: String? {
            get {
                return stringValue
            }
            set {
                stringValue = newValue ?? ""
            }
        }
        
    }
    
    public extension NSTableView {
        func register(_ cellClass: Any?, forCellReuseIdentifier identifier: String) {
            register(cellClass, forCellReuseIdentifier: identifier)
        }
        
        func register(_ cellClass: Any?, forHeaderFooterViewReuseIdentifier: String) {
            //todo
        }
    }
    
    public extension NSNib {
        
        convenience init(nibName: String, bundle: Bundle) {
            self.init(nibName: nibName, bundle: bundle)
        }
        
    }
    
#endif
