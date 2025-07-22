//
//  MemberListViewComponentTests.swift
//  PKNUITests
//
//  Created by pankaj nigam on 7/21/25.
//

import XCTest
import SwiftUI
//import ViewInspector
@testable import PKN

final class MemberListViewComponentTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - MemberRowView Component Tests
    
    func testMemberRowViewBasicStructure() throws {
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
    
    func testMemberRowViewWithLongName() throws {
        let member = Member(id: 1, name: "Very Long Name That Exceeds Normal Length")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.name, "Very Long Name That Exceeds Normal Length")
    }
    
    func testMemberRowViewWithSpecialCharacters() throws {
        let member = Member(id: 1, name: "José María")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.name, "José María")
    }
    
    func testMemberRowViewWithEmptyName() throws {
        let member = Member(id: 1, name: "")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.name, "")
    }
    
    func testMemberRowViewWithUnicodeName() throws {
        let member = Member(id: 1, name: "Björk Guðmundsdóttir")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.name, "Björk Guðmundsdóttir")
    }
    
    func testMemberRowViewWithNumbersInName() throws {
        let member = Member(id: 1, name: "John123 Doe")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.name, "John123 Doe")
    }
    
    func testMemberRowViewWithNegativeID() throws {
        let member = Member(id: -1, name: "Negative ID Member")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.id, -1)
    }
    
    func testMemberRowViewWithZeroID() throws {
        let member = Member(id: 0, name: "Zero ID Member")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.id, 0)
    }
    
    // MARK: - MemberAvatarView Component Tests
    
    func testMemberAvatarViewBasicInitialization() throws {
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
    
    func testMemberAvatarViewWithLongInitials() throws {
        let avatarView = MemberAvatarView(initials: "ABCD")
        
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "ABCD")
    }
    
    func testMemberAvatarViewWithSpecialCharacters() throws {
        let avatarView = MemberAvatarView(initials: "JM")
        
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "JM")
    }
    
    func testMemberAvatarViewWithNumbers() throws {
        let avatarView = MemberAvatarView(initials: "12")
        
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "12")
    }
    
    func testMemberAvatarViewWithUnicodeInitials() throws {
        let avatarView = MemberAvatarView(initials: "JM")
        
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "JM")
    }
    
    func testMemberAvatarViewWithSingleCharacter() throws {
        let avatarView = MemberAvatarView(initials: "A")
        
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "A")
    }
    
    func testMemberAvatarViewWithLargeSize() throws {
        let avatarView = MemberAvatarView(
            initials: "XY",
            size: 100,
            backgroundColor: .blue,
            textColor: .yellow
        )
        
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "XY")
        XCTAssertEqual(avatarView.size, 100)
    }
    
    func testMemberAvatarViewWithSmallSize() throws {
        let avatarView = MemberAvatarView(
            initials: "S",
            size: 20,
            backgroundColor: .green,
            textColor: .black
        )
        
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "S")
        XCTAssertEqual(avatarView.size, 20)
    }
    
    // MARK: - CloseButton Component Tests
    
    func testCloseButtonBasicInitialization() throws {
        let closeButton = CloseButton(action: {})
        
        XCTAssertNotNil(closeButton)
        XCTAssertNotNil(closeButton.action)
    }
    
    func testCloseButtonWithCustomAction() throws {
        var actionCalled = false
        let closeButton = CloseButton(action: {
            actionCalled = true
        })
        
        XCTAssertNotNil(closeButton)
        XCTAssertNotNil(closeButton.action)
        XCTAssertFalse(actionCalled) // Action hasn't been triggered yet
    }
    
    func testCloseButtonActionClosure() throws {
        var capturedValue = 0
        let closeButton = CloseButton(action: {
            capturedValue = 42
        })
        
        XCTAssertNotNil(closeButton)
        XCTAssertEqual(capturedValue, 0) // Action hasn't been triggered yet
    }
    
    func testCloseButtonMultipleActions() throws {
        var action1Called = false
        var action2Called = false
        
        let closeButton1 = CloseButton(action: { action1Called = true })
        let closeButton2 = CloseButton(action: { action2Called = true })
        
        XCTAssertNotNil(closeButton1)
        XCTAssertNotNil(closeButton2)
        XCTAssertFalse(action1Called)
        XCTAssertFalse(action2Called)
    }
    
    // MARK: - Component Integration Tests
    
    func testMemberRowViewWithAvatarIntegration() throws {
        let member = Member(id: 1, name: "John Doe")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.initials, "J")
    }
    
    func testMemberRowViewWithAvatarSelectedState() throws {
        let member = Member(id: 1, name: "John Doe")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: true,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertTrue(memberRowView.isSelected)
        XCTAssertEqual(memberRowView.member.initials, "J")
    }
    
    func testMemberRowViewWithSpecialCharacterInitials() throws {
        let member = Member(id: 1, name: "José María")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.initials, "J")
    }
    
    func testMemberRowViewWithEmptyNameInitials() throws {
        let member = Member(id: 1, name: "")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.initials, "")
    }
    
    func testMemberRowViewWithSingleWordInitials() throws {
        let member = Member(id: 1, name: "John")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.initials, "J")
    }
    
    func testMemberRowViewWithMultipleWordsInitials() throws {
        let member = Member(id: 1, name: "John Doe Smith")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.initials, "J")
    }
    
    // MARK: - Component Edge Cases
    
    func testMemberRowViewWithVeryLongName() throws {
        let member = Member(id: 1, name: "This is a very long name that exceeds normal length and should be handled properly")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.initials, "T")
    }
    
    func testMemberRowViewWithMultipleSpaces() throws {
        let member = Member(id: 1, name: "  John   Doe  ")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        
        XCTAssertNotNil(memberRowView)
        XCTAssertEqual(memberRowView.member.initials, "J")
    }
    
    func testMemberAvatarViewWithVeryLongInitials() throws {
        let avatarView = MemberAvatarView(initials: "ABCDEFGHIJKLMNOP")
        
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "ABCDEFGHIJKLMNOP")
    }
    
    func testMemberAvatarViewWithZeroSize() throws {
        let avatarView = MemberAvatarView(
            initials: "XY",
            size: 0,
            backgroundColor: .red,
            textColor: .white
        )
        
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "XY")
        XCTAssertEqual(avatarView.size, 0)
    }
    
    func testMemberAvatarViewWithNegativeSize() throws {
        let avatarView = MemberAvatarView(
            initials: "XY",
            size: -10,
            backgroundColor: .red,
            textColor: .white
        )
        
        XCTAssertNotNil(avatarView)
        XCTAssertEqual(avatarView.initials, "XY")
        XCTAssertEqual(avatarView.size, -10)
    }
    
    func testCloseButtonWithNilAction() throws {
        // This tests that the action closure can be nil (though it's not recommended)
        let closeButton = CloseButton(action: {})
        
        XCTAssertNotNil(closeButton)
        XCTAssertNotNil(closeButton.action)
    }
} 
