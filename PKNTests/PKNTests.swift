//
//  PKNTests.swift
//  PKNTests
//
//  Created by pankaj nigam on 7/21/25.
//

import XCTest
@testable import PKN

final class PKNTests: XCTestCase {

    // MARK: - DMCMember Model Tests
    
    func testMemberInitialization() throws {
        let member = DMCMember(id: 1, name: "John Doe")
        XCTAssertEqual(member.id, 1)
        XCTAssertEqual(member.name, "John Doe")
    }
    
    func testMemberEquatable() throws {
        let member1 = DMCMember(id: 1, name: "John Doe")
        let member2 = DMCMember(id: 1, name: "John Doe")
        let member3 = DMCMember(id: 2, name: "Jane Smith")
        
        XCTAssertEqual(member1, member2)
        XCTAssertNotEqual(member1, member3)
    }
    
    func testMemberHashable() throws {
        let member1 = DMCMember(id: 1, name: "John Doe")
        let member2 = DMCMember(id: 1, name: "John Doe")
        let member3 = DMCMember(id: 2, name: "Jane Smith")
        
        let set = Set([member1, member2, member3])
        XCTAssertEqual(set.count, 2)
    }
    
    func testMemberAvatarInitial() throws {
        let member1 = DMCMember(id: 1, name: "John Doe")
        let member2 = DMCMember(id: 2, name: "Jane")
        let member3 = DMCMember(id: 3, name: "")
        let member4 = DMCMember(id: 4, name: "  John   Doe  ")
        
        XCTAssertEqual(member1.avatarInitial, "J")
        XCTAssertEqual(member2.avatarInitial, "J")
        XCTAssertEqual(member3.avatarInitial, "")
        XCTAssertEqual(member4.avatarInitial, "J")
    }
    
    func testSampleMembers() throws {
        XCTAssertEqual(DMCMember.sampleMembers.count, 4)
        XCTAssertEqual(DMCMember.sampleMembers[0].name, "John Doe")
        XCTAssertEqual(DMCMember.sampleMembers[1].name, "Jane Smith")
    }
    
    // MARK: - DMCMemberListViewModel Tests
    
    func testViewModelInitialization() throws {
        let viewModel = DMCMemberListViewModel()
        XCTAssertEqual(viewModel.members.count, 4)
        XCTAssertNil(viewModel.selectedMemberID)
    }
    
    func testViewModelWithCustomMembers() throws {
        let customMembers = [DMCMember(id: 1, name: "Test User")]
        let viewModel = DMCMemberListViewModel(members: customMembers)
        XCTAssertEqual(viewModel.members.count, 1)
        XCTAssertEqual(viewModel.members[0].name, "Test User")
    }
    
    func testViewModelWithEmptyMembers() throws {
        let viewModel = DMCMemberListViewModel(members: [])
        XCTAssertEqual(viewModel.members.count, 4) // Uses sample members
    }
    
    func testSelectMember() throws {
        let viewModel = DMCMemberListViewModel()
        let member = viewModel.members[0]
        
        viewModel.selectMember(member)
        XCTAssertEqual(viewModel.selectedMemberID, member.id)
    }
    
    func testClearSelection() throws {
        let viewModel = DMCMemberListViewModel()
        let member = viewModel.members[0]
        
        viewModel.selectMember(member)
        XCTAssertEqual(viewModel.selectedMemberID, member.id)
        
        viewModel.clearSelection()
        XCTAssertNil(viewModel.selectedMemberID)
    }
    
    func testIsSelected() throws {
        let viewModel = DMCMemberListViewModel()
        let member = viewModel.members[0]
        
        XCTAssertFalse(viewModel.isSelected(member))
        
        viewModel.selectMember(member)
        XCTAssertTrue(viewModel.isSelected(member))
    }
    
    // MARK: - MemberListView Tests
    
    func testMemberListViewInitialization() throws {
        let viewModel = DMCMemberListViewModel()
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        XCTAssertEqual(memberListView.testViewModel.members.count, 4)
    }
    
    func testMemberListViewWithCallbacks() throws {
        var closeCalled = false
        var memberSelected: DMCMember?
        
        let viewModel = DMCMemberListViewModel()
        let memberListView = MemberListView(
            viewModel: viewModel,
            onClose: { closeCalled = true },
            onMemberSelected: { member in memberSelected = member }
        )
        
        XCTAssertNotNil(memberListView)
        XCTAssertFalse(closeCalled)
        XCTAssertNil(memberSelected)
    }
    
    func testMemberListViewWithoutCallbacks() throws {
        let viewModel = DMCMemberListViewModel()
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        XCTAssertNil(memberListView.onClose)
        XCTAssertNil(memberListView.onMemberSelected)
    }
    
    // MARK: - DMCMemberAvatarView Tests
    
    func testDMCMemberAvatarViewInitialization() throws {
        let avatarView = DMCMemberAvatarView(initials: "JD")
        
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "JD")
    }
    
    func testDMCMemberAvatarViewWithCustomProperties() throws {
        let avatarView = DMCMemberAvatarView(
            initials: "AB",
            size: 50,
            backgroundColor: .blue,
            textColor: .white
        )
        
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "AB")
        XCTAssertEqual(avatarView.size, 50)
    }
    
    // MARK: - CloseButton Tests
    
    func testCloseButtonInitialization() throws {
        var actionCalled = false
        let closeButton = CloseButton(action: { actionCalled = true })
        
        XCTAssertNotNil(closeButton)
        XCTAssertFalse(actionCalled)
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
    
    // MARK: - Constants Tests
    
    func testAppStrings() throws {
        XCTAssertNotNil(AppStrings.Titles.selectMember)
    }
    
    func testAppColors() throws {
        XCTAssertNotNil(AppColors.background)
        XCTAssertNotNil(AppColors.primary)
        XCTAssertNotNil(AppColors.avatarBackground)
    }
    
    func testAppDimensions() throws {
        XCTAssertNotNil(AppDimensions.Avatar.size)
    }
    
    // MARK: - Performance Tests
    
    func testMemberInitialsPerformance() throws {
        let member = DMCMember(id: 1, name: "John Doe")
        
        measure {
            for _ in 0..<1000 {
                _ = member.avatarInitial
            }
        }
    }
    
    func testViewModelSelectionPerformance() throws {
        let viewModel = DMCMemberListViewModel()
        let member = viewModel.members[0]
        
        measure {
            for _ in 0..<1000 {
                viewModel.selectMember(member)
                viewModel.clearSelection()
            }
        }
    }
}
