//
//  MemberListViewComponentTests.swift
//  PKNUITests
//
//  Created by pankaj nigam on 7/21/25.
//

import XCTest
import SwiftUI
import ViewInspector

final class MemberListViewComponentTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - ViewInspector Tests for SwiftUI Components
    
    func testTextComponentBasic() throws {
        let textView = Text("Hello World")
        let view = try textView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Hello World")
        XCTAssertNotNil(text)
    }
    
    func testTextComponentWithModifiers() throws {
        let styledText = Text("Styled Text")
            .font(.title)
            .foregroundColor(.blue)
            .padding()
        
        let view = try styledText.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Styled Text")
        XCTAssertNotNil(text)
    }
    
    func testButtonComponentBasic() throws {
        let button = Button("Click Me") {
            // Action
        }
        
        let view = try button.inspect()
        XCTAssertNotNil(view)
        
        let buttonText = try view.find(text: "Click Me")
        XCTAssertNotNil(buttonText)
    }
    
    func testButtonComponentWithStyle() throws {
        let styledButton = Button("Styled Button") {
            // Action
        }
        .buttonStyle(.borderedProminent)
        .foregroundColor(.white)
        
        let view = try styledButton.inspect()
        XCTAssertNotNil(view)
        
        let buttonText = try view.find(text: "Styled Button")
        XCTAssertNotNil(buttonText)
    }
    
    func testImageComponentBasic() throws {
        let imageView = Image(systemName: "star.fill")
            .foregroundColor(.yellow)
        
        let view = try imageView.inspect()
        XCTAssertNotNil(view)
    }
    
    func testImageComponentWithModifiers() throws {
        let styledImage = Image(systemName: "heart.fill")
            .foregroundColor(.red)
            .font(.title)
            .padding()
        
        let view = try styledImage.inspect()
        XCTAssertNotNil(view)
    }
    
    func testHStackComponentBasic() throws {
        let hStack = HStack {
            Text("Left")
            Spacer()
            Text("Right")
        }
        
        let view = try hStack.inspect()
        XCTAssertNotNil(view)
        
        let leftText = try view.find(text: "Left")
        XCTAssertNotNil(leftText)
        
        let rightText = try view.find(text: "Right")
        XCTAssertNotNil(rightText)
    }
    
    func testHStackComponentWithSpacing() throws {
        let hStack = HStack(spacing: 20) {
            Text("First")
            Text("Second")
            Text("Third")
        }
        
        let view = try hStack.inspect()
        XCTAssertNotNil(view)
        
        let firstText = try view.find(text: "First")
        XCTAssertNotNil(firstText)
        
        let secondText = try view.find(text: "Second")
        XCTAssertNotNil(secondText)
        
        let thirdText = try view.find(text: "Third")
        XCTAssertNotNil(thirdText)
    }
    
    func testVStackComponentBasic() throws {
        let vStack = VStack {
            Text("Top")
            Text("Middle")
            Text("Bottom")
        }
        
        let view = try vStack.inspect()
        XCTAssertNotNil(view)
        
        let topText = try view.find(text: "Top")
        XCTAssertNotNil(topText)
        
        let middleText = try view.find(text: "Middle")
        XCTAssertNotNil(middleText)
        
        let bottomText = try view.find(text: "Bottom")
        XCTAssertNotNil(bottomText)
    }
    
    func testVStackComponentWithSpacing() throws {
        let vStack = VStack(spacing: 16) {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
        
        let view = try vStack.inspect()
        XCTAssertNotNil(view)
        
        let item1Text = try view.find(text: "Item 1")
        XCTAssertNotNil(item1Text)
        
        let item2Text = try view.find(text: "Item 2")
        XCTAssertNotNil(item2Text)
        
        let item3Text = try view.find(text: "Item 3")
        XCTAssertNotNil(item3Text)
    }
    
    func testZStackComponentBasic() throws {
        let zStack = ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 200, height: 100)
            
            Text("Overlay Text")
                .foregroundColor(.white)
        }
        
        let view = try zStack.inspect()
        XCTAssertNotNil(view)
        
        let overlayText = try view.find(text: "Overlay Text")
        XCTAssertNotNil(overlayText)
    }
    
    func testZStackComponentWithAlignment() throws {
        let zStack = ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(Color.green)
                .frame(width: 150, height: 150)
            
            Text("Corner Text")
                .foregroundColor(.white)
                .padding()
        }
        
        let view = try zStack.inspect()
        XCTAssertNotNil(view)
        
        let cornerText = try view.find(text: "Corner Text")
        XCTAssertNotNil(cornerText)
    }
    
    func testListComponentBasic() throws {
        let list = List {
            Text("First Item")
            Text("Second Item")
            Text("Third Item")
        }
        
        let view = try list.inspect()
        XCTAssertNotNil(view)
        
        let firstItem = try view.find(text: "First Item")
        XCTAssertNotNil(firstItem)
        
        let secondItem = try view.find(text: "Second Item")
        XCTAssertNotNil(secondItem)
        
        let thirdItem = try view.find(text: "Third Item")
        XCTAssertNotNil(thirdItem)
    }
    
    func testListComponentWithForEach() throws {
        let items = ["Apple", "Banana", "Cherry"]
        let list = List {
            ForEach(items, id: \.self) { item in
                Text(item)
            }
        }
        
        let view = try list.inspect()
        XCTAssertNotNil(view)
        
        let appleText = try view.find(text: "Apple")
        XCTAssertNotNil(appleText)
        
        let bananaText = try view.find(text: "Banana")
        XCTAssertNotNil(bananaText)
        
        let cherryText = try view.find(text: "Cherry")
        XCTAssertNotNil(cherryText)
    }
    
    func testScrollViewComponentBasic() throws {
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
        
        let firstItem = try view.find(text: "Scroll Item 1")
        XCTAssertNotNil(firstItem)
        
        let lastItem = try view.find(text: "Scroll Item 10")
        XCTAssertNotNil(lastItem)
    }
    
    func testScrollViewComponentHorizontal() throws {
        let scrollView = ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(1...5, id: \.self) { index in
                    Text("Card \(index)")
                        .frame(width: 150, height: 100)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        
        let view = try scrollView.inspect()
        XCTAssertNotNil(view)
        
        let firstCard = try view.find(text: "Card 1")
        XCTAssertNotNil(firstCard)
        
        let lastCard = try view.find(text: "Card 5")
        XCTAssertNotNil(lastCard)
    }
    
    func testNavigationViewComponentBasic() throws {
        let navigationView = NavigationView {
            VStack {
                Text("Content")
                Text("More Content")
            }
            .navigationTitle("Test Title")
        }
        
        let view = try navigationView.inspect()
        XCTAssertNotNil(view)
        
        let titleText = try view.find(text: "Test Title")
        XCTAssertNotNil(titleText)
        
        let contentText = try view.find(text: "Content")
        XCTAssertNotNil(contentText)
        
        let moreContentText = try view.find(text: "More Content")
        XCTAssertNotNil(moreContentText)
    }
    
    func testNavigationViewComponentWithToolbar() throws {
        let navigationView = NavigationView {
            VStack {
                Text("Main Content")
            }
            .navigationTitle("With Toolbar")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Action") {
                        // Action
                    }
                }
            }
        }
        
        let view = try navigationView.inspect()
        XCTAssertNotNil(view)
        
        let titleText = try view.find(text: "With Toolbar")
        XCTAssertNotNil(titleText)
        
        let actionButton = try view.find(text: "Action")
        XCTAssertNotNil(actionButton)
    }
    
    func testFormComponentBasic() throws {
        let form = Form {
            Section("Personal Info") {
                Text("Name: John Doe")
                Text("Email: john@example.com")
            }
            
            Section("Settings") {
                Text("Theme: Dark")
                Text("Notifications: On")
            }
        }
        
        let view = try form.inspect()
        XCTAssertNotNil(view)
        
        let nameText = try view.find(text: "Name: John Doe")
        XCTAssertNotNil(nameText)
        
        let emailText = try view.find(text: "Email: john@example.com")
        XCTAssertNotNil(emailText)
        
        let themeText = try view.find(text: "Theme: Dark")
        XCTAssertNotNil(themeText)
    }
    
    func testTabViewComponentBasic() throws {
        let tabView = TabView {
            VStack {
                Text("First Tab")
                Text("Content 1")
            }
            .tabItem {
                Text("First")
            }
            
            VStack {
                Text("Second Tab")
                Text("Content 2")
            }
            .tabItem {
                Text("Second")
            }
        }
        
        let view = try tabView.inspect()
        XCTAssertNotNil(view)
        
        let firstTab = try view.find(text: "First Tab")
        XCTAssertNotNil(firstTab)
        
        let secondTab = try view.find(text: "Second Tab")
        XCTAssertNotNil(secondTab)
    }
    
    func testGroupComponentBasic() throws {
        let group = Group {
            Text("First Item")
            Text("Second Item")
            Text("Third Item")
        }
        
        let view = try group.inspect()
        XCTAssertNotNil(view)
        
        let firstItem = try view.find(text: "First Item")
        XCTAssertNotNil(firstItem)
        
        let secondItem = try view.find(text: "Second Item")
        XCTAssertNotNil(secondItem)
        
        let thirdItem = try view.find(text: "Third Item")
        XCTAssertNotNil(thirdItem)
    }
    
    func testGroupComponentWithConditional() throws {
        let showExtra = true
        let group = Group {
            Text("Always Visible")
            
            if showExtra {
                Text("Extra Content")
                Text("More Extra")
            }
        }
        
        let view = try group.inspect()
        XCTAssertNotNil(view)
        
        let alwaysVisible = try view.find(text: "Always Visible")
        XCTAssertNotNil(alwaysVisible)
        
        let extraContent = try view.find(text: "Extra Content")
        XCTAssertNotNil(extraContent)
        
        let moreExtra = try view.find(text: "More Extra")
        XCTAssertNotNil(moreExtra)
    }
    
    func testLazyVStackComponentBasic() throws {
        let lazyVStack = LazyVStack {
            ForEach(1...20, id: \.self) { index in
                Text("Lazy Item \(index)")
                    .padding()
                    .background(Color.orange.opacity(0.1))
            }
        }
        
        let view = try lazyVStack.inspect()
        XCTAssertNotNil(view)
        
        let firstItem = try view.find(text: "Lazy Item 1")
        XCTAssertNotNil(firstItem)
        
        let lastItem = try view.find(text: "Lazy Item 20")
        XCTAssertNotNil(lastItem)
    }
    
    func testLazyHStackComponentBasic() throws {
        let lazyHStack = LazyHStack {
            ForEach(1...10, id: \.self) { index in
                Text("H \(index)")
                    .padding()
                    .background(Color.purple.opacity(0.1))
            }
        }
        
        let view = try lazyHStack.inspect()
        XCTAssertNotNil(view)
        
        let firstItem = try view.find(text: "H 1")
        XCTAssertNotNil(firstItem)
        
        let lastItem = try view.find(text: "H 10")
        XCTAssertNotNil(lastItem)
    }
    
    func testGeometryReaderComponentBasic() throws {
        let geometryReader = GeometryReader { geometry in
            VStack {
                Text("Width: \(Int(geometry.size.width))")
                Text("Height: \(Int(geometry.size.height))")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        let view = try geometryReader.inspect()
        XCTAssertNotNil(view)
        
        // Note: GeometryReader content is dynamic, so we just verify the view exists
    }
    
    func testDividerComponentBasic() throws {
        let dividerView = VStack {
            Text("Above")
            Divider()
            Text("Below")
        }
        
        let view = try dividerView.inspect()
        XCTAssertNotNil(view)
        
        let aboveText = try view.find(text: "Above")
        XCTAssertNotNil(aboveText)
        
        let belowText = try view.find(text: "Below")
        XCTAssertNotNil(belowText)
    }
    
    func testSpacerComponentBasic() throws {
        let spacerView = HStack {
            Text("Left")
            Spacer()
            Text("Right")
        }
        
        let view = try spacerView.inspect()
        XCTAssertNotNil(view)
        
        let leftText = try view.find(text: "Left")
        XCTAssertNotNil(leftText)
        
        let rightText = try view.find(text: "Right")
        XCTAssertNotNil(rightText)
    }
    
    func testSpacerComponentWithMinLength() throws {
        let spacerView = HStack {
            Text("Start")
            Spacer(minLength: 50)
            Text("End")
        }
        
        let view = try spacerView.inspect()
        XCTAssertNotNil(view)
        
        let startText = try view.find(text: "Start")
        XCTAssertNotNil(startText)
        
        let endText = try view.find(text: "End")
        XCTAssertNotNil(endText)
    }
} 