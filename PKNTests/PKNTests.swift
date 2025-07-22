//
//  PKNTests.swift
//  PKNTests
//
//  Created by pankaj nigam on 7/21/25.
//

import XCTest
@testable import PKN

final class PKNTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Member Model Unit Tests
    
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
    
    func testMemberInitialsWithUnicodeCharacters() throws {
        let member = Member(id: 1, name: "José María García")
        XCTAssertEqual(member.initials, "J")
    }
    
    func testMemberInitialsWithNumbers() throws {
        let member = Member(id: 1, name: "John123 Doe")
        XCTAssertEqual(member.initials, "J")
    }
    
    func testMemberInitialsWithVeryLongName() throws {
        let member = Member(id: 1, name: "This is a very long name that exceeds normal length")
        XCTAssertEqual(member.initials, "T")
    }
    
    // MARK: - MemberListViewModel Unit Tests
    
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
    
    func testMultipleSelections() throws {
        let viewModel = MemberListViewModel()
        let member1 = viewModel.members[0]
        let member2 = viewModel.members[1]
        
        viewModel.selectMember(member1)
        XCTAssertEqual(viewModel.selectedMemberID, member1.id)
        XCTAssertTrue(viewModel.isSelected(member1))
        XCTAssertFalse(viewModel.isSelected(member2))
        
        viewModel.selectMember(member2)
        XCTAssertEqual(viewModel.selectedMemberID, member2.id)
        XCTAssertFalse(viewModel.isSelected(member1))
        XCTAssertTrue(viewModel.isSelected(member2))
    }
    
    func testSelectionWithInvalidMember() throws {
        let viewModel = MemberListViewModel()
        let invalidMember = Member(id: 999, name: "Invalid")
        
        viewModel.selectMember(invalidMember)
        XCTAssertEqual(viewModel.selectedMemberID, 999)
        XCTAssertTrue(viewModel.isSelected(invalidMember))
    }
    
    // MARK: - Constants Unit Tests
    
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
    
    // MARK: - Accessibility Unit Tests
    
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
    
    func testMemberListAccessibilityWithDifferentIDs() throws {
        XCTAssertEqual(MemberListAccessibility.row(42), "memberRow_42")
        XCTAssertEqual(MemberListAccessibility.avatar(42), "memberRow.avatar_42")
        XCTAssertEqual(MemberListAccessibility.name(42), "memberRow.name_42")
        XCTAssertEqual(MemberListAccessibility.checkmark(42), "memberRow.checkmark_42")
    }
    
    func testMemberListAccessibilityWithNegativeIDs() throws {
        XCTAssertEqual(MemberListAccessibility.row(-1), "memberRow_-1")
        XCTAssertEqual(MemberListAccessibility.avatar(-1), "memberRow.avatar_-1")
        XCTAssertEqual(MemberListAccessibility.name(-1), "memberRow.name_-1")
        XCTAssertEqual(MemberListAccessibility.checkmark(-1), "memberRow.checkmark_-1")
    }
    
    func testMemberListAccessibilityWithZeroID() throws {
        XCTAssertEqual(MemberListAccessibility.row(0), "memberRow_0")
        XCTAssertEqual(MemberListAccessibility.avatar(0), "memberRow.avatar_0")
        XCTAssertEqual(MemberListAccessibility.name(0), "memberRow.name_0")
        XCTAssertEqual(MemberListAccessibility.checkmark(0), "memberRow.checkmark_0")
    }
    
    // MARK: - Sample Data Unit Tests
    
    func testSampleMembers() throws {
        let sampleMembers = Member.sampleMembers
        XCTAssertEqual(sampleMembers.count, 4)
        XCTAssertEqual(sampleMembers[0].id, 2)
        XCTAssertEqual(sampleMembers[0].name, "John Doe")
        XCTAssertEqual(sampleMembers[1].id, 3)
        XCTAssertEqual(sampleMembers[1].name, "Jane Smith")
        XCTAssertEqual(sampleMembers[2].id, 4)
        XCTAssertEqual(sampleMembers[2].name, "Mike Johnson")
        XCTAssertEqual(sampleMembers[3].id, 5)
        XCTAssertEqual(sampleMembers[3].name, "Sarah Wilson")
    }
    
    func testSampleMembersInitials() throws {
        let sampleMembers = Member.sampleMembers
        XCTAssertEqual(sampleMembers[0].initials, "J") // John Doe
        XCTAssertEqual(sampleMembers[1].initials, "J") // Jane Smith
        XCTAssertEqual(sampleMembers[2].initials, "M") // Mike Johnson
        XCTAssertEqual(sampleMembers[3].initials, "S") // Sarah Wilson
    }
    
    // MARK: - Edge Cases Unit Tests
    
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
    
    func testMemberWithDuplicateIDs() throws {
        let member1 = Member(id: 1, name: "First")
        let member2 = Member(id: 1, name: "Second") // Duplicate ID
        let member3 = Member(id: 2, name: "Third")
        
        XCTAssertEqual(member1, member2) // Same ID means equal
        XCTAssertNotEqual(member1, member3)
    }
    
    func testMemberWithNegativeIDs() throws {
        let member = Member(id: -1, name: "Negative")
        XCTAssertEqual(member.id, -1)
        XCTAssertEqual(member.name, "Negative")
        XCTAssertEqual(member.initials, "N")
    }
    
    func testMemberWithZeroID() throws {
        let member = Member(id: 0, name: "Zero")
        XCTAssertEqual(member.id, 0)
        XCTAssertEqual(member.name, "Zero")
        XCTAssertEqual(member.initials, "Z")
    }
    
    func testViewModelWithDuplicateMembers() throws {
        let members = [
            Member(id: 1, name: "John Doe"),
            Member(id: 1, name: "John Doe"), // Duplicate ID
            Member(id: 2, name: "Jane Smith")
        ]
        let viewModel = MemberListViewModel(members: members)
        XCTAssertEqual(viewModel.members.count, 3)
    }
    
    func testViewModelSelectionWithNegativeID() throws {
        let viewModel = MemberListViewModel()
        let negativeMember = Member(id: -1, name: "Negative")
        
        viewModel.selectMember(negativeMember)
        XCTAssertEqual(viewModel.selectedMemberID, -1)
        XCTAssertTrue(viewModel.isSelected(negativeMember))
    }
    
    func testViewModelSelectionWithZeroID() throws {
        let viewModel = MemberListViewModel()
        let zeroMember = Member(id: 0, name: "Zero")
        
        viewModel.selectMember(zeroMember)
        XCTAssertEqual(viewModel.selectedMemberID, 0)
        XCTAssertTrue(viewModel.isSelected(zeroMember))
    }
    
    // MARK: - Performance Unit Tests
    
    func testMemberInitialsPerformance() throws {
        let member = Member(id: 1, name: "This is a very long name for performance testing")
        
        measure {
            for _ in 1...1000 {
                _ = member.initials
            }
        }
    }
    
    func testViewModelSelectionPerformance() throws {
        let largeMembers = (1...1000).map { index in
            Member(id: index, name: "Member \(index)")
        }
        let viewModel = MemberListViewModel(members: largeMembers)
        
        measure {
            for member in largeMembers {
                viewModel.selectMember(member)
                _ = viewModel.isSelected(member)
                viewModel.clearSelection()
            }
        }
    }
}
