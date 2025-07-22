import SwiftUI

// MARK: - Member Model
public struct DMCMember: Identifiable, Equatable, Hashable, Codable {
    public let id: Int
    public let name: String
    
    public var avatarInitial: String {
        let trimiiedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return trimiiedName.isEmpty ? "" : String(trimiiedName.prefix(1).uppercased())
    }
    
    public static let sampleMembers = [
        DMCMember(id: 2, name: "John Doe"),
        DMCMember(id: 3, name: "Jane Smith"),
        DMCMember(id: 4, name: "Mike Johnson"),
        DMCMember(id: 5, name: "Sarah Wilson")
    ]
}

// MARK: - Member List View Model
public final class DMCMemberListViewModel: ObservableObject {
    @Published public var selectedMemberID: Int?
    
    public let members: [DMCMember]
    
    public init(members: [DMCMember] = []) {
        self.members = members.isEmpty ? DMCMember.sampleMembers : members
    }
    
    public func selectMember(_ member: DMCMember) { selectedMemberID = member.id }
    public func isSelected(_ member: DMCMember) -> Bool { selectedMemberID == member.id }
    public func clearSelection() { selectedMemberID = nil }
}

// MARK: - Accessibility
public struct MemberListAccessibility {
    public static let list = "memberListView.list"
    public static func row(_ id: Int) -> String { "memberRow_\(id)" }
    public static func avatar(_ id: Int) -> String { "memberRow.avatar_\(id)" }
    public static func name(_ id: Int) -> String { "memberRow.name_\(id)" }
    public static func checkmark(_ id: Int) -> String { "memberRow.checkmark_\(id)" }
    public static let avatarCircle = "memberAvatar.circle"
    public static let avatarInitials = "memberAvatar.initials"
    public static let closeButton = "closeButton"
}

public struct MemberListView: View {
    @StateObject var viewModel: DMCMemberListViewModel
    let onClose: (() -> Void)?
    let onMemberSelected: ((DMCMember) -> Void)?
    
    public init(viewModel: DMCMemberListViewModel = DMCMemberListViewModel(), onClose: (() -> Void)? = nil, onMemberSelected: ((DMCMember) -> Void)? = nil) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onClose = onClose
        self.onMemberSelected = onMemberSelected
    }
    
    // Expose viewModel for testing
    public var testViewModel: DMCMemberListViewModel { viewModel }
    
    public var body: some View {
        NavigationView {
            memberListContent
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { toolbarContent }
        }
        .background(AppColors.background)
    }
    
    private var memberListContent: some View {
                    List {
                ForEach(viewModel.members) { member in
                    MemberRowView(
                        member: member,
                        isSelected: viewModel.isSelected(member),
                        onTap: {
                            viewModel.selectMember(member)
                            onMemberSelected?(member)
                        }
                    )
                }
            }
        .listStyle(PlainListStyle())
        .frame(maxWidth: .infinity)
        .navigationTitle(AppStrings.Titles.selectMember)
        .toolbarBackground(.red, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .accessibilityIdentifier(MemberListAccessibility.list)
    }
    
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            if let onClose = onClose {
                CloseButton(action: onClose)
            }
        }
    }
}



// MARK: - Member Avatar View
public struct DMCMemberAvatarView: View {
    let initials: String
    let size: CGFloat
    let backgroundColor: Color
    let textColor: Color
    
    public init(initials: String, size: CGFloat = AppDimensions.Avatar.size, backgroundColor: Color = AppColors.avatarBackground, textColor: Color = AppColors.primary) {
        self.initials = initials
        self.size = size
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)
                .frame(width: size, height: size)
                .accessibilityIdentifier(MemberListAccessibility.avatarCircle)
            
            Text(initials)
                .font(.system(size: size * 0.4, weight: .semibold))
                .foregroundColor(textColor)
                .accessibilityIdentifier(MemberListAccessibility.avatarInitials)
        }
        .accessibilityHidden(true)
    }
}



// MARK: - Close Button
public struct CloseButton: View {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text("Close")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.primary)
        }
        .accessibilityLabel("Close")
        .accessibilityIdentifier(MemberListAccessibility.closeButton)
    }
}

#Preview {
    MemberListView()
} 
