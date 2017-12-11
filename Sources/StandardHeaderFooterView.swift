//
//  TableViewKit
//
//  Copyright (c) 2017 Alek Åström.
//  Licensed under the MIT license, see LICENSE file.
//

#if os(OSX)
    import Cocoa
#elseif os(iOS)
    import UIKit
#endif

/// Wraps a standard `UITableViewHeaderFooterView` by adding reusability protocols & a view model.
open class StandardHeaderFooterView: TableViewHeaderFooterView, DataSetupable, ReusableViewClass {
    
    /// The model for a `StandardHeaderFooterView`.
    public struct Model: Hashable, AnyEquatable {
        
        /// The title to display.
        public var title: String?
        
        /// The detail text to display.
        public var detailText: String?
        
        /// :nodoc:
        public var hashValue: Int {
            return (title?.hashValue ?? 0) ^ (title?.hashValue ?? 0)
        }
        
        /// The designated initializer.
        ///
        /// - Parameters:
        ///   - title: The title to display.
        ///   - detailText: The detail text to display.
        public init(title: String? = nil, detailText: String? = nil) {
            self.title = title
            self.detailText = detailText
        }
    }
    
    /// :nodoc:
    open func setup(_ model: Model) {
        textLabel?.text = model.title
        detailTextLabel?.text = model.detailText
    }
    
    /// :nodoc:
    open static func estimatedHeight(forWidth width: CGFloat, model: Model) -> CGFloat? {
        return 28
    }
    
}

/// :nodoc:
public func ==(lhs: StandardHeaderFooterView.Model, rhs: StandardHeaderFooterView.Model) -> Bool {
    return lhs.title == rhs.title && lhs.detailText == rhs.detailText
}
