//
//  MemberListViewTests.swift
//  PKNUITests
//
//  Created by pankaj nigam on 7/21/25.
//

import XCTest
import SwiftUI
//import ViewInspector
@testable import PKN

final class MemberListViewTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - MemberListView Integration Tests
    
    func testMemberListViewWithMultipleMembers() throws {
        let multipleMembers = [
            Member(id: 1, name: "Alice Johnson"),
            Member(id: 2, name: "Bob Smith"),
            Member(id: 3, name: "Charlie Brown"),
            Member(id: 4, name: "Diana Prince")
        ]
        let viewModel = MemberListViewModel(members: multipleMembers)
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        XCTAssertEqual(memberListView.testViewModel.members.count, 4)
        XCTAssertEqual(memberListView.testViewModel.members[0].name, "Alice Johnson")
        XCTAssertEqual(memberListView.testViewModel.members[1].name, "Bob Smith")
    }
    
    func testMemberListViewWithEmptyMembers() throws {
        let emptyMembers: [Member] = []
        let viewModel = MemberListViewModel(members: emptyMembers)
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        // Should use sample members when empty
        XCTAssertEqual(memberListView.testViewModel.members.count, 4)
    }
    
    func testMemberListViewWithLongNames() throws {
        let longNameMembers = [
            Member(id: 1, name: "Very Long Name That Exceeds Normal Length"),
            Member(id: 2, name: "Another Very Long Name With Multiple Words")
        ]
        let viewModel = MemberListViewModel(members: longNameMembers)
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        XCTAssertEqual(memberListView.testViewModel.members.count, 2)
        XCTAssertEqual(memberListView.testViewModel.members[0].name, "Very Long Name That Exceeds Normal Length")
    }
    
    func testMemberListViewWithSpecialCharacters() throws {
        let specialCharMembers = [
            Member(id: 1, name: "José María"),
            Member(id: 2, name: "Jean-Pierre"),
            Member(id: 3, name: "O'Connor")
        ]
        let viewModel = MemberListViewModel(members: specialCharMembers)
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        XCTAssertEqual(memberListView.testViewModel.members.count, 3)
    }
    
    func testMemberListViewWithUnicodeNames() throws {
        let unicodeMembers = [
            Member(id: 1, name: "José María García"),
            Member(id: 2, name: "François Dupont"),
            Member(id: 3, name: "Björk Guðmundsdóttir")
        ]
        let viewModel = MemberListViewModel(members: unicodeMembers)
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        XCTAssertEqual(memberListView.testViewModel.members.count, 3)
    }
    
    func testMemberListViewWithEmptyNames() throws {
        let emptyNameMembers = [
            Member(id: 1, name: ""),
            Member(id: 2, name: "John Doe")
        ]
        let viewModel = MemberListViewModel(members: emptyNameMembers)
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        XCTAssertEqual(memberListView.testViewModel.members.count, 2)
        XCTAssertEqual(memberListView.testViewModel.members[0].name, "")
    }
    
    func testMemberListViewWithInvalidData() throws {
        let invalidMembers = [
            Member(id: -1, name: "Invalid Member"),
            Member(id: 0, name: "Zero ID Member")
        ]
        let viewModel = MemberListViewModel(members: invalidMembers)
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        XCTAssertEqual(memberListView.testViewModel.members.count, 2)
        XCTAssertEqual(memberListView.testViewModel.members[0].id, -1)
    }
    
    // MARK: - MemberListView Callback Tests
    
    func testMemberListViewOnCloseCallback() throws {
        var closeCallbackCalled = false
        let memberListView = MemberListView(onClose: {
            closeCallbackCalled = true
        })
        
        XCTAssertNotNil(memberListView)
        XCTAssertNotNil(memberListView.onClose)
        // Note: In a real UI test, you would trigger the close action
        XCTAssertFalse(closeCallbackCalled)
    }
    
    func testMemberListViewOnMemberSelectedCallback() throws {
        var selectedMember: Member?
        let memberListView = MemberListView(onMemberSelected: { member in
            selectedMember = member
        })
        
        XCTAssertNotNil(memberListView)
        XCTAssertNotNil(memberListView.onMemberSelected)
        XCTAssertNil(selectedMember) // Should be nil initially
    }
    
    func testMemberListViewWithBothCallbacks() throws {
        var closeCalled = false
        var selectedMember: Member?
        
        let memberListView = MemberListView(
            onClose: { closeCalled = true },
            onMemberSelected: { member in selectedMember = member }
        )
        
        XCTAssertNotNil(memberListView)
        XCTAssertNotNil(memberListView.onClose)
        XCTAssertNotNil(memberListView.onMemberSelected)
        XCTAssertFalse(closeCalled)
        XCTAssertNil(selectedMember)
    }
    
    // MARK: - MemberListView ViewModel Integration Tests
    
    func testMemberListViewViewModelSelection() throws {
        let members = [
            Member(id: 1, name: "Alice"),
            Member(id: 2, name: "Bob"),
            Member(id: 3, name: "Charlie")
        ]
        let viewModel = MemberListViewModel(members: members)
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        XCTAssertNil(memberListView.testViewModel.selectedMemberID)
        
        // Test selection
        let firstMember = memberListView.testViewModel.members[0]
        memberListView.testViewModel.selectMember(firstMember)
        XCTAssertEqual(memberListView.testViewModel.selectedMemberID, 1)
        XCTAssertTrue(memberListView.testViewModel.isSelected(firstMember))
        
        // Test clearing selection
        memberListView.testViewModel.clearSelection()
        XCTAssertNil(memberListView.testViewModel.selectedMemberID)
        XCTAssertFalse(memberListView.testViewModel.isSelected(firstMember))
    }
    
    func testMemberListViewViewModelMultipleSelections() throws {
        let members = [
            Member(id: 1, name: "Alice"),
            Member(id: 2, name: "Bob"),
            Member(id: 3, name: "Charlie")
        ]
        let viewModel = MemberListViewModel(members: members)
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        
        // Test selecting different members
        let firstMember = memberListView.testViewModel.members[0]
        let secondMember = memberListView.testViewModel.members[1]
        
        memberListView.testViewModel.selectMember(firstMember)
        XCTAssertEqual(memberListView.testViewModel.selectedMemberID, 1)
        XCTAssertTrue(memberListView.testViewModel.isSelected(firstMember))
        XCTAssertFalse(memberListView.testViewModel.isSelected(secondMember))
        
        memberListView.testViewModel.selectMember(secondMember)
        XCTAssertEqual(memberListView.testViewModel.selectedMemberID, 2)
        XCTAssertFalse(memberListView.testViewModel.isSelected(firstMember))
        XCTAssertTrue(memberListView.testViewModel.isSelected(secondMember))
    }
    
    // MARK: - MemberListView Performance Tests
    
    func testMemberListViewWithLargeDataset() throws {
        let largeMembers = (1...100).map { index in
            Member(id: index, name: "Member \(index)")
        }
        let viewModel = MemberListViewModel(members: largeMembers)
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        XCTAssertEqual(memberListView.testViewModel.members.count, 100)
        
        // Test performance of selection
        let startTime = CFAbsoluteTimeGetCurrent()
        let firstMember = memberListView.testViewModel.members[0]
        memberListView.testViewModel.selectMember(firstMember)
        let endTime = CFAbsoluteTimeGetCurrent()
        
        XCTAssertEqual(memberListView.testViewModel.selectedMemberID, 1)
        XCTAssertLessThan(endTime - startTime, 0.1) // Should be very fast
    }
    
    // MARK: - MemberListView Edge Cases
    
    func testMemberListViewWithDuplicateIDs() throws {
        let duplicateMembers = [
            Member(id: 1, name: "First"),
            Member(id: 1, name: "Second"), // Duplicate ID
            Member(id: 2, name: "Third")
        ]
        let viewModel = MemberListViewModel(members: duplicateMembers)
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        XCTAssertEqual(memberListView.testViewModel.members.count, 3)
        
        // Test that selection works with duplicates
        let firstMember = memberListView.testViewModel.members[0]
        memberListView.testViewModel.selectMember(firstMember)
        XCTAssertEqual(memberListView.testViewModel.selectedMemberID, 1)
    }
    
    func testMemberListViewWithNegativeIDs() throws {
        let negativeMembers = [
            Member(id: -1, name: "Negative"),
            Member(id: -2, name: "Another Negative")
        ]
        let viewModel = MemberListViewModel(members: negativeMembers)
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        XCTAssertEqual(memberListView.testViewModel.members.count, 2)
        
        // Test selection with negative IDs
        let firstMember = memberListView.testViewModel.members[0]
        memberListView.testViewModel.selectMember(firstMember)
        XCTAssertEqual(memberListView.testViewModel.selectedMemberID, -1)
    }
    
    func testMemberListViewWithZeroID() throws {
        let zeroMember = Member(id: 0, name: "Zero ID")
        let viewModel = MemberListViewModel(members: [zeroMember])
        let memberListView = MemberListView(viewModel: viewModel)
        
        XCTAssertNotNil(memberListView)
        XCTAssertEqual(memberListView.testViewModel.members.count, 1)
        
        // Test selection with zero ID
        let member = memberListView.testViewModel.members[0]
        memberListView.testViewModel.selectMember(member)
        XCTAssertEqual(memberListView.testViewModel.selectedMemberID, 0)
    }
} 