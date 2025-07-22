import SwiftUI

public struct MemberRowView: View {
    let member: DMCMember
    let isSelected: Bool
    let onTap: () -> Void
    
    public init(member: DMCMember, isSelected: Bool, onTap: @escaping () -> Void) {
        self.member = member
        self.isSelected = isSelected
        self.onTap = onTap
    }
    
    public var body: some View {
        HStack(spacing: AppDimensions.Spacing.large) {
            DMCMemberAvatarView(initials: member.avatarInitial)
                .accessibilityIdentifier(MemberListAccessibility.avatar(member.id))
            
            VStack(alignment: .leading, spacing: AppDimensions.Spacing.small) {
                Text(member.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .accessibilityIdentifier(MemberListAccessibility.name(member.id))
            }
            
            Spacer()
            
            if isSelected {
                Image(systemName: AppStrings.Icons.checkmark)
                    .foregroundColor(AppColors.primary)
                    .font(.system(size: 16, weight: .medium))
                    .accessibilityHidden(true)
                    .accessibilityIdentifier(MemberListAccessibility.checkmark(member.id))
            }
        }
        .padding(.vertical, AppDimensions.Spacing.small)
        .padding(.horizontal, AppDimensions.Spacing.medium)
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityIdentifier(MemberListAccessibility.row(member.id))
    }
    
    private var accessibilityLabel: String {
        var label = member.name
        if isSelected { label += ", selected" }
        return label
    }
} 
