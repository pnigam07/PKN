//
//  ViewInspectorCompatibilityTest.swift
//  PKNUITests
//
//  Created by pankaj nigam on 7/21/25.
//

import XCTest
import SwiftUI
import ViewInspector

final class ViewInspectorCompatibilityTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Basic ViewInspector Compatibility Tests
    
    func testViewInspectorBasicInspection() throws {
        let textView = Text("Hello World")
        let view = try textView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Hello World")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorVStackInspection() throws {
        let vStack = VStack {
            Text("First Item")
            Text("Second Item")
        }
        
        let view = try vStack.inspect()
        XCTAssertNotNil(view)
        
        let firstText = try view.find(text: "First Item")
        XCTAssertNotNil(firstText)
        
        let secondText = try view.find(text: "Second Item")
        XCTAssertNotNil(secondText)
    }
    
    func testViewInspectorHStackInspection() throws {
        let hStack = HStack {
            Text("Left")
            Text("Right")
        }
        
        let view = try hStack.inspect()
        XCTAssertNotNil(view)
        
        let leftText = try view.find(text: "Left")
        XCTAssertNotNil(leftText)
        
        let rightText = try view.find(text: "Right")
        XCTAssertNotNil(rightText)
    }
    
    func testViewInspectorButtonInspection() throws {
        let button = Button("Tap Me") {
            // Action
        }
        
        let view = try button.inspect()
        XCTAssertNotNil(view)
        
        let buttonText = try view.find(text: "Tap Me")
        XCTAssertNotNil(buttonText)
    }
    
    func testViewInspectorNavigationViewInspection() throws {
        let navigationView = NavigationView {
            VStack {
                Text("Navigation Content")
            }
            .navigationTitle("Test Title")
        }
        
        let view = try navigationView.inspect()
        XCTAssertNotNil(view)
        
        let contentText = try view.find(text: "Navigation Content")
        XCTAssertNotNil(contentText)
        
        let titleText = try view.find(text: "Test Title")
        XCTAssertNotNil(titleText)
    }
    
    func testViewInspectorListInspection() throws {
        let listView = List {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
        
        let view = try listView.inspect()
        XCTAssertNotNil(view)
        
        let item1 = try view.find(text: "Item 1")
        XCTAssertNotNil(item1)
        
        let item2 = try view.find(text: "Item 2")
        XCTAssertNotNil(item2)
        
        let item3 = try view.find(text: "Item 3")
        XCTAssertNotNil(item3)
    }
    
    func testViewInspectorZStackInspection() throws {
        let zStack = ZStack {
            Color.blue
            Text("Overlay Text")
        }
        
        let view = try zStack.inspect()
        XCTAssertNotNil(view)
        
        let overlayText = try view.find(text: "Overlay Text")
        XCTAssertNotNil(overlayText)
    }
    
    func testViewInspectorSpacerInspection() throws {
        let vStack = VStack {
            Text("Top")
            Spacer()
            Text("Bottom")
        }
        
        let view = try vStack.inspect()
        XCTAssertNotNil(view)
        
        let topText = try view.find(text: "Top")
        XCTAssertNotNil(topText)
        
        let bottomText = try view.find(text: "Bottom")
        XCTAssertNotNil(bottomText)
    }
    
    func testViewInspectorImageInspection() throws {
        let imageView = Image(systemName: "star.fill")
        
        let view = try imageView.inspect()
        XCTAssertNotNil(view)
    }
    
    func testViewInspectorFormInspection() throws {
        let form = Form {
            Section("Section 1") {
                Text("Form Item 1")
                Text("Form Item 2")
            }
            Section("Section 2") {
                Text("Form Item 3")
            }
        }
        
        let view = try form.inspect()
        XCTAssertNotNil(view)
        
        let item1 = try view.find(text: "Form Item 1")
        XCTAssertNotNil(item1)
        
        let item2 = try view.find(text: "Form Item 2")
        XCTAssertNotNil(item2)
        
        let item3 = try view.find(text: "Form Item 3")
        XCTAssertNotNil(item3)
    }
    
    func testViewInspectorScrollViewInspection() throws {
        let scrollView = ScrollView {
            VStack {
                ForEach(1...5, id: \.self) { index in
                    Text("Item \(index)")
                }
            }
        }
        
        let view = try scrollView.inspect()
        XCTAssertNotNil(view)
        
        let firstItem = try view.find(text: "Item 1")
        XCTAssertNotNil(firstItem)
        
        let lastItem = try view.find(text: "Item 5")
        XCTAssertNotNil(lastItem)
    }
    
    func testViewInspectorToggleInspection() throws {
        let toggle = Toggle("Enable Feature", isOn: .constant(true))
        
        let view = try toggle.inspect()
        XCTAssertNotNil(view)
        
        let label = try view.find(text: "Enable Feature")
        XCTAssertNotNil(label)
    }
    
    func testViewInspectorTextFieldInspection() throws {
        let textField = TextField("Enter text", text: .constant(""))
        
        let view = try textField.inspect()
        XCTAssertNotNil(view)
        
        let placeholder = try view.find(text: "Enter text")
        XCTAssertNotNil(placeholder)
    }
    
    func testViewInspectorSecureFieldInspection() throws {
        let secureField = SecureField("Enter password", text: .constant(""))
        
        let view = try secureField.inspect()
        XCTAssertNotNil(view)
        
        let placeholder = try view.find(text: "Enter password")
        XCTAssertNotNil(placeholder)
    }
    
    func testViewInspectorPickerInspection() throws {
        let picker = Picker("Select Option", selection: .constant(0)) {
            Text("Option 1").tag(0)
            Text("Option 2").tag(1)
            Text("Option 3").tag(2)
        }
        
        let view = try picker.inspect()
        XCTAssertNotNil(view)
        
        let label = try view.find(text: "Select Option")
        XCTAssertNotNil(label)
        
        let option1 = try view.find(text: "Option 1")
        XCTAssertNotNil(option1)
        
        let option2 = try view.find(text: "Option 2")
        XCTAssertNotNil(option2)
        
        let option3 = try view.find(text: "Option 3")
        XCTAssertNotNil(option3)
    }
    
    func testViewInspectorStepperInspection() throws {
        let stepper = Stepper("Count", value: .constant(0), in: 0...10)
        
        let view = try stepper.inspect()
        XCTAssertNotNil(view)
        
        let label = try view.find(text: "Count")
        XCTAssertNotNil(label)
    }
    
    func testViewInspectorSliderInspection() throws {
        let slider = Slider(value: .constant(0.5), in: 0...1)
        
        let view = try slider.inspect()
        XCTAssertNotNil(view)
    }
    
    func testViewInspectorProgressViewInspection() throws {
        let progressView = ProgressView(value: 0.5)
        
        let view = try progressView.inspect()
        XCTAssertNotNil(view)
    }
    
    func testViewInspectorDividerInspection() throws {
        let vStack = VStack {
            Text("Above")
            Divider()
            Text("Below")
        }
        
        let view = try vStack.inspect()
        XCTAssertNotNil(view)
        
        let aboveText = try view.find(text: "Above")
        XCTAssertNotNil(aboveText)
        
        let belowText = try view.find(text: "Below")
        XCTAssertNotNil(belowText)
    }
    
    func testViewInspectorGroupInspection() throws {
        let group = Group {
            Text("Group Item 1")
            Text("Group Item 2")
        }
        
        let view = try group.inspect()
        XCTAssertNotNil(view)
        
        let item1 = try view.find(text: "Group Item 1")
        XCTAssertNotNil(item1)
        
        let item2 = try view.find(text: "Group Item 2")
        XCTAssertNotNil(item2)
    }
    
    func testViewInspectorLazyVStackInspection() throws {
        let lazyVStack = LazyVStack {
            ForEach(1...3, id: \.self) { index in
                Text("Lazy Item \(index)")
            }
        }
        
        let view = try lazyVStack.inspect()
        XCTAssertNotNil(view)
        
        let firstItem = try view.find(text: "Lazy Item 1")
        XCTAssertNotNil(firstItem)
    }
    
    func testViewInspectorLazyHStackInspection() throws {
        let lazyHStack = LazyHStack {
            ForEach(1...3, id: \.self) { index in
                Text("H\(index)")
            }
        }
        
        let view = try lazyHStack.inspect()
        XCTAssertNotNil(view)
        
        let firstItem = try view.find(text: "H1")
        XCTAssertNotNil(firstItem)
    }
    
    func testViewInspectorGeometryReaderInspection() throws {
        let geometryReader = GeometryReader { geometry in
            Text("Geometry Reader")
        }
        
        let view = try geometryReader.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Geometry Reader")
        XCTAssertNotNil(text)
    }
    
    // MARK: - View Modifier Tests
    
    func testViewInspectorOverlayInspection() throws {
        let overlayView = Text("Base Text")
            .overlay(
                Text("Overlay")
                    .background(Color.red)
            )
        
        let view = try overlayView.inspect()
        XCTAssertNotNil(view)
        
        let baseText = try view.find(text: "Base Text")
        XCTAssertNotNil(baseText)
        
        let overlayText = try view.find(text: "Overlay")
        XCTAssertNotNil(overlayText)
    }
    
    func testViewInspectorBackgroundInspection() throws {
        let backgroundView = Text("Background Text")
            .background(Color.blue)
        
        let view = try backgroundView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Background Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorPaddingInspection() throws {
        let paddedView = Text("Padded Text")
            .padding()
        
        let view = try paddedView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Padded Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorFrameInspection() throws {
        let framedView = Text("Framed Text")
            .frame(width: 200, height: 100)
        
        let view = try framedView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Framed Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorForegroundColorInspection() throws {
        let coloredView = Text("Colored Text")
            .foregroundColor(.red)
        
        let view = try coloredView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Colored Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorFontInspection() throws {
        let fontView = Text("Font Text")
            .font(.title)
        
        let view = try fontView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Font Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorCornerRadiusInspection() throws {
        let roundedView = Text("Rounded Text")
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        
        let view = try roundedView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Rounded Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorShadowInspection() throws {
        let shadowView = Text("Shadow Text")
            .shadow(radius: 5)
        
        let view = try shadowView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Shadow Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorScaleEffectInspection() throws {
        let scaledView = Text("Scaled Text")
            .scaleEffect(1.5)
        
        let view = try scaledView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Scaled Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorRotationEffectInspection() throws {
        let rotatedView = Text("Rotated Text")
            .rotationEffect(.degrees(45))
        
        let view = try rotatedView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Rotated Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorOpacityInspection() throws {
        let opacityView = Text("Opacity Text")
            .opacity(0.5)
        
        let view = try opacityView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Opacity Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorBlurInspection() throws {
        let blurView = Text("Blur Text")
            .blur(radius: 2)
        
        let view = try blurView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Blur Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorClipShapeInspection() throws {
        let clippedView = Text("Clipped Text")
            .padding()
            .background(Color.blue)
            .clipShape(Circle())
        
        let view = try clippedView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Clipped Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorMaskInspection() throws {
        let maskedView = Text("Masked Text")
            .mask(
                Rectangle()
                    .fill(Color.red)
            )
        
        let view = try maskedView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Masked Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorCompositingGroupInspection() throws {
        let compositedView = Text("Composited Text")
            .compositingGroup()
        
        let view = try compositedView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Composited Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorDrawingGroupInspection() throws {
        let drawingView = Text("Drawing Text")
            .drawingGroup()
        
        let view = try drawingView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Drawing Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorAccessibilityInspection() throws {
        let accessibleView = Text("Accessible Text")
            .accessibilityLabel("Accessibility Label")
            .accessibilityIdentifier("test_identifier")
        
        let view = try accessibleView.inspect()
        XCTAssertNotNil(view)
        
        let text = try view.find(text: "Accessible Text")
        XCTAssertNotNil(text)
    }
    
    func testViewInspectorConditionalContentInspection() throws {
        let conditionalView = Group {
            if true {
                Text("True Content")
            } else {
                Text("False Content")
            }
        }
        
        let view = try conditionalView.inspect()
        XCTAssertNotNil(view)
        
        let trueText = try view.find(text: "True Content")
        XCTAssertNotNil(trueText)
    }
    
    func testViewInspectorForEachInspection() throws {
        let forEachView = VStack {
            ForEach(1...3, id: \.self) { index in
                Text("ForEach Item \(index)")
            }
        }
        
        let view = try forEachView.inspect()
        XCTAssertNotNil(view)
        
        let item1 = try view.find(text: "ForEach Item 1")
        XCTAssertNotNil(item1)
        
        let item2 = try view.find(text: "ForEach Item 2")
        XCTAssertNotNil(item2)
        
        let item3 = try view.find(text: "ForEach Item 3")
        XCTAssertNotNil(item3)
    }
    
    func testViewInspectorPerformanceInspection() throws {
        measure {
            let complexView = VStack {
                ForEach(1...50, id: \.self) { index in
                    Text("Performance Item \(index)")
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(5)
                }
            }
            
            // Just creating the view to measure performance
            _ = complexView
        }
    }
    
    func testViewInspectorComplexViewInspection() throws {
        let complexView = NavigationView {
            VStack {
                HStack {
                    Text("Left")
                    Spacer()
                    Text("Right")
                }
                .padding()
                
                List {
                    ForEach(1...3, id: \.self) { index in
                        HStack {
                            Text("Item \(index)")
                            Spacer()
                            Text("Detail \(index)")
                        }
                    }
                }
            }
            .navigationTitle("Complex View")
        }
        
        let view = try complexView.inspect()
        XCTAssertNotNil(view)
        
        let title = try view.find(text: "Complex View")
        XCTAssertNotNil(title)
        
        let leftText = try view.find(text: "Left")
        XCTAssertNotNil(leftText)
        
        let rightText = try view.find(text: "Right")
        XCTAssertNotNil(rightText)
        
        let item1 = try view.find(text: "Item 1")
        XCTAssertNotNil(item1)
        
        let detail1 = try view.find(text: "Detail 1")
        XCTAssertNotNil(detail1)
    }
} 