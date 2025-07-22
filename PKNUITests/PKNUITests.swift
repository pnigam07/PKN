
//
//  PKNUITests.swift
//  PKNUITests
//
//  Created by pankaj nigam on 7/21/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import PKN

final class PKNUITests: XCTestCase {

    // MARK: - Basic Component Tests
    
    func testDMCMemberAvatarViewInitialization() throws {
        let avatarView = DMCMemberAvatarView(initials: "JD")
        let view = try avatarView.inspect()
        XCTAssertNotNil(view)
    }
    
    func testDMCMemberAvatarViewWithCustomSize() throws {
        let avatarView = DMCMemberAvatarView(
            initials: "AB",
            size: 50,
            backgroundColor: .blue,
            textColor: .white
        )
        let view = try avatarView.inspect()
        XCTAssertNotNil(view)
    }
    
    func testCloseButtonInitialization() throws {
        var actionCalled = false
        let closeButton = CloseButton(action: { actionCalled = true })
        let view = try closeButton.inspect()
        XCTAssertNotNil(view)
        XCTAssertFalse(actionCalled)
    }
    
    // MARK: - MemberListView ViewInspector Tests
    
    func testMemberListViewBasicStructure() throws {
        let viewModel = DMCMemberListViewModel()
        let memberListView = MemberListView(viewModel: viewModel)
        
        let view = try memberListView.inspect()
        XCTAssertNotNil(view)
        
        // Test navigation view structure
        let navigationView = try view.find(viewWithType: NavigationView.self)
        XCTAssertNotNil(navigationView)
    }
    
    func testMemberListViewWithMembers() throws {
        let members = [
            DMCMember(id: 1, name: "John Doe"),
            DMCMember(id: 2, name: "Jane Smith")
        ]
        let viewModel = DMCMemberListViewModel(members: members)
        let memberListView = MemberListView(viewModel: viewModel)
        
        let view = try memberListView.inspect()
        XCTAssertNotNil(view)
        
        // Test list accessibility
        let list = try view.find(viewWithId: MemberListAccessibility.list)
        XCTAssertNotNil(list)
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
        
        let view = try memberListView.inspect()
        XCTAssertNotNil(view)
        XCTAssertFalse(closeCalled)
        XCTAssertNil(memberSelected)
    }
    
    // MARK: - ViewInspector Cell Tests
    
    func testFindCellsInMemberListView() throws {
        let members = [
            DMCMember(id: 1, name: "John Doe"),
            DMCMember(id: 2, name: "Jane Smith"),
            DMCMember(id: 3, name: "Mike Johnson")
        ]
        let viewModel = DMCMemberListViewModel(members: members)
        let memberListView = MemberListView(viewModel: viewModel)
        
        let view = try memberListView.inspect()
        XCTAssertNotNil(view)
        
        // Find the List
        let list = try view.find(viewWithId: MemberListAccessibility.list)
        XCTAssertNotNil(list)
        
        // Find all cells in the list
        let cells = try list.findAll(MemberRowView.self)
        XCTAssertEqual(cells.count, 3)
        
        // Verify each cell has the correct member data
        for (index, cell) in cells.enumerated() {
            XCTAssertNotNil(cell)
            let member = members[index]
            
            // Check if the cell contains the member name
            let nameText = try cell.find(text: member.name)
            XCTAssertNotNil(nameText)
            
            // Check if the cell has the correct accessibility identifier
            let rowAccessibility = try cell.find(viewWithId: MemberListAccessibility.row(member.id))
            XCTAssertNotNil(rowAccessibility)
        }
    }
    
    func testFindSpecificCellByMemberID() throws {
        let members = [
            DMCMember(id: 1, name: "John Doe"),
            DMCMember(id: 2, name: "Jane Smith")
        ]
        let viewModel = DMCMemberListViewModel(members: members)
        let memberListView = MemberListView(viewModel: viewModel)
        
        let view = try memberListView.inspect()
        let list = try view.find(viewWithId: MemberListAccessibility.list)
        
        // Find specific cell by ID
        let cell = try list.find(viewWithId: MemberListAccessibility.row(1))
        XCTAssertNotNil(cell)
        
        // Verify the cell contains the correct name
        let nameText = try cell.find(text: "John Doe")
        XCTAssertNotNil(nameText)
    }
    
