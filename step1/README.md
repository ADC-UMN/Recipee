# Step 1 - Intro to Swift, Xcode, App Dev

Welcome to the App Developer Club's iOS workshop! This step will be giving you a quick introduction to the Swift programming language, Xcode, and an overview of iOS App architecture and why having an architecture is important.

## Swift

[Swift](https://swift.org/about/) is an open-source programming language. It's a statically-typed, compiled, general-purpose language with a focus on speed and simple syntax. I like to think of it as what comes out when you toss Java, Python and C++ in a blender and keep all the good parts.

According to Swift.org, *"Swift is a general-purpose programming language built using a modern approach to safety, performance, and software design patterns.".*

You can use it to program for all of Apple's platforms (iOS, iPadOS, MacOS, TvOS, WatchOS) as well as run web servers with frameworks like [Vapor](https://vapor.codes/). There's even some preliminary ports to Windows, but nothing very useful as of this writing

### Basic Syntax

Like in any other programming language, swift allows you to create variables. You can create constants using `let`, which can't be modified and variables using `var` that can be modified. 

Since Swift is a statically-typed language, we need to specify a type for each variable. However, for most variables the Swift compiler can take a good guess and add a type for us so it's not always necessary.

```swift
// Declare a variable with an explicit type
var message: String = "Hello World"
// Declare a constant with an inferred type (String)
let message2 = "Hello World"
```

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

The major difference between Swift and other programming languages is Swift's idea of Optionals. Optionals are variables that might have data in them, and might not. 



