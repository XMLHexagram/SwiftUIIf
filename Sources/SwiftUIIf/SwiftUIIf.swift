//
//  View+if.swift
//  SwiftUIIf
//
//  Created by Shibo Lyu on 6/12/25.
//

import SwiftUI

private struct IfElseViewModifier<TC, EC>: ViewModifier
where TC: View, EC: View {
  let condition: Bool
  @ViewBuilder let thenModifier: (AnyView) -> TC
  @ViewBuilder let elseModifier: (AnyView) -> EC

  public func body(content: Content) -> some View {
    if condition {
      thenModifier(AnyView(content))
    } else {
      elseModifier(AnyView(content))
    }
  }
}

extension View {
  /// Apply modifiers based on a condition.
  ///
  /// - Parameters:
  ///   - condition: A Boolean value that determines which modifiers to apply.
  ///   - thenModifier: A closure that takes the original view and returns a modified view if the condition is `true`.
  ///   - elseModifier: A closure that takes the original view and returns a modified view if the condition is `false`.
  /// - Returns: A modified view based on the condition.
  ///
  /// Example:
  /// ```swift
  /// struct ContentView: View {
  ///   @State private var isHighlighted = false
  ///
  ///   var body: some View {
  ///     Text("Hello, World!")
  ///       .if(isHighlighted) {
  ///         $0.bold()
  ///       } else: {
  ///         $0.foregroundStyle(.secondary)
  ///       }
  ///   }
  /// }
  /// ```
  public func `if`<TC, EC>(
    _ condition: Bool,
    @ViewBuilder then thenModifier: @escaping (AnyView) -> TC,
    @ViewBuilder else elseModifier: @escaping (AnyView) -> EC
  ) -> some View where TC: View, EC: View {
    modifier(
      IfElseViewModifier(
        condition: condition,
        thenModifier: thenModifier,
        elseModifier: elseModifier
      )
    )
  }

  /// Apply modifiers based on a condition, returning the original view if the condition is false.
  ///
  /// - Parameters:
  ///   - condition: A Boolean value that determines which modifiers to apply.
  ///   - thenModifier: A closure that takes the original view and returns a modified view if the condition is `true`.
  /// - Returns: A modified view if the condition is `true`, otherwise the original view.
  ///
  /// Example:
  /// ```swift
  /// struct ContentView: View {
  ///   @State private var isHighlighted = false
  ///   var body: some View {
  ///     Text("Hello, World!")
  ///       .if(isHighlighted) {
  ///         $0.bold()
  ///        }
  ///    }
  ///  }
  ///  ```
  public func `if`<TC>(
    _ condition: Bool,
    @ViewBuilder then thenModifier: @escaping (AnyView) -> TC
  ) -> some View where TC: View {
    modifier(
      IfElseViewModifier(
        condition: condition,
        thenModifier: thenModifier,
        elseModifier: { $0 }
      )
    )
  }

  /// Apply modifiers based on whether the optional expression is non-nil.
  ///
  /// - Parameters:
  ///   - optionalExpression: An optional value that determines which modifiers to apply.
  ///   - thenModifier: A closure that takes the original view and the unwrapped value, returning a modified view if the optional is non-nil.
  ///   - elseModifier: A closure that takes the original view and returns a modified view if the optional is nil.
  /// - Returns: A modified view based on whether the optional has a value.
  ///
  /// Example:
  /// ```swift
  /// struct ContentView: View {
  ///   @State private var user: User? = nil
  ///
  ///   var body: some View {
  ///     Text("Welcome")
  ///       .if(let: user) { view, user in
  ///         view.foregroundStyle(.blue)
  ///           .overlay(Text("Hello, \(user.name)"))
  ///       } else: { view in
  ///         view.foregroundStyle(.secondary)
  ///       }
  ///   }
  /// }
  /// ```
  public func `if`<TC, EC, E>(
    `let` optionalExpression: E?,
    @ViewBuilder then thenModifier: @escaping (AnyView, E) -> TC,
    @ViewBuilder else elseModifier: @escaping (AnyView) -> EC
  ) -> some View where TC: View, EC: View {
    modifier(
      IfElseViewModifier(condition: optionalExpression != nil) { view in
        thenModifier(view, optionalExpression!)
      } elseModifier: { view in
        elseModifier(view)
      }
    )
  }

  /// Apply modifiers based on whether the optional expression is non-nil, returning the original view if it is nil.
  ///
  /// - Parameters:
  ///   - optionalExpression: An optional value that determines whether to apply modifiers.
  ///   - thenModifier: A closure that takes the original view and the unwrapped value, returning a modified view if the optional is non-nil.
  /// - Returns: A modified view if the optional has a value, otherwise the original view.
  ///
  /// Example:
  /// ```swift
  /// struct ContentView: View {
  ///   @State private var highlightColor: Color? = nil
  ///
  ///   var body: some View {
  ///     Text("Hello, World!")
  ///       .if(let: highlightColor) { view, color in
  ///         view.background(color)
  ///           .cornerRadius(8)
  ///       }
  ///   }
  /// }
  /// ```
  public func `if`<TC, E>(
    `let` optionalExpression: E?,
    @ViewBuilder then thenModifier: @escaping (AnyView, E) -> TC,
  ) -> some View where TC: View {
    modifier(
      IfElseViewModifier(condition: optionalExpression != nil) { view in
        thenModifier(view, optionalExpression!)
      } elseModifier: {
        $0
      }
    )
  }
}
