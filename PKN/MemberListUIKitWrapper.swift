import SwiftUI
import UIKit

// MARK: - UIKit Wrapper for Member List
public class MemberListUIKitWrapper {
    
    // MARK: - Properties
    private let viewModel: DMCMemberListViewModel
    private let onClose: (() -> Void)?
    private let onMemberSelected: ((DMCMember) -> Void)?
    
    // MARK: - Initialization
    public init(
        viewModel: DMCMemberListViewModel = DMCMemberListViewModel(),
        onClose: (() -> Void)? = nil,
        onMemberSelected: ((DMCMember) -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.onClose = onClose
        self.onMemberSelected = onMemberSelected
    }
    
    // MARK: - Public Methods
    
    /// Creates a UIViewController that can be pushed to navigation
    public func createViewController() -> UIViewController {
        let memberListView = MemberListView(
            viewModel: viewModel,
            onClose: onClose,
            onMemberSelected: onMemberSelected
        )
        
        let hostingController = UIHostingController(rootView: memberListView)
        hostingController.title = AppStrings.Titles.selectMember
        
        return hostingController
    }
    
    /// Pushes the member list to the given navigation controller
    public func pushToNavigation(_ navigationController: UINavigationController, animated: Bool = true) {
        let viewController = createViewController()
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    /// Presents the member list modally from the given view controller
    public func presentModally(from viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        let memberListView = MemberListView(
            viewModel: viewModel,
            onClose: { [weak viewController] in
                viewController?.dismiss(animated: true, completion: nil)
            },
            onMemberSelected: { [weak viewController] member in
                self.onMemberSelected?(member)
                viewController?.dismiss(animated: true, completion: nil)
            }
        )
        
        let hostingController = UIHostingController(rootView: memberListView)
        hostingController.modalPresentationStyle = .formSheet
        
        viewController.present(hostingController, animated: animated, completion: completion)
    }
}

// MARK: - Convenience Extensions
public extension UINavigationController {
    
    /// Convenience method to push member list to navigation
    func pushMemberList(
        viewModel: DMCMemberListViewModel = DMCMemberListViewModel(),
        onClose: (() -> Void)? = nil,
        onMemberSelected: ((DMCMember) -> Void)? = nil,
        animated: Bool = true
    ) {
        let wrapper = MemberListUIKitWrapper(
            viewModel: viewModel,
            onClose: onClose,
            onMemberSelected: onMemberSelected
        )
        wrapper.pushToNavigation(self, animated: animated)
    }
}

public extension UIViewController {
    
    /// Convenience method to present member list modally
    func presentMemberList(
        viewModel: DMCMemberListViewModel = DMCMemberListViewModel(),
        onMemberSelected: ((DMCMember) -> Void)? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        let wrapper = MemberListUIKitWrapper(
            viewModel: viewModel,
            onMemberSelected: onMemberSelected
        )
        wrapper.presentModally(from: self, animated: animated, completion: completion)
    }
} 