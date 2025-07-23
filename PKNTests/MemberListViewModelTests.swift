//
//  MemberListViewModelTests.swift
//  MYNew
//
//  Created by pankaj nigam on 7/21/25.
//

import XCTest
import Combine

@MainActor
final class MemberListViewModelTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }
    
    // MARK: - Test Case 1: Member Selection and State Management
    
    func testMemberSelectionAndStateManagement() {
        let expectation = XCTestExpectation(description: "Member selection should update state correctly")
        let viewModel = DMCMemberListViewModel()
        var receivedSelections: [Int?] = []
        
        // Subscribe to selection changes
        viewModel.$selectedMemberID
            .sink { selection in
                receivedSelections.append(selection)
                if receivedSelections.count >= 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Test initial state
        XCTAssertNil(viewModel.selectedMemberID, "Initial selection should be nil")
        XCTAssertEqual(viewModel.members.count, 4, "Should have 4 sample members")
        
        // Test member selection
        let firstMember = viewModel.members[0]
        viewModel.selectMember(firstMember)
        
        XCTAssertEqual(viewModel.selectedMemberID, firstMember.id, "Selected member ID should match")
        XCTAssertTrue(viewModel.isSelected(firstMember), "First member should be selected")
        XCTAssertFalse(viewModel.isSelected(viewModel.members[1]), "Second member should not be selected")
        
        // Test member deselection
        viewModel.clearSelection()
        
        XCTAssertNil(viewModel.selectedMemberID, "Selection should be cleared")
        XCTAssertFalse(viewModel.isSelected(firstMember), "First member should not be selected after clearing")
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedSelections, [nil, firstMember.id, nil], "Publisher should emit correct selection changes")
    }
    
    // MARK: - Test Case 2: Custom Members Initialization and Validation
    
    func testCustomMembersInitializationAndValidation() {
        let customMembers = [
            DMCMember(id: 101, name: "Alice Johnson"),
            DMCMember(id: 102, name: "Bob Smith"),
            DMCMember(id: 103, name: "Charlie Brown")
        ]
        
        let viewModel = DMCMemberListViewModel(members: customMembers)
        
        // Test custom members initialization
        XCTAssertEqual(viewModel.members.count, 3, "Should have 3 custom members")
        XCTAssertEqual(viewModel.members[0].name, "Alice Johnson", "First member name should match")
        XCTAssertEqual(viewModel.members[1].id, 102, "Second member ID should match")
        XCTAssertEqual(viewModel.members[2].avatarInitial, "C", "Third member avatar initial should be 'C'")
        
        // Test member selection with custom members
        let alice = viewModel.members[0]
        let bob = viewModel.members[1]
        
        viewModel.selectMember(alice)
        XCTAssertTrue(viewModel.isSelected(alice), "Alice should be selected")
        XCTAssertFalse(viewModel.isSelected(bob), "Bob should not be selected")
        
        // Test switching selection
        viewModel.selectMember(bob)
        XCTAssertFalse(viewModel.isSelected(alice), "Alice should not be selected after switching")
        XCTAssertTrue(viewModel.isSelected(bob), "Bob should be selected")
        XCTAssertEqual(viewModel.selectedMemberID, bob.id, "Selected member ID should be Bob's ID")
        
        // Test member properties
        XCTAssertEqual(alice.avatarInitial, "A", "Alice's avatar initial should be 'A'")
        XCTAssertEqual(bob.avatarInitial, "B", "Bob's avatar initial should be 'B'")
        XCTAssertEqual(alice.id, 101, "Alice's ID should be 101")
        XCTAssertEqual(bob.id, 102, "Bob's ID should be 102")
    }
} 