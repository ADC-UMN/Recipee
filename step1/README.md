# Step 1 - Intro to Swift, Xcode, App Dev

Welcome to the App Developer Club's iOS workshop! This step will be giving you a quick introduction to the Swift programming language, Xcode, and an overview of iOS App architecture and why having an architecture is important.

## Swift

[Swift](https://swift.org/about/) is an open-source programming language. It's a statically-typed, compiled, general-purpose language with a focus on speed and simple syntax. I like to think of it as what comes out when you toss Java, Python and C++ in a blender and keep all the good parts.

According to Swift.org, *"Swift is a general-purpose programming language built using a modern approach to safety, performance, and software design patterns.".*

You can use it to program for all of Apple's platforms (iOS, iPadOS, MacOS, TvOS, WatchOS) as well as run web servers with frameworks like [Vapor](https://vapor.codes/). There's even some preliminary ports to Windows, but nothing very useful as of this writing

### Basic Syntax

**Variables**

Like in any other programming language, swift allows you to create variables. You can create constants using `let`, which can't be modified and variables using `var` that can be modified. 

Since Swift is a statically-typed language, we need to specify a type for each variable. However, for most variables the Swift compiler can take a good guess and add a type for us so it's not always necessary.

```swift
// Declare a variable with an explicit type
var message: String = "Hello World"
// Declare a constant with an inferred type (String)
let message2 = "Hello World"
```

**Functions**

Declaring a function in swift looks like

```swift
func editMessage(newMessage: String) {
	message = newMessage
}
```

You can pass parameters to a function by adding the `name: Type` inside the parenthesis. For more than one parameter add a `,` between each one like so: `param1: String, param2: Int`.

> Xcode also features a console that we can print data to using `print` like this.
>
> ```swift
> print(message)
> print("This is the message: ", message)
> ```

**Control Flow**

Swift supports basic `if, else if, else` statements like the below example. 

> Note, parenthesis are not required in `if`, `while`, or `for` statements and are considered bad in Swift

```swift
let isTrue = false

if isTrue {
  print("Yay!")
} else if isTrue == false && isTrue == true {
  print("We probably shouldn't be here...")
} else {
  print("Yay 2!")
}
```

`while` and `for` loops also work in swift, and `for` loops have some nice syntactic sugar that makes them look a lot like Python and Java for loops.

```swift
var testScores: [Int] = [0, 1, 50, 75, 76, 99, 100]

while testScores.count > 0 {
  testScores = []
}

// for _ in _ syntax
for score in testScores {
  print(score)
}

// for i in range syntax
for i in 0..<testScores.count {
  print(scores[i])
}
```

> While you *can* use C-style for loops (`for let i, i < 3, i++ {`) in Swift, it won't work in future Swift releases and you'll get a warning from the compiler.

#### Classes

One of Swift's core features is it's ability to do Object-Oriented Programming easily. You can declare a working class with 3 lines of code.

```swift
class Messenger {
  
}
```

This class doesn't do much, but we can add variables and methods to it like so.

```swift
class Messenger {
  var currentMessage: String = "Hello World"
  
  func sendMessage() {
    currentMessage = "sent!"
  }
}
```

Classes will sometimes need to implement an `init` method. This method will give values to any variables that don't have an initial value in the class, and perform any other setup that needs to happen. For instance:

```swift
class Messenger {
  init() {
    // `currentMessage` has only a type, no value. So we need to give it a value in the
    // `init()` function.
		currentMessage = "Hello World"
    
    // Set up the class when it is created
    setupMessenger()
  }
  
  // Declare a private function
  private func setupMessenger() {
    // ...
  }
  
	var currentMessage: String
  
  func sendMessage() {
		currentMessage = "sent!"
  }
}
```

#### Do Catch

Some methods can 'throw' an error. For instance, when reading from a file multiple errors might occur. The file might not exist, the file is corrupted, etc. These functions need to be called in a do-catch block like so.

```swift
do {
  // Call a throwing function with the `try` keyword in front of it
  try sendErrorMessage()
} catch {
  // Handle any errors
  print(error)
}
```

In this example, `sendErrorMessage()` can throw an error. We wrap it in the do-catch block and add a `try` in front of the function call. 

In the `catch` block, there is a variable `error` that is implicitly declared and that we can use to handle the error.

**If you don't handle errors in this way, your code will crash when `sendErrorMessage` throws an error.**

#### Optionals (⚠️ Important)

The major difference between Swift and other programming languages is Swift's idea of Optionals. An optional represents two possibilities: Either there *is* a value, and you can unwrap the optional to access that value, or there *isn’t* a value at all.

> Aside:
>
> This concept doesn't exist in C or C++. In Java, `null` variables simply cause a crash when you access them, same thing in Python.

This example shows how optionals can come in handy. We'll try to convert an `Int` to a string. Since this is something that could fail, the `String` function will just return `nil` if it didn't work.

```swift
let intToConvert: Int = 420
let string: String? = String(intToConvert)
```

Because the initializer might fail, it returns an *optional* `String`, rather than an `String`. An optional `String` is written as `String?`, not `String`. The question mark indicates that the value it contains is optional, meaning that it might contain *some* `String` value, or it might contain *no value at all*. (It can’t contain anything else, such as a `Bool` value or a `Int` value. It’s either an `String`, or it’s nothing at all.)

You can clear a value in a variable by setting the variable to `nil`

```swift
var optionalString: String? = "Hello World"

print(optionalString) // ==> "Hello World"

optionalString = nil

print(optionalString) // ==> nil
```

You can also declare a variable with no value to begin with like this

```swift
var optionalString: String? = nil

print(optionalString) // ==> nil
```

We can *unwrap* an optional value in two ways. Either we provide a fallback value using `??` or we force unwrap the value using `!`

> Note: If you can avoid it, use `!` as little as possible as your code will crash if you force-unwrap a value that doesn't exist

```swift
// Fallback unwrap
let notOptionalString: String = optionalString ?? "Fallback Value"

 // Force unwrap
let notOptionalString2: String = optionalString!
```

Optionals can come in handy when we want to **check** if a value exists in a variable. We can use a simple `if` statement.

```swift
if optionalString == nil {
  print("Looks like the string doesn't exist :(")
} else {
  // Force unwrap is save because we checked if it was `nil` already
  print(optionalString!)
}
```

## Xcode

