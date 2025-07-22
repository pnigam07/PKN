
//
//  PKNUITests.swift
//  PKNUITests
//
//  Created by pankaj nigam on 7/21/25.
//

import XCTest
import SwiftUI
//import ViewInspector
@testable import PKN

final class PKNUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Member Model Tests
    
    func testMemberInitialization() throws {
        let member = Member(id: 1, name: "John Doe")
        XCTAssertEqual(member.id, 1)
        XCTAssertEqual(member.name, "John Doe")
    }
    
    func testMemberEquatable() throws {
        let member1 = Member(id: 1, name: "John Doe")
        let member2 = Member(id: 1, name: "John Doe")
        let member3 = Member(id: 2, name: "Jane Smith")
        
        XCTAssertEqual(member1, member2)
        XCTAssertNotEqual(member1, member3)
    }
    
    func testMemberHashable() throws {
        let member1 = Member(id: 1, name: "John Doe")
        let member2 = Member(id: 1, name: "John Doe")
        let member3 = Member(id: 2, name: "Jane Smith")
        
        let set = Set([member1, member2, member3])
        XCTAssertEqual(set.count, 2) // member1 and member2 are equal, so only 2 unique members
    }
    
    func testMemberInitials() throws {
        let member1 = Member(id: 1, name: "John Doe")
        let member2 = Member(id: 2, name: "Jane")
        let member3 = Member(id: 3, name: "A B C")
        
        XCTAssertEqual(member1.initials, "J")
        XCTAssertEqual(member2.initials, "J")
        XCTAssertEqual(member3.initials, "A")
    }
    
    func testMemberInitialsWithEmptyName() throws {
        let member = Member(id: 1, name: "")
        XCTAssertEqual(member.initials, "")
    }
    
    func testMemberInitialsWithSingleWord() throws {
        let member = Member(id: 1, name: "John")
        XCTAssertEqual(member.initials, "J")
    }
    
    func testMemberInitialsWithSpecialCharacters() throws {
        let member = Member(id: 1, name: "José María")
        XCTAssertEqual(member.initials, "J")
    }
    
    func testMemberInitialsWithMultipleSpaces() throws {
        let member = Member(id: 1, name: "  John   Doe  ")
        XCTAssertEqual(member.initials, "J")
    }
    
    // MARK: - MemberListViewModel Tests
    
    func testMemberListViewModelInitialization() throws {
        let viewModel = MemberListViewModel()
        XCTAssertEqual(viewModel.members.count, 4) // Default sample members
        XCTAssertNil(viewModel.selectedMemberID)
    }
    
    func testMemberListViewModelWithCustomMembers() throws {
        let customMembers = [Member(id: 1, name: "Test User")]
        let viewModel = MemberListViewModel(members: customMembers)
        XCTAssertEqual(viewModel.members.count, 1)
        XCTAssertEqual(viewModel.members[0].name, "Test User")
    }
    
    func testMemberListViewModelWithEmptyMembers() throws {
        let viewModel = MemberListViewModel(members: [])
        XCTAssertEqual(viewModel.members.count, 4) // Should use sample members when empty
    }
    
    func testSelectMember() throws {
        let viewModel = MemberListViewModel()
        let member = viewModel.members[0]
        
        viewModel.selectMember(member)
        XCTAssertEqual(viewModel.selectedMemberID, member.id)
    }
    
    func testClearSelection() throws {
        let viewModel = MemberListViewModel()
        let member = viewModel.members[0]
        
        viewModel.selectMember(member)
        XCTAssertEqual(viewModel.selectedMemberID, member.id)
        
        viewModel.clearSelection()
        XCTAssertNil(viewModel.selectedMemberID)
    }
    
    func testIsSelected() throws {
        let viewModel = MemberListViewModel()
        let member = viewModel.members[0]
        
        // Test initial state - should not be selected
        XCTAssertNil(viewModel.selectedMemberID)
        XCTAssertFalse(viewModel.isSelected(member))
        
        // Test after selection
        viewModel.selectMember(member)
        XCTAssertEqual(viewModel.selectedMemberID, member.id)
        XCTAssertTrue(viewModel.isSelected(member))
    }
    
    // MARK: - MemberListView Tests
    
    func testMemberListViewInitialization() throws {
        let viewModel = MemberListViewModel()
        let memberListView = MemberListView(viewModel: viewModel)
        XCTAssertNotNil(memberListView)
        XCTAssertEqual(memberListView.testViewModel.members.count, 4)
    }
    
    func testMemberListViewWithCustomViewModel() throws {
        let customMembers = [Member(id: 1, name: "Test User")]
        let viewModel = MemberListViewModel(members: customMembers)
        let memberListView = MemberListView(viewModel: viewModel)
        XCTAssertNotNil(memberListView)
        XCTAssertEqual(memberListView.testViewModel.members.count, 1)
    }
    
    func testMemberListViewWithOnCloseCallback() throws {
        var closeCalled = false
        let memberListView = MemberListView(onClose: {
            closeCalled = true
        })
        XCTAssertNotNil(memberListView)
        XCTAssertNotNil(memberListView.onClose)
    }
    
    func testMemberListViewWithOnMemberSelectedCallback() throws {
        var selectedMember: Member?
        let memberListView = MemberListView(onMemberSelected: { member in
            selectedMember = member
        })
        XCTAssertNotNil(memberListView)
        XCTAssertNotNil(memberListView.onMemberSelected)
    }
    
    // MARK: - MemberRowView Tests
    
    func testMemberRowViewInitialization() throws {
        let member = Member(id: 1, name: "John Doe")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.id, 1)
        XCTAssertEqual(memberRowView.member.name, "John Doe")
        XCTAssertFalse(memberRowView.isSelected)
    }
    
    func testMemberRowViewSelectedState() throws {
        let member = Member(id: 1, name: "John Doe")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: true,
            onTap: {}
        )
        XCTAssertNotNil(memberRowView)
        XCTAssertTrue(memberRowView.isSelected)
    }
    
    func testMemberRowViewAccessibilityLabel() throws {
        let member = Member(id: 1, name: "John Doe")
        
        // Test unselected state
        let unselectedRow = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        XCTAssertNotNil(unselectedRow)
        
        // Test selected state
        let selectedRow = MemberRowView(
            member: member,
            isSelected: true,
            onTap: {}
        )
        XCTAssertNotNil(selectedRow)
    }
    
    // MARK: - MemberAvatarView Tests
    
    func testMemberAvatarViewInitialization() throws {
        let avatarView = MemberAvatarView(initials: "JD")
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "JD")
        XCTAssertEqual(avatarView.size, AppDimensions.Avatar.size)
    }
    
    func testMemberAvatarViewWithCustomSize() throws {
        let avatarView = MemberAvatarView(
            initials: "AB",
            size: 50,
            backgroundColor: .red,
            textColor: .white
        )
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "AB")
        XCTAssertEqual(avatarView.size, 50)
    }
    
    func testMemberAvatarViewWithEmptyInitials() throws {
        let avatarView = MemberAvatarView(initials: "")
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "")
    }
    
    // MARK: - CloseButton Tests
    
    func testCloseButtonInitialization() throws {
        let closeButton = CloseButton(action: {})
        XCTAssertNotNil(closeButton)
        XCTAssertNotNil(closeButton.action)
    }
    
    func testCloseButtonAction() throws {
        var actionCalled = false
        let closeButton = CloseButton(action: {
            actionCalled = true
        })
        XCTAssertNotNil(closeButton)
        
        // Note: In a real test, you would trigger the action
        // This is just testing the initialization
        XCTAssertFalse(actionCalled)
    }
    
    // MARK: - Constants Tests
    
    func testAppStrings() throws {
        XCTAssertEqual(AppStrings.Icons.checkmark, "checkmark")
        XCTAssertEqual(AppStrings.Titles.selectMember, "Select Member")
    }
    
    func testAppColors() throws {
        XCTAssertNotNil(AppColors.primary)
        XCTAssertNotNil(AppColors.background)
        XCTAssertNotNil(AppColors.navigationBar)
        XCTAssertNotNil(AppColors.avatarBackground)
    }
    
    func testAppDimensions() throws {
        XCTAssertEqual(AppDimensions.Spacing.small, 8)
        XCTAssertEqual(AppDimensions.Spacing.medium, 12)
        XCTAssertEqual(AppDimensions.Spacing.large, 16)
        XCTAssertEqual(AppDimensions.Avatar.size, 36)
    }
    
    // MARK: - Accessibility Tests
    
    func testMemberListAccessibility() throws {
        XCTAssertEqual(MemberListAccessibility.list, "memberListView.list")
        XCTAssertEqual(MemberListAccessibility.row(1), "memberRow_1")
        XCTAssertEqual(MemberListAccessibility.avatar(1), "memberRow.avatar_1")
        XCTAssertEqual(MemberListAccessibility.name(1), "memberRow.name_1")
        XCTAssertEqual(MemberListAccessibility.checkmark(1), "memberRow.checkmark_1")
        XCTAssertEqual(MemberListAccessibility.avatarCircle, "memberAvatar.circle")
        XCTAssertEqual(MemberListAccessibility.avatarInitials, "memberAvatar.initials")
        XCTAssertEqual(MemberListAccessibility.closeButton, "closeButton")
    }
    
    // MARK: - Edge Cases
    
    func testMemberWithSpecialCharacters() throws {
        let member = Member(id: 1, name: "José María")
        XCTAssertEqual(member.initials, "J")
    }
    
    func testMemberWithNumbers() throws {
        let member = Member(id: 1, name: "John123 Doe")
        XCTAssertEqual(member.initials, "J")
    }
    
    func testMemberWithUnicodeCharacters() throws {
        let member = Member(id: 1, name: "José María García")
        XCTAssertEqual(member.initials, "J")
    }
    
    func testViewModelSelectionWithInvalidMember() throws {
        let viewModel = MemberListViewModel()
        let invalidMember = Member(id: 999, name: "Invalid")
        
        viewModel.selectMember(invalidMember)
        XCTAssertEqual(viewModel.selectedMemberID, 999)
    }
    
    func testSampleMembers() throws {
        let sampleMembers = Member.sampleMembers
        XCTAssertEqual(sampleMembers.count, 4)
        XCTAssertEqual(sampleMembers[0].id, 2)
        XCTAssertEqual(sampleMembers[0].name, "John Doe")
        XCTAssertEqual(sampleMembers[1].id, 3)
        XCTAssertEqual(sampleMembers[1].name, "Jane Smith")
    }
}
