//
//  PublisherTests.swift
//  MYNew
//
//  Created by pankaj nigam on 7/21/25.
//

import XCTest
import Combine
import SwiftUI
@testable import ViewInspector

@MainActor
final class PublisherTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }
    
    // MARK: - Basic Publisher Tests
    
    func testJustPublisher() {
        let expectation = XCTestExpectation(description: "Just publisher should emit value")
        
        Just("Hello, World!")
            .sink { value in
                XCTAssertEqual(value, "Hello, World!")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testEmptyPublisher() {
        let expectation = XCTestExpectation(description: "Empty publisher should complete without emitting")
        
        Empty<String, Never>()
            .sink(
                receiveCompletion: { completion in
                    XCTAssertEqual(completion, .finished)
                    expectation.fulfill()
                },
                receiveValue: { value in
                    XCTFail("Empty publisher should not emit values")
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFailPublisher() {
        let expectation = XCTestExpectation(description: "Fail publisher should emit error")
        let testError = TestError.someError
        
        Fail<String, TestError>(error: testError)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        XCTFail("Fail publisher should not complete successfully")
                    case .failure(let error):
                        XCTAssertEqual(error, testError)
                        expectation.fulfill()
                    }
                },
                receiveValue: { value in
                    XCTFail("Fail publisher should not emit values")
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Sequence Publisher Tests
    
    func testSequencePublisher() {
        let expectation = XCTestExpectation(description: "Sequence publisher should emit all values")
        let numbers = [1, 2, 3, 4, 5]
        var receivedValues: [Int] = []
        
        numbers.publisher
            .sink(
                receiveCompletion: { completion in
                    XCTAssertEqual(completion, .finished)
                    XCTAssertEqual(receivedValues, numbers)
                    expectation.fulfill()
                },
                receiveValue: { value in
                    receivedValues.append(value)
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRangePublisher() {
        let expectation = XCTestExpectation(description: "Range publisher should emit range values")
        var receivedValues: [Int] = []
        
        (1...5).publisher
            .sink(
                receiveCompletion: { completion in
                    XCTAssertEqual(completion, .finished)
                    XCTAssertEqual(receivedValues, [1, 2, 3, 4, 5])
                    expectation.fulfill()
                },
                receiveValue: { value in
                    receivedValues.append(value)
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Timer Publisher Tests
    
    func testTimerPublisher() {
        let expectation = XCTestExpectation(description: "Timer publisher should emit values")
        var receivedCount = 0
        
        Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                receivedCount += 1
                if receivedCount >= 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
        XCTAssertGreaterThanOrEqual(receivedCount, 3)
    }
    
    // MARK: - Subject Tests
    
    func testPassthroughSubject() {
        let expectation = XCTestExpectation(description: "PassthroughSubject should emit sent values")
        let subject = PassthroughSubject<String, Never>()
        var receivedValues: [String] = []
        
        subject
            .sink(
                receiveCompletion: { completion in
                    XCTAssertEqual(completion, .finished)
                    XCTAssertEqual(receivedValues, ["Hello", "World"])
                    expectation.fulfill()
                },
                receiveValue: { value in
                    receivedValues.append(value)
                }
            )
            .store(in: &cancellables)
        
        subject.send("Hello")
        subject.send("World")
        subject.send(completion: .finished)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testCurrentValueSubject() {
        let expectation = XCTestExpectation(description: "CurrentValueSubject should emit initial and sent values")
        let subject = CurrentValueSubject<String, Never>("Initial")
        var receivedValues: [String] = []
        
        subject
            .sink(
                receiveCompletion: { completion in
                    XCTAssertEqual(completion, .finished)
                    XCTAssertEqual(receivedValues, ["Initial", "Updated"])
                    expectation.fulfill()
                },
                receiveValue: { value in
                    receivedValues.append(value)
                }
            )
            .store(in: &cancellables)
        
        subject.send("Updated")
        subject.send(completion: .finished)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Operator Tests
    
    func testMapOperator() {
        let expectation = XCTestExpectation(description: "Map operator should transform values")
        var receivedValues: [String] = []
        
        [1, 2, 3].publisher
            .map { "Number \($0)" }
            .sink(
                receiveCompletion: { completion in
                    XCTAssertEqual(completion, .finished)
                    XCTAssertEqual(receivedValues, ["Number 1", "Number 2", "Number 3"])
                    expectation.fulfill()
                },
                receiveValue: { value in
                    receivedValues.append(value)
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFilterOperator() {
        let expectation = XCTestExpectation(description: "Filter operator should filter values")
        var receivedValues: [Int] = []
        
        [1, 2, 3, 4, 5, 6].publisher
            .filter { $0 % 2 == 0 }
            .sink(
                receiveCompletion: { completion in
                    XCTAssertEqual(completion, .finished)
                    XCTAssertEqual(receivedValues, [2, 4, 6])
                    expectation.fulfill()
                },
                receiveValue: { value in
                    receivedValues.append(value)
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testCombineLatestOperator() {
        let expectation = XCTestExpectation(description: "CombineLatest should combine latest values")
        var receivedValues: [(String, Int)] = []
        
        let stringSubject = PassthroughSubject<String, Never>()
        let intSubject = PassthroughSubject<Int, Never>()
        
        stringSubject
            .combineLatest(intSubject)
            .sink(
                receiveCompletion: { completion in
                    XCTAssertEqual(completion, .finished)
                    XCTAssertEqual(receivedValues.count, 2)
                    expectation.fulfill()
                },
                receiveValue: { value in
                    receivedValues.append(value)
                }
            )
            .store(in: &cancellables)
        
        stringSubject.send("A")
        intSubject.send(1)
        stringSubject.send("B")
        stringSubject.send(completion: .finished)
        intSubject.send(completion: .finished)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testMergeOperator() {
        let expectation = XCTestExpectation(description: "Merge should merge multiple publishers")
        var receivedValues: [Int] = []
        
        let publisher1 = [1, 2].publisher
        let publisher2 = [3, 4].publisher
        
        publisher1
            .merge(with: publisher2)
            .sink(
                receiveCompletion: { completion in
                    XCTAssertEqual(completion, .finished)
                    XCTAssertEqual(receivedValues.sorted(), [1, 2, 3, 4])
                    expectation.fulfill()
                },
                receiveValue: { value in
                    receivedValues.append(value)
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Error Handling Tests
    
    func testCatchOperator() {
        let expectation = XCTestExpectation(description: "Catch should handle errors")
        var receivedValues: [String] = []
        
        let failingPublisher = Fail<String, TestError>(error: TestError.someError)
        
        failingPublisher
            .catch { error in
                Just("Recovered from \(error)")
            }
            .sink(
                receiveCompletion: { completion in
                    XCTAssertEqual(completion, .finished)
                    XCTAssertEqual(receivedValues, ["Recovered from someError"])
                    expectation.fulfill()
                },
                receiveValue: { value in
                    receivedValues.append(value)
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testTryMapOperator() {
        let expectation = XCTestExpectation(description: "TryMap should handle throwing operations")
        var receivedValues: [Int] = []
        
        ["1", "2", "invalid", "4"].publisher
            .tryMap { string in
                guard let int = Int(string) else {
                    throw TestError.invalidInput
                }
                return int
            }
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        XCTFail("Should have failed with invalid input")
                    case .failure(let error):
                        XCTAssertTrue(error is TestError)
                        expectation.fulfill()
                    }
                },
                receiveValue: { value in
                    receivedValues.append(value)
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Async Publisher Tests
    
    func testAsyncPublisher() async {
        let expectation = XCTestExpectation(description: "Async publisher should emit values")
        var receivedValues: [Int] = []
        
        let asyncPublisher = AsyncPublisher<[Int]> {
            try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
            return [1, 2, 3]
        }
        
        asyncPublisher
            .sink(
                receiveCompletion: { completion in
                    XCTAssertEqual(completion, .finished)
                    XCTAssertEqual(receivedValues, [1, 2, 3])
                    expectation.fulfill()
                },
                receiveValue: { values in
                    receivedValues.append(contentsOf: values)
                }
            )
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    // MARK: - Custom Publisher Tests
    
    func testCustomPublisher() {
        let expectation = XCTestExpectation(description: "Custom publisher should emit values")
        var receivedValues: [String] = []
        
        let customPublisher = CustomStringPublisher(strings: ["Hello", "World"])
        
        customPublisher
            .sink(
                receiveCompletion: { completion in
                    XCTAssertEqual(completion, .finished)
                    XCTAssertEqual(receivedValues, ["Hello", "World"])
                    expectation.fulfill()
                },
                receiveValue: { value in
                    receivedValues.append(value)
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Publisher with ViewModel Tests
    
    func testMemberListViewModelPublisher() {
        let expectation = XCTestExpectation(description: "ViewModel publisher should emit selection changes")
        let viewModel = DMCMemberListViewModel()
        var receivedSelections: [Int?] = []
        
        viewModel.$selectedMemberID
            .sink { selection in
                receivedSelections.append(selection)
                if receivedSelections.count >= 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Initial value
        XCTAssertNil(viewModel.selectedMemberID)
        
        // Select a member
        let member = viewModel.members[0]
        viewModel.selectMember(member)
        XCTAssertEqual(viewModel.selectedMemberID, member.id)
        
        // Clear selection
        viewModel.clearSelection()
        XCTAssertNil(viewModel.selectedMemberID)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedSelections, [nil, member.id, nil])
    }
    
    // MARK: - Publisher with SwiftUI Tests
    
    func testSwiftUIPublisher() throws {
        let expectation = XCTestExpectation(description: "SwiftUI publisher should work with ViewInspector")
        
        let viewModel = DMCMemberListViewModel()
        let memberListView = MemberListView(viewModel: viewModel)
        
        // Test that the view updates when publisher emits
        viewModel.$selectedMemberID
            .sink { selection in
                if selection != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Simulate member selection
        let member = viewModel.members[0]
        viewModel.selectMember(member)
        
        // Verify view structure with ViewInspector
        let list = try memberListView.inspect().navigationView().list()
        XCTAssertNotNil(list)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Publisher Performance Tests
    
    func testPublisherPerformance() {
        let expectation = XCTestExpectation(description: "Publisher should handle many values efficiently")
        let count = 10000
        var receivedCount = 0
        
        (1...count).publisher
            .sink(
                receiveCompletion: { completion in
                    XCTAssertEqual(completion, .finished)
                    XCTAssertEqual(receivedCount, count)
                    expectation.fulfill()
                },
                receiveValue: { _ in
                    receivedCount += 1
                }
            )
            .store(in: &cancellables)
        
        measure {
            // This will measure the performance of the publisher
            wait(for: [expectation], timeout: 5.0)
        }
    }
    
    // MARK: - Publisher Cancellation Tests
    
    func testPublisherCancellation() {
        let expectation = XCTestExpectation(description: "Publisher should be cancellable")
        var receivedCount = 0
        
        let subject = PassthroughSubject<Int, Never>()
        let cancellable = subject
            .sink { _ in
                receivedCount += 1
                if receivedCount >= 5 {
                    expectation.fulfill()
                }
            }
        
        // Send some values
        for i in 1...10 {
            subject.send(i)
        }
        
        // Cancel the subscription
        cancellable.cancel()
        
        // Send more values (should not be received)
        subject.send(11)
        subject.send(12)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertLessThanOrEqual(receivedCount, 10)
    }
}

// MARK: - Supporting Types

enum TestError: Error, Equatable {
    case someError
    case invalidInput
}

struct AsyncPublisher<Output>: Publisher {
    typealias Failure = Never
    
    private let operation: () async throws -> Output
    
    init(operation: @escaping () async throws -> Output) {
        self.operation = operation
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Output == S.Input {
        let subscription = AsyncSubscription(operation: operation, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

private class AsyncSubscription<S: Subscriber>: Subscription where S.Input == AsyncPublisher<S.Input>.Output, S.Failure == Never {
    private let operation: () async throws -> S.Input
    private var subscriber: S?
    private var isCancelled = false
    
    init(operation: @escaping () async throws -> S.Input, subscriber: S) {
        self.operation = operation
        self.subscriber = subscriber
    }
    
    func request(_ demand: Subscribers.Demand) {
        guard !isCancelled else { return }
        
        Task {
            do {
                let result = try await operation()
                await MainActor.run {
                    if !isCancelled {
                        _ = subscriber?.receive(result)
                        subscriber?.receive(completion: .finished)
                    }
                }
            } catch {
                await MainActor.run {
                    if !isCancelled {
                        subscriber?.receive(completion: .finished)
                    }
                }
            }
        }
    }
    
    func cancel() {
        isCancelled = true
        subscriber = nil
    }
}

struct CustomStringPublisher: Publisher {
    typealias Output = String
    typealias Failure = Never
    
    private let strings: [String]
    
    init(strings: [String]) {
        self.strings = strings
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, String == S.Input {
        let subscription = CustomSubscription(strings: strings, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

private class CustomSubscription<S: Subscriber>: Subscription where S.Input == String, S.Failure == Never {
    private let strings: [String]
    private var subscriber: S?
    private var currentIndex = 0
    
    init(strings: [String], subscriber: S) {
        self.strings = strings
        self.subscriber = subscriber
    }
    
    func request(_ demand: Subscribers.Demand) {
        while currentIndex < strings.count && demand > .none {
            _ = subscriber?.receive(strings[currentIndex])
            currentIndex += 1
        }
        
        if currentIndex >= strings.count {
            subscriber?.receive(completion: .finished)
        }
    }
    
    func cancel() {
        subscriber = nil
    }
} 