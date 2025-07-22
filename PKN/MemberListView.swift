import SwiftUI

// MARK: - Member Model
struct Member: Identifiable, Equatable, Hashable, Codable {
    let id: Int
    let name: String
    
    var initials: String {
        let components = name.components(separatedBy: " ")
        
        return components.first?.prefix(1).uppercased() ?? String(name.prefix(1)).uppercased()
    }
    
    static let sampleMembers = [
        Member(id: 2, name: "John Doe"),
        Member(id: 3, name: "Jane Smith"),
        Member(id: 4, name: "Mike Johnson"),
        Member(id: 5, name: "Sarah Wilson")
    ]
}

// MARK: - Member List View Model
final class MemberListViewModel: ObservableObject {
    @Published var selectedMemberID: Int?
    
    let members: [Member]
    
    init(members: [Member] = []) {
        self.members = members.isEmpty ? Member.sampleMembers : members
    }
    
    func selectMember(_ member: Member) { selectedMemberID = member.id }
    func isSelected(_ member: Member) -> Bool { selectedMemberID == member.id }
    func clearSelection() { selectedMemberID = nil }
}

// MARK: - Accessibility
struct MemberListAccessibility {
    static let list = "memberListView.list"
    static func row(_ id: Int) -> String { "memberRow_\(id)" }
    static func avatar(_ id: Int) -> String { "memberRow.avatar_\(id)" }
    static func name(_ id: Int) -> String { "memberRow.name_\(id)" }
    static func checkmark(_ id: Int) -> String { "memberRow.checkmark_\(id)" }
    static let avatarCircle = "memberAvatar.circle"
    static let avatarInitials = "memberAvatar.initials"
    static let closeButton = "closeButton"
}

struct MemberListView: View {
    @StateObject var viewModel: MemberListViewModel
    let onClose: (() -> Void)?
    let onMemberSelected: ((Member) -> Void)?
    
    init(viewModel: MemberListViewModel = MemberListViewModel(), onClose: (() -> Void)? = nil, onMemberSelected: ((Member) -> Void)? = nil) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onClose = onClose
        self.onMemberSelected = onMemberSelected
    }
    
    // Expose viewModel for testing
    var testViewModel: MemberListViewModel { viewModel }
    
    var body: some View {
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
        .toolbarBackground(AppColors.navigationBar, for: .navigationBar)
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
struct MemberAvatarView: View {
    let initials: String
    let size: CGFloat
    let backgroundColor: Color
    let textColor: Color
    
    init(initials: String, size: CGFloat = AppDimensions.Avatar.size, backgroundColor: Color = AppColors.avatarBackground, textColor: Color = AppColors.primary) {
        self.initials = initials
        self.size = size
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
    
    var body: some View {
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
struct CloseButton: View {
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
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
