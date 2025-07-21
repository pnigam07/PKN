//
//  PKNTests.swift
//  PKNTests
//
//  Created by pankaj nigam on 7/21/25.
//

import XCTest
import SwiftUI
@testable import PKN

final class PKNTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
        
        XCTAssertEqual(member1.initials, "JD")
        XCTAssertEqual(member2.initials, "J")
        XCTAssertEqual(member3.initials, "ABC")
    }
    
    func testMemberInitialsWithEmptyName() throws {
        let member = Member(id: 1, name: "")
        XCTAssertEqual(member.initials, "")
    }
    
    func testMemberInitialsWithSingleWord() throws {
        let member = Member(id: 1, name: "John")
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
        XCTAssertEqual(viewModel.members.count, 0)
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
        
        XCTAssertFalse(viewModel.isSelected(member))
        
        viewModel.selectMember(member)
        XCTAssertTrue(viewModel.isSelected(member))
    }
    
    // MARK: - Constants Tests
    
    func testAppStringsIcons() throws {
        XCTAssertEqual(AppStrings.Icons.house, "house.fill")
        XCTAssertEqual(AppStrings.Icons.person, "person.3.fill")
        XCTAssertEqual(AppStrings.Icons.checkmark, "checkmark")
    }
    
    func testAppStringsTitles() throws {
        XCTAssertEqual(AppStrings.Titles.memberID, "memberID message")
        XCTAssertEqual(AppStrings.Titles.importantMessage, "important message")
        XCTAssertEqual(AppStrings.Titles.cardUnavailable, "card unavailable")
        XCTAssertEqual(AppStrings.Titles.selectMember, "Select Member")
    }
    
    func testAppStringsDescriptions() throws {
        XCTAssertEqual(AppStrings.Descriptions.welcome, "Welcome to the alternate content state!")
        XCTAssertEqual(AppStrings.Descriptions.defaultMessage, "Hi my name is pankaj hope you doing well. You might have lots of questions.")
        XCTAssertEqual(AppStrings.Descriptions.cardUnavailable, "we are sorry bit this feature is not available so how is your day going on hope everything is fine")
    }
    
    func testAppStringsPhoneNumbers() throws {
        XCTAssertEqual(AppStrings.PhoneNumbers.Display.tollFree, "+1 678-702-3368 (toll free)")
        XCTAssertEqual(AppStrings.PhoneNumbers.Display.yym, "771 (YYM)")
        XCTAssertEqual(AppStrings.PhoneNumbers.Display.alt1, "+1 123-456-7890")
        XCTAssertEqual(AppStrings.PhoneNumbers.Display.alt2, "555 (ALT)")
        
        XCTAssertEqual(AppStrings.PhoneNumbers.Dial.tollFree, "+16787023368")
        XCTAssertEqual(AppStrings.PhoneNumbers.Dial.yym, "771")
        XCTAssertEqual(AppStrings.PhoneNumbers.Dial.alt1, "+11234567890")
        XCTAssertEqual(AppStrings.PhoneNumbers.Dial.alt2, "555")
    }
    
    // MARK: - Performance Tests
    
    func testMemberInitialsPerformance() throws {
        self.measure {
            for _ in 0..<1000 {
                let member = Member(id: 1, name: "John Doe")
                _ = member.initials
            }
        }
    }
    
    func testMemberEqualityPerformance() throws {
        let member1 = Member(id: 1, name: "John Doe")
        let member2 = Member(id: 1, name: "John Doe")
        
        self.measure {
            for _ in 0..<1000 {
                _ = member1 == member2
            }
        }
    }
    
    func testViewModelSelectionPerformance() throws {
        let viewModel = MemberListViewModel()
        let member = viewModel.members[0]
        
        self.measure {
            for _ in 0..<1000 {
                viewModel.selectMember(member)
                viewModel.clearSelection()
            }
        }
    }
    
    // MARK: - App Tests
    
    func testPKNAppInitialization() throws {
        let app = PKNApp()
        XCTAssertNotNil(app)
    }
    
    func testContentViewInitialization() throws {
        let contentView = ContentView()
        XCTAssertNotNil(contentView)
    }
    
    func testPANRootViewInitialization() throws {
        let panRootView = PANRootView()
        XCTAssertNotNil(panRootView)
    }
    
    func testMemberListViewInitialization() throws {
        let viewModel = MemberListViewModel()
        let memberListView = MemberListView(viewModel: viewModel)
        XCTAssertNotNil(memberListView)
    }
    
    func testMemberRowViewInitialization() throws {
        let member = Member(id: 1, name: "John Doe")
        let memberRowView = MemberRowView(
            member: member,
            isSelected: false,
            onTap: {}
        )
        XCTAssertNotNil(memberRowView)
    }
    
    // MARK: - Edge Cases
    
    func testMemberWithSpecialCharacters() throws {
        let member = Member(id: 1, name: "José María")
        XCTAssertEqual(member.initials, "JM")
    }
    
    func testMemberWithNumbers() throws {
        let member = Member(id: 1, name: "John123 Doe")
        XCTAssertEqual(member.initials, "JD")
    }
    
    func testMemberWithMultipleSpaces() throws {
        let member = Member(id: 1, name: "  John   Doe  ")
        XCTAssertEqual(member.initials, "JD")
    }
    
    func testMemberWithUnicodeCharacters() throws {
        let member = Member(id: 1, name: "José María García")
        XCTAssertEqual(member.initials, "JMG")
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
    
    func testViewModelSelectionWithInvalidMember() throws {
        let viewModel = MemberListViewModel()
        let invalidMember = Member(id: 999, name: "Invalid")
        
        viewModel.selectMember(invalidMember)
        XCTAssertEqual(viewModel.selectedMemberID, 999)
    }
    
    func testConstantsAccessibility() throws {
        // Test that all constants are accessible
        XCTAssertNotNil(AppStrings.Icons.house)
        XCTAssertNotNil(AppStrings.Titles.memberID)
        XCTAssertNotNil(AppStrings.Descriptions.welcome)
        XCTAssertNotNil(AppStrings.PhoneNumbers.Display.tollFree)
        XCTAssertNotNil(AppStrings.PhoneNumbers.Dial.tollFree)
    }
}
