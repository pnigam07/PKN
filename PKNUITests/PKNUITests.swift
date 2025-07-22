
//
//  PKNUITests.swift
//  PKNUITests
//
//  Created by pankaj nigam on 7/21/25.
//

import XCTest
import SwiftUI
import ViewInspector

final class PKNUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Basic ViewInspector Tests (without main app types)
    
    func testViewInspectorBasicFunctionality() throws {
        // Test that ViewInspector can inspect basic SwiftUI views
        let simpleView = Text("Hello World")
        let view = try simpleView.inspect()
        XCTAssertNotNil(view)
        
        // Test finding text
        let text = try view.find(text: "Hello World")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorWithHStack() throws {
        let hStack = HStack {
            Text("First")
            Text("Second")
        }
        
        let view = try hStack.inspect()
        XCTAssertNotNil(view)
        
        // Test finding multiple text elements
        let firstText = try view.find(text: "First")
        XCTAssertNotNil(firstText)
        
        let secondText = try view.find(text: "Second")
        XCTAssertNotNil(secondText)
    }
    
    func testViewInspectorWithVStack() throws {
        let vStack = VStack {
            Text("Top")
            Text("Bottom")
        }
        
        let view = try vStack.inspect()
        XCTAssertNotNil(view)
        
        // Test finding text in VStack
        let topText = try view.find(text: "Top")
        XCTAssertNotNil(topText)
        
        let bottomText = try view.find(text: "Bottom")
        XCTAssertNotNil(bottomText)
    }
    
    func testViewInspectorWithButton() throws {
        let button = Button("Click Me") {
            // Action
        }
        
        let view = try button.inspect()
        XCTAssertNotNil(view)
        
        // Test finding button text
        let buttonText = try view.find(text: "Click Me")
        XCTAssertNotNil(buttonText)
    }
    
    func testViewInspectorWithNavigationView() throws {
        let navigationView = NavigationView {
            Text("Content")
                .navigationTitle("Test Title")
        }
        
        let view = try navigationView.inspect()
        XCTAssertNotNil(view)
        
        // Test finding navigation title
        let titleText = try view.find(text: "Test Title")
        XCTAssertNotNil(titleText)
    }
    
    func testViewInspectorWithList() throws {
        let list = List {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
        
        let view = try list.inspect()
        XCTAssertNotNil(view)
        
        // Test finding list items
        let item1 = try view.find(text: "Item 1")
        XCTAssertNotNil(item1)
        
        let item2 = try view.find(text: "Item 2")
        XCTAssertNotNil(item2)
        
        let item3 = try view.find(text: "Item 3")
        XCTAssertNotNil(item3)
    }
    
    func testViewInspectorWithForEach() throws {
        let items = ["Apple", "Banana", "Cherry"]
        let forEach = ForEach(items, id: \.self) { item in
            Text(item)
        }
        
        let view = try forEach.inspect()
        XCTAssertNotNil(view)
        
        // Test finding items in ForEach
        let appleText = try view.find(text: "Apple")
        XCTAssertNotNil(appleText)
        
        let bananaText = try view.find(text: "Banana")
        XCTAssertNotNil(bananaText)
        
        let cherryText = try view.find(text: "Cherry")
        XCTAssertNotNil(cherryText)
    }
    
    func testViewInspectorWithModifiers() throws {
        let text = Text("Styled Text")
            .font(.title)
            .foregroundColor(.blue)
            .padding()
        
        let view = try text.inspect()
        XCTAssertNotNil(view)
        
        // Test finding the text
        let textElement = try view.find(text: "Styled Text")
        XCTAssertNotNil(textElement)
    }
    
    func testViewInspectorWithConditionalContent() throws {
        let showText = true
        let conditionalView = Group {
            if showText {
                Text("Visible")
            } else {
                Text("Hidden")
            }
        }
        
        let view = try conditionalView.inspect()
        XCTAssertNotNil(view)
        
        // Test finding the visible text
        let visibleText = try view.find(text: "Visible")
        XCTAssertNotNil(visibleText)
    }
    
    func testViewInspectorPerformance() throws {
        let complexView = VStack {
            ForEach(1...100, id: \.self) { index in
                HStack {
                    Text("Item \(index)")
                    Spacer()
                    Button("Action \(index)") {
                        // Action
                    }
                }
                .padding()
            }
        }
        
        let startTime = CFAbsoluteTimeGetCurrent()
        let view = try complexView.inspect()
        let endTime = CFAbsoluteTimeGetCurrent()
        
        XCTAssertNotNil(view)
        XCTAssertLessThan(endTime - startTime, 1.0) // Should complete within 1 second
    }
}
