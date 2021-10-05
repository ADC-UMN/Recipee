//
//  Binding + Optional.swift
//  Recipee
//
//  Created by Khan Winter on 10/5/21.
//

import SwiftUI

/// Allows us to bind optionals with a default value
/// used in `AddRecipe` to bind ingredient's names to a text field.
/// Gotten from [here](https://stackoverflow.com/questions/57021722/swiftui-optional-textfield)
///
/// Use like:
/// `TextField("Name", $binding ?? "Default Value")`
/// if `$binding` is type `Binding<String?>`
func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
