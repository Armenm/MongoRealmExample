import SwiftUI

private struct PreviewProviderModifier: ViewModifier {

  @ViewBuilder
  func body(content: Content) -> some View {
    content
      .previewDisplayName("Light Mode")
      .environment(\.colorScheme, .light)

    content
      .previewDisplayName("Dark Mode")
      .environment(\.colorScheme, .dark)

    content
      .previewDisplayName("Right To Left")
      .environment(\.layoutDirection, .rightToLeft)

    content
      .previewDisplayName("Large Text")
      .environment(\.sizeCategory, .accessibilityExtraExtraLarge)
  }
}

extension View {
  func previewCases() -> some View {
    modifier(PreviewProviderModifier())
  }
}
