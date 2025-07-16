# SwiftUI `.if`

A simple utility modifier for conditionally adding modifiers to your SwiftUI view, with support for unwraping optional values.

```swift
import SwiftUI
import SwiftUIIf

struct HelloView: View {
  @Environment(\.myMood) private var myMood 
  var body: some View {
    Text("Hello, world!")
      .if(let: myMood) { view, mood in
        view
          .if(mood == .excited) {
            $0.textCase(.uppercase)
          }
          .if(mood == .sad) {
            $0.foregroundStyle(.quinary)
          }
      } else: {
        // Mood is missing
        $0.background(Color.red)
      }
  }
}
```

**ProTip:** It's handy in cases where you just need one simple modifier for a specific case, but don't let your SwiftUI view body grow too big because of the convenience `;)`.
A more complex view will be harder for compiler to type check (or outright timeout in doing so), and runtime view update performance is likely to suffer too, not mentioning the maintenance cost of an *indentation hell*.

## License

[MIT](https://laosb.mit-license.org).
