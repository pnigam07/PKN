# ViewInspector Testing Guide for MemberListView

## Overview

ViewInspector is a powerful library for testing SwiftUI views. This guide demonstrates how to use ViewInspector to test the MemberListView, its list, and rows.

## Setup

ViewInspector has been successfully added to the project via CocoaPods:

```ruby
# Podfile
target 'PKNUITests' do
  pod 'ViewInspector', '~> 0.9.0'
end
```

## Basic ViewInspector Usage

### 1. Import Required Modules

```swift
import XCTest
import ViewInspector
import SwiftUI
@testable import PKN  // To access your app's views
```

### 2. Basic View Inspection

```swift
func testBasicInspection() throws {
    let view = Text("Hello World")
    let inspectable = try view.inspect()
    XCTAssertNotNil(inspectable)
}
```

## Testing MemberListView Components

### 1. Testing MemberListView Structure

```swift
func testMemberListViewStructure() throws {
    let memberListView = MemberListView()
    
    // Test that the view can be inspected
    let view = try memberListView.inspect()
    XCTAssertNotNil(view)
    
    // Test navigation structure
    let navigationView = try view.navigationView()
    XCTAssertNotNil(navigationView)
}
```

### 2. Testing Navigation Title

```swift
func testMemberListViewNavigationTitle() throws {
    let memberListView = MemberListView()
    let view = try memberListView.inspect()
    
    // Test that the navigation title is present
    let titleText = try view.find(text: "Select Member")
    XCTAssertNotNil(titleText)
}
```

### 3. Testing List Content

```swift
func testMemberListViewListContent() throws {
    let memberListView = MemberListView()
    let view = try memberListView.inspect()
    
    // Test that the list exists
    let list = try view.find(viewWithId: "memberListView.list")
    XCTAssertNotNil(list)
}
```

### 4. Testing MemberRowView

```swift
func testMemberRowView() throws {
    let member = Member(id: 1, name: "John Doe")
    let memberRowView = MemberRowView(
        member: member,
        isSelected: false,
        onTap: {}
    )
    
    let view = try memberRowView.inspect()
    XCTAssertNotNil(view)
    
    // Test member name is displayed
    let nameText = try view.find(text: "John Doe")
    XCTAssertNotNil(nameText)
}
```

### 5. Testing MemberRowView Selected State

```swift
func testMemberRowViewSelectedState() throws {
    let member = Member(id: 1, name: "John Doe")
    let memberRowView = MemberRowView(
        member: member,
        isSelected: true,
        onTap: {}
    )
    
    let view = try memberRowView.inspect()
    
    // Test that checkmark appears when selected
    let checkmark = try view.find(viewWithId: "memberRow.checkmark_1")
    XCTAssertNotNil(checkmark)
}
```

### 6. Testing MemberAvatarView

```swift
func testMemberAvatarView() throws {
    let avatarView = MemberAvatarView(initials: "JD")
    
    let view = try avatarView.inspect()
    XCTAssertNotNil(view)
    
    // Test that initials are displayed
    let initials = try view.find(viewWithId: "memberAvatar.initials")
    XCTAssertNotNil(initials)
}
```

### 7. Testing CloseButton

```swift
func testCloseButton() throws {
    let closeButton = CloseButton(action: {})
    
    let view = try closeButton.inspect()
    XCTAssertNotNil(view)
    
    // Test button text
    let buttonText = try view.find(text: "Close")
    XCTAssertNotNil(buttonText)
}
```

## Advanced Testing Patterns

### 1. Testing Custom Members

```swift
func testMemberListViewWithCustomMembers() throws {
    let customMembers = [
        Member(id: 1, name: "Test User 1"),
        Member(id: 2, name: "Test User 2")
    ]
    let viewModel = MemberListViewModel(members: customMembers)
    let memberListView = MemberListView(viewModel: viewModel)
    
    let view = try memberListView.inspect()
    let list = try view.find(viewWithId: "memberListView.list")
    XCTAssertNotNil(list)
}
```

### 2. Testing Close Button Callback

```swift
func testMemberListViewCloseButton() throws {
    var closeButtonTapped = false
    let memberListView = MemberListView(onClose: {
        closeButtonTapped = true
    })
    
    let view = try memberListView.inspect()
    
    // Test that close button exists when onClose is provided
    let closeButton = try view.find(viewWithId: "closeButton")
    XCTAssertNotNil(closeButton)
}
```