    func testFindCellWithAvatar() throws {
        let members = [DMCMember(id: 1, name: "John Doe")]
        let viewModel = DMCMemberListViewModel(members: members)
        let memberListView = MemberListView(viewModel: viewModel)
        
        let view = try memberListView.inspect()
        let list = try view.find(viewWithId: MemberListAccessibility.list)
        let cell = try list.find(viewWithId: MemberListAccessibility.row(1))
        
        // Find avatar within the cell
        let avatar = try cell.find(viewWithId: MemberListAccessibility.avatar(1))
        XCTAssertNotNil(avatar)
        
        // Find avatar circle
        let circle = try avatar.find(viewWithId: MemberListAccessibility.avatarCircle)
        XCTAssertNotNil(circle)
        
        // Find avatar initials
        let initials = try avatar.find(viewWithId: MemberListAccessibility.avatarInitials)
        XCTAssertNotNil(initials)
    }
    
    func testFindCellWithSelectedState() throws {
        let members = [DMCMember(id: 1, name: "John Doe")]
        let viewModel = DMCMemberListViewModel(members: members)
        let memberListView = MemberListView(viewModel: viewModel)
        
        let view = try memberListView.inspect()
        let list = try view.find(viewWithId: MemberListAccessibility.list)
        let cell = try list.find(viewWithId: MemberListAccessibility.row(1))
        
        // Initially should not be selected
        XCTAssertThrowsError(try cell.find(viewWithId: MemberListAccessibility.checkmark(1)))
        
        // Select the member
        viewModel.selectMember(members[0])
        
        // Re-inspect after selection
        let updatedView = try memberListView.inspect()
        let updatedList = try updatedView.find(viewWithId: MemberListAccessibility.list)
        let updatedCell = try updatedList.find(viewWithId: MemberListAccessibility.row(1))
        
        // Should now have checkmark
        let checkmark = try updatedCell.find(viewWithId: MemberListAccessibility.checkmark(1))
        XCTAssertNotNil(checkmark)
    }
    
    // MARK: - Edge Case Tests
    
    func testFindCellWithLongName() throws {
        let members = [DMCMember(id: 1, name: "This is a very long name that exceeds normal length")]
        let viewModel = DMCMemberListViewModel(members: members)
        let memberListView = MemberListView(viewModel: viewModel)
        
        let view = try memberListView.inspect()
        let list = try view.find(viewWithId: MemberListAccessibility.list)
        let cell = try list.find(viewWithId: MemberListAccessibility.row(1))
        
        let nameText = try cell.find(text: "This is a very long name that exceeds normal length")
        XCTAssertNotNil(nameText)
    }
    
    func testFindCellWithSpecialCharacters() throws {
        let members = [DMCMember(id: 1, name: "José María")]
        let viewModel = DMCMemberListViewModel(members: members)
        let memberListView = MemberListView(viewModel: viewModel)
        
        let view = try memberListView.inspect()
        let list = try view.find(viewWithId: MemberListAccessibility.list)
        let cell = try list.find(viewWithId: MemberListAccessibility.row(1))
        
        let nameText = try cell.find(text: "José María")
        XCTAssertNotNil(nameText)
    }
    
    func testFindCellWithEmptyName() throws {
        let members = [DMCMember(id: 1, name: "")]
        let viewModel = DMCMemberListViewModel(members: members)
        let memberListView = MemberListView(viewModel: viewModel)
        
        let view = try memberListView.inspect()
        let list = try view.find(viewWithId: MemberListAccessibility.list)
        let cell = try list.find(viewWithId: MemberListAccessibility.row(1))
        
        XCTAssertNotNil(cell)
    }
    
    func testFindCellWithNegativeID() throws {
        let members = [DMCMember(id: -1, name: "Negative ID")]
        let viewModel = DMCMemberListViewModel(members: members)
        let memberListView = MemberListView(viewModel: viewModel)
        
        let view = try memberListView.inspect()
        let list = try view.find(viewWithId: MemberListAccessibility.list)
        let cell = try list.find(viewWithId: MemberListAccessibility.row(-1))
        
        XCTAssertNotNil(cell)
        let nameText = try cell.find(text: "Negative ID")
        XCTAssertNotNil(nameText)
    }
    
    func testFindCellWithZeroID() throws {
        let members = [DMCMember(id: 0, name: "Zero ID")]
        let viewModel = DMCMemberListViewModel(members: members)
        let memberListView = MemberListView(viewModel: viewModel)
        
        let view = try memberListView.inspect()
        let list = try view.find(viewWithId: MemberListAccessibility.list)
        let cell = try list.find(viewWithId: MemberListAccessibility.row(0))
        
        XCTAssertNotNil(cell)
        let nameText = try cell.find(text: "Zero ID")
        XCTAssertNotNil(nameText)
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
}
