//
//  MemberListViewTests.swift
//  PKNUITests
//
//  Created by pankaj nigam on 7/21/25.
//

import XCTest
import SwiftUI
import ViewInspector

final class MemberListViewTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - ViewInspector Tests for Complex SwiftUI Views
    
    func testComplexViewStructure() throws {
        let complexView = VStack {
            HStack {
                Text("Title")
                    .font(.title)
                Spacer()
                Button("Action") {
                    // Action
                }
            }
            .padding()
            
            List {
                ForEach(1...5, id: \.self) { index in
                    HStack {
                        Text("Item \(index)")
                        Spacer()
                        Text("Detail \(index)")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        
        let view = try complexView.inspect()
        XCTAssertNotNil(view)
        
        // Test finding title
        let titleText = try view.find(text: "Title")
        XCTAssertNotNil(titleText)
        
        // Test finding button
        let buttonText = try view.find(text: "Action")
        XCTAssertNotNil(buttonText)
        
        // Test finding list items
        let item1Text = try view.find(text: "Item 1")
        XCTAssertNotNil(item1Text)
        
        let item5Text = try view.find(text: "Item 5")
        XCTAssertNotNil(item5Text)
    }
    
    func testNavigationViewWithList() throws {
        let navigationView = NavigationView {
            List {
                Text("First Item")
                Text("Second Item")
                Text("Third Item")
            }
            .navigationTitle("Test List")
        }
        
        let view = try navigationView.inspect()
        XCTAssertNotNil(view)
        
        // Test finding navigation title
        let titleText = try view.find(text: "Test List")
        XCTAssertNotNil(titleText)
        
        // Test finding list items
        let firstItem = try view.find(text: "First Item")
        XCTAssertNotNil(firstItem)
        
        let secondItem = try view.find(text: "Second Item")
        XCTAssertNotNil(secondItem)
        
        let thirdItem = try view.find(text: "Third Item")
        XCTAssertNotNil(thirdItem)
    }
    
    func testViewWithModifiers() throws {
        let styledView = VStack {
            Text("Primary Text")
                .font(.headline)
                .foregroundColor(.blue)
                .padding()
            
            Text("Secondary Text")
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.horizontal)
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        
        let view = try styledView.inspect()
        XCTAssertNotNil(view)
        
        // Test finding text elements
        let primaryText = try view.find(text: "Primary Text")
        XCTAssertNotNil(primaryText)
        
        let secondaryText = try view.find(text: "Secondary Text")
        XCTAssertNotNil(secondaryText)
    }
    
    func testViewWithConditionalContent() throws {
        let showDetails = true
        let conditionalView = VStack {
            Text("Always Visible")
            
            if showDetails {
                Text("Details Visible")
                Text("More Details")
            } else {
                Text("Details Hidden")
            }
        }
        
        let view = try conditionalView.inspect()
        XCTAssertNotNil(view)
        
        // Test finding always visible text
        let alwaysVisible = try view.find(text: "Always Visible")
        XCTAssertNotNil(alwaysVisible)
        
        // Test finding conditional text
        let detailsVisible = try view.find(text: "Details Visible")
        XCTAssertNotNil(detailsVisible)
        
        let moreDetails = try view.find(text: "More Details")
        XCTAssertNotNil(moreDetails)
    }
    
    func testViewWithButtons() throws {
        let buttonView = VStack {
            Button("Primary Action") {
                // Primary action
            }
            .buttonStyle(.borderedProminent)
            
            Button("Secondary Action") {
                // Secondary action
            }
            .buttonStyle(.bordered)
            
            Button("Destructive Action") {
                // Destructive action
            }
            .foregroundColor(.red)
        }
        
        let view = try buttonView.inspect()
        XCTAssertNotNil(view)
        
        // Test finding button texts
        let primaryButton = try view.find(text: "Primary Action")
        XCTAssertNotNil(primaryButton)
        
        let secondaryButton = try view.find(text: "Secondary Action")
        XCTAssertNotNil(secondaryButton)
        
        let destructiveButton = try view.find(text: "Destructive Action")
        XCTAssertNotNil(destructiveButton)
    }
    
    func testViewWithScrollView() throws {
        let scrollView = ScrollView {
            VStack(spacing: 20) {
                ForEach(1...10, id: \.self) { index in
                    Text("Scroll Item \(index)")
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        
        let view = try scrollView.inspect()
        XCTAssertNotNil(view)
        
        // Test finding scroll items
        let firstItem = try view.find(text: "Scroll Item 1")
        XCTAssertNotNil(firstItem)
        
        let lastItem = try view.find(text: "Scroll Item 10")
        XCTAssertNotNil(lastItem)
    }
    
    func testViewWithForm() throws {
        let formView = Form {
            Section("Personal Information") {
                Text("Name: John Doe")
                Text("Email: john@example.com")
                Text("Phone: +1-555-0123")
            }
            
            Section("Preferences") {
                Text("Theme: Dark")
                Text("Notifications: Enabled")
                Text("Language: English")
            }
        }
        
        let view = try formView.inspect()
        XCTAssertNotNil(view)
        
        // Test finding form content
        let nameText = try view.find(text: "Name: John Doe")
        XCTAssertNotNil(nameText)
        
        let emailText = try view.find(text: "Email: john@example.com")
        XCTAssertNotNil(emailText)
        
        let themeText = try view.find(text: "Theme: Dark")
        XCTAssertNotNil(themeText)
    }
    
    func testViewWithTabView() throws {
        let tabView = TabView {
            VStack {
                Text("First Tab")
                Text("Content for first tab")
            }
            .tabItem {
                Text("First")
            }
            
            VStack {
                Text("Second Tab")
                Text("Content for second tab")
            }
            .tabItem {
                Text("Second")
            }
        }
        
        let view = try tabView.inspect()
        XCTAssertNotNil(view)
        
        // Test finding tab content
        let firstTab = try view.find(text: "First Tab")
        XCTAssertNotNil(firstTab)
        
        let secondTab = try view.find(text: "Second Tab")
        XCTAssertNotNil(secondTab)
    }
    
    func testViewWithGeometryReader() throws {
        let geometryView = GeometryReader { geometry in
            VStack {
                Text("Width: \(Int(geometry.size.width))")
                Text("Height: \(Int(geometry.size.height))")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        let view = try geometryView.inspect()
        XCTAssertNotNil(view)
        
        // Note: GeometryReader content is dynamic, so we just verify the view exists
    }
    
    func testViewWithLazyVStack() throws {
        let lazyView = LazyVStack {
            ForEach(1...20, id: \.self) { index in
                Text("Lazy Item \(index)")
                    .padding()
                    .background(Color.green.opacity(0.1))
            }
        }
        
        let view = try lazyView.inspect()
        XCTAssertNotNil(view)
        
        // Test finding some lazy items
        let firstItem = try view.find(text: "Lazy Item 1")
        XCTAssertNotNil(firstItem)
        
        let lastItem = try view.find(text: "Lazy Item 20")
        XCTAssertNotNil(lastItem)
    }
    
    func testViewWithCustomModifiers() throws {
        let customView = Text("Custom Text")
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(.purple)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.purple.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.purple, lineWidth: 2)
            )
        
        let view = try customView.inspect()
        XCTAssertNotNil(view)
        
        // Test finding the text
        let textElement = try view.find(text: "Custom Text")
        XCTAssertNotNil(textElement)
    }
} 