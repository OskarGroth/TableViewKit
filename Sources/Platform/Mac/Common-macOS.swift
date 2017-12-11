//
//  Common-macOS.swift
//  TableViewKitMac
//
//  Created by Oskar Groth on 2017-12-11.
//  Copyright © 2017 TableViewKit. All rights reserved.
//

#if os(OSX)
    import Cocoa
    
    public typealias CollectionView = NSCollectionView
    public typealias TableView = NSTableView
    public typealias TableViewCell = MacTableViewCell
    public typealias TableViewRowAction = NSTableViewRowAction
    public typealias TableViewRowAnimation = NSTableView.AnimationOptions
    public typealias EdgeInsets = MacEdgeInsets
    public typealias Nib = NSNib
    public typealias TextField = NSTextField
    public typealias TableViewHeaderFooterView = MacHeaderFooterView
    public typealias CollectionViewScrollPosition = MacCollectionViewScrollPosition
    public extension NSTableView.AnimationOptions {
        
        public static var automatic: NSTableView.AnimationOptions {
            return .slideUp
        }
        
        public static var fade: NSTableView.AnimationOptions {
            return .effectFade
        }
        
    }
    
    public class MacTableViewCell: NSTableCellView {
        public var separatorInset: EdgeInsets = .zero
        public var layoutMargins: EdgeInsets = .zero
    }
    
    public struct MacEdgeInsets {
        public var top: CGFloat
        public var left: CGFloat
        public var bottom: CGFloat
        public var right: CGFloat
        public static var zero: MacEdgeInsets { return MacEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) }
    }
    
    open class MacHeaderFooterView: NSTableCellView {
        
        public var textLabel: TextField? {
            return textField
        }
        
        public var detailTextLabel: TextField? {
            return nil // Todo
        }
        
    }
    
    public extension IndexPath {
        
        init(row: Int, section: Int) {
            self.init(item: row, section: section)
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
    
    public struct MacCollectionViewScrollPosition: OptionSet {
        
        public let rawValue: UInt
        
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
        
        static let none = MacCollectionViewScrollPosition(rawValue: 1 << 0)
        static let top = MacCollectionViewScrollPosition(rawValue: 1 << 1)
        static let centeredVertically = MacCollectionViewScrollPosition(rawValue: 1 << 2)
        static let bottom = MacCollectionViewScrollPosition(rawValue: 1 << 3)
        static let left = MacCollectionViewScrollPosition(rawValue: 1 << 4)
        static let centeredHorizontally = MacCollectionViewScrollPosition(rawValue: 1 << 5)
        static let right = MacCollectionViewScrollPosition(rawValue: 1 << 6)

    }
    
    public extension NSCollectionView {
        
        public var indexPathsForVisibleItems: Set<IndexPath> {
            return self.indexPathsForVisibleItems()
        }
        
        public var indexPathsForSelectedItems: Set<IndexPath> {
            return Set<IndexPath>() // TODO
        }
        
        public func performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
            performBatchUpdates(updates, completionHandler: completion)
        }

        
        public func scrollToItem(at indexPath: IndexPath,
                          at scrollPosition: MacCollectionViewScrollPosition,
                          animated: Bool) {
            // TODO
        }
        
        
    }
    
    public extension NSTableView {
        
        public var indexPathsForVisibleRows: [IndexPath]? {
            return nil
        }
        
        public func register(_ cellClass: Any?, forCellReuseIdentifier identifier: String) {
            register(cellClass, forCellReuseIdentifier: identifier)
        }
        
        public func register(_ cellClass: Any?, forHeaderFooterViewReuseIdentifier: String) {
            //todo
        }
        
        public func cellForRow(at indexPath: IndexPath) -> TableViewCell? {
            return view(atColumn: indexPath.section, row: indexPath.item, makeIfNecessary: true) as? TableViewCell
        }
        
        public func performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
            // Todo
        }
        
        public func moveRow(at: IndexPath, to: IndexPath) {
            moveRow(at: at.item, to: to.item)
        }
        
        public func reloadRows(at indexPaths: [IndexPath], with animation: TableViewRowAnimation) {
            
        }
        
        public func insertRows(at indexPaths: [IndexPath], with animation: TableViewRowAnimation) {
            let rows = indexPaths.map({ $0.item })
            self.insertRows(at: IndexSet(rows), withAnimation: animation)
        }
        
        public func deleteRows(at indexPaths: [IndexPath], with animation: TableViewRowAnimation) {
            
        }
        
        public func insertSections(_ sections: IndexSet, with animation: TableViewRowAnimation) {
            
        }
        
        public func reloadSections(_ sections: IndexSet, with animation: TableViewRowAnimation) {
            
        }
        
        public func deleteSections(_ sections: IndexSet, with animation: TableViewRowAnimation) {
            
        }

    }
    
    public extension NSNib {
        
        convenience init(nibName: String, bundle: Bundle) {
            self.init(nibName: nibName, bundle: bundle)
        }
        
    }
    
#endif
