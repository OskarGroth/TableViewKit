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

/// For classes where there is a Nib with the same filename as the class.
public protocol NibLoadable { }

#if os(OSX)

    public extension NibLoadable where Self:NSView {
        
        public static func loadFromNib() -> Self {
            return loadFromNib(named: String(describing: self), bundle: Bundle(for: self))!
        }
        
    }

#elseif os(iOS)

    public extension NibLoadable where Self:UIView {
        
        public static func loadFromNib() -> Self {
            return loadFromNib(named: String(describing: self), bundle: Bundle(for: self))!
        }
        
    }

#endif
