# Swift Operation Cancellation Lab

A Swift learning exercise exploring operation cancellation and dependencies using `BlockOperation` and `OperationQueue`.

## 🎯 Objective

Understand how cancelling an operation affects its execution and how dependencies change the order in which operations can start.

## 🧠 Concepts Covered

- **`BlockOperation`** — Encapsulates a closure as an operation.
- **`OperationQueue`** — Schedules and manages operations.
- **`cancel()`** — Marks an operation as cancelled.
- **`addDependency(_:)`** — Establishes an execution dependency between operations.
- **`isCancelled`** — Checks whether an operation has been cancelled.
- **`waitUntilFinished`** — Waits for submitted operations to finish.
- **Concurrency** — Demonstrates how scheduling can affect observed execution order.

## ⚙️ How It Works

The project creates two block-based operations: A and B. Both simulate work using a loop of one million iterations.

Operation B is declared before Operation A, as required by the exercise.

Inside Operation A, the code cancels Operation B:

```swift
operationB.cancel()
```

The program runs two experiments.

### Experiment 1: B depends on A

```swift
operationB.addDependency(operationA)
```

Operation B cannot begin until Operation A finishes. Since A cancels B before completing, B's block should not execute.

### Experiment 2: No dependency

The dependency is removed. Both operations can now be scheduled independently.

Operation A still cancels B, but the result depends on whether B has already started:

- If B has not started, its block normally will not execute after cancellation.
- If B is already executing, cancellation does not automatically stop its running code.

## 🛠️ Technologies

- Swift
- Foundation
- Xcode
- `BlockOperation`
- `OperationQueue`

## 🚀 How to Run

1. Clone or download this repository.
2. Open the Xcode project.
3. Run the command-line application.
4. Inspect the console output for both experiments.
5. Compare the behavior with and without the dependency.

The program waits for the operations to finish before printing the final status.

## 📂 Project Structure

```text
swift-operation-cancellation-lab/
├── OperationCancellationLab/
│   └── main.swift
├── OperationCancellationLab.xcodeproj/
└── README.md
```

## 📋 Expected Behavior

| Scenario | Expected behavior |
|---|---|
| B depends on A | B cannot start until A finishes. If A cancels B first, B's block does not execute. |
| No dependency | A and B may execute in different orders. B may or may not start before A cancels it. |

The exact output can vary between executions because the operation queue controls scheduling.

## 📚 Key Takeaway

Operation dependencies control when an operation is eligible to begin. Cancellation marks an operation as cancelled, but it does not automatically interrupt code that is already running.

Comparing both scenarios demonstrates why dependencies and cancellation are separate mechanisms in Swift concurrency.

---

**Project type:** Swift learning exercise  
**Focus:** Operation cancellation, dependencies, and concurrent execution
