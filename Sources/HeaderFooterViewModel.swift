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

/// A view model for a table view header footer view
public struct TableViewHeaderFooterViewModel: Identifiable {
    
    /// A function to configure a `UITableViewHeaderFooterView`.
    public typealias Configurator = (TableViewHeaderFooterView) -> TableViewHeaderFooterView
    
    public static let StandardHeight: CGFloat = 28.0
    
    /// :nodoc:
    public let identifier: String
    
    /// The reuse identifier for this view
    public let viewReuseIdentifier: String
    
    /// A function that registers this view for reuse.
    public var viewReuseRegistrator: ((TableView) -> Void)?
    
    /// This view's data
    public let data: AnyEquatable?
    
    /// A configu
    public let configurator: Configurator?
    
    /// Takes a width, returns a height
    fileprivate let estimatedHeightClosure: (CGFloat) -> CGFloat
    
    /// Calculates an estimated height of the header footer view for a provided width.
    ///
    /// - Parameter width: The width of the table view.
    /// - Returns: The estimated height.
    public func estimatedHeight(forWidth width: CGFloat) -> CGFloat {
        return estimatedHeightClosure(width)
    }
    
    /// :nodoc:
    public var hashValue: Int {
        return identifier.hashValue
    }
    
    /// The simplest designated initializer.
    ///
    /// - Parameters:
    ///   - identifier: A unique identifier for this header footer view.
    ///   - viewReuseIdentifier: The reuse identifier for the view.
    ///   - viewReuseRegistrator: A function that registers this cell for reuse.
    ///   - data: Any optional data the header footer view needs.
    ///   - estimatedHeight: The estimated height of the view. Defaults to standard 28.0pts.
    ///   - configurator: A configuration function for setting up the view when it becomes visible.
    public init(identifier: String, viewReuseIdentifier: String, viewReuseRegistrator: ((TableView) -> Void)? = nil, data: AnyEquatable? = nil, estimatedHeight: CGFloat = TableViewHeaderFooterViewModel.StandardHeight, configurator: Configurator? = nil) {
        self.identifier = identifier
        self.viewReuseIdentifier = viewReuseIdentifier
        self.viewReuseRegistrator = viewReuseRegistrator
        self.data = data
        self.estimatedHeightClosure = { _ in return estimatedHeight }
        self.configurator = configurator
    }
    
    /// Convenience initializer for a header footer view of `ReusableViewType`
    ///
    /// - Parameters:
    ///   - viewType: The type for the header footer view to be dequeued.
    ///   - identifier: A unique identifier for this header footer view.
    ///   - model: The model data for this view.
    ///   - additionalConfiguration: Any other configuration than setting the view's data to be done when the view becomes visible. Defaults to `nil`.
    ///
    /// - SeeAlso: `ReusableViewType`
    public init<View: TableViewHeaderFooterView>(viewType: View.Type, identifier: String, model: View.Model, additionalConfiguration: ((View) -> View)? = nil) where View: ReusableViewType {
        self.identifier = identifier
        self.data = model
        self.viewReuseIdentifier = View.staticReuseIdentifier
        self.viewReuseRegistrator = { View.register(viewKind: .headerFooterView, inTableView: $0) }
        
        self.configurator = { view in
            guard let view = view as? View else { fatalError("Wrong view type for model") }
            view.setup(model)
            return additionalConfiguration?(view) ?? view
        }
        
        self.estimatedHeightClosure = { width in
            if let estimatedHeight = viewType.estimatedHeight(forWidth: width, model: model) {
                return estimatedHeight
            } else if let staticHeightView = viewType as? StaticHeightType.Type {
                return staticHeightView.height
            } else {
                return TableViewHeaderFooterViewModel.StandardHeight
            }
        }
    }
    
    /// Convenience initializer for using a `DualTitledSectionHeaderView`.
    ///
    /// - Parameters:
    ///   - title: The title text. Defaults to `nil`.
    ///   - detailText: The detail text. Defaults to `nil`.
    ///   - additionalConfiguration: Any other configuration than setting the view's data to be done when the view becomes visible. Defaults to `nil`.
    ///
    /// - SeeAlso: `StandardHeaderFooterView`
    public init(title: String? = nil) {
        self.init(viewType: StandardHeaderFooterView.self, identifier: title ?? UUID().uuidString, model: .init(title: title))
    }
    
}

/// :nodoc:
public func ==(lhs: TableViewHeaderFooterViewModel, rhs: TableViewHeaderFooterViewModel) -> Bool {
    return lhs.identifier == rhs.identifier &&
           lhs.viewReuseIdentifier == rhs.viewReuseIdentifier &&
           lhs.data == rhs.data
}