### 3. Testing Accessibility

```swift
func testMemberRowViewAccessibility() throws {
    let member = Member(id: 1, name: "John Doe")
    let memberRowView = MemberRowView(
        member: member,
        isSelected: false,
        onTap: {}
    )
    
    let view = try memberRowView.inspect()
    
    // Test accessibility identifier
    let row = try view.find(viewWithId: "memberRow_1")
    XCTAssertNotNil(row)
}
```

## ViewInspector API Reference

### Common Methods

```swift
// Basic inspection
let view = try someView.inspect()

// Finding elements by text
let text = try view.find(text: "Some Text")

// Finding elements by ID
let element = try view.find(viewWithId: "someId")

// Testing view types
let navigationView = try view.navigationView()
let hStack = try view.hStack()
let vStack = try view.vStack()
let button = try view.button()
```

### Testing View Properties

```swift
// Test text content
let text = try view.find(text: "Expected Text")
XCTAssertNotNil(text)

// Test view hierarchy
let childView = try view.find(viewWithId: "childId")
XCTAssertNotNil(childView)

// Test conditional views
let conditionalView = try view.find(text: "Conditional Text")
XCTAssertNotNil(conditionalView)
```

## Best Practices

### 1. Always Test View Inspection

```swift
func testViewCanBeInspected() throws {
    let view = YourView()
    let inspectable = try view.inspect()
    XCTAssertNotNil(inspectable)
}
```

### 2. Test Text Content

```swift
func testTextContent() throws {
    let view = Text("Hello World")
    let inspectable = try view.inspect()
    let text = try inspectable.find(text: "Hello World")
    XCTAssertNotNil(text)
}
```

### 3. Test View Structure

```swift
func testViewStructure() throws {
    let view = VStack {
        Text("Top")
        Text("Bottom")
    }
    let inspectable = try view.inspect()
    
    let topText = try inspectable.find(text: "Top")
    XCTAssertNotNil(topText)
    
    let bottomText = try inspectable.find(text: "Bottom")
    XCTAssertNotNil(bottomText)
}
```

### 4. Test Interactive Elements

```swift
func testInteractiveElements() throws {
    let view = Button("Tap Me") {
        // Action
    }
    let inspectable = try view.inspect()
    
    let buttonText = try inspectable.find(text: "Tap Me")
    XCTAssertNotNil(buttonText)
}
```

## Troubleshooting

### Common Issues

1. **Sandbox Permission Issues**: If you encounter sandbox permission errors, try:
   - Using a different derived data path
   - Running tests with elevated permissions
   - Using a different simulator

2. **Linker Errors**: If you get linker errors about missing symbols:
   - Ensure ViewInspector is properly linked to the test target
   - Check that all required frameworks are included

3. **API Compatibility**: If ViewInspector API methods don't work:
   - Check the ViewInspector version compatibility
   - Refer to the ViewInspector documentation for the correct API usage

### Debugging Tips

```swift
// Print view hierarchy for debugging
func debugViewHierarchy() throws {
    let view = YourView()
    let inspectable = try view.inspect()
    print("View can be inspected: \(inspectable)")
}
```

## Running Tests

To run ViewInspector tests:

```bash
# Run all UI tests
xcodebuild test -workspace PKN.xcworkspace -scheme PKN -destination 'platform=iOS Simulator,name=iPhone 15'

# Run specific test
xcodebuild test -workspace PKN.xcworkspace -scheme PKN -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:PKNUITests/ViewInspectorExample/testMemberListViewWithViewInspector
```

## Summary

ViewInspector provides powerful capabilities for testing SwiftUI views:

- ✅ **View Inspection**: Test that views can be properly inspected
- ✅ **Text Content Testing**: Verify text elements are displayed correctly
- ✅ **View Hierarchy Testing**: Test complex view structures
- ✅ **Interactive Element Testing**: Test buttons and other interactive elements
- ✅ **Accessibility Testing**: Test accessibility features
- ✅ **State Testing**: Test different view states (selected, unselected, etc.)

This guide demonstrates how to effectively use ViewInspector to test MemberListView and its components, providing comprehensive coverage of your SwiftUI views. 