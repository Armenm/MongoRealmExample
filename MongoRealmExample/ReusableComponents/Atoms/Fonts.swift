//

import SwiftUI

public extension Font {
  static func h1(weight: Weight) -> Font {
    title
      .weight(weight)
  }

  static func h2(weight: Weight) -> Font {
    headline
      .weight(weight)
  }

  static func paragraph() -> Font {
    body
  }
}

struct Font_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      List {
        Section(header: Text("H1")) {
          Text("Medium")
            .font(.h1(weight: .medium))
          Text("Bold")
            .font(.h1(weight: .bold))
        }

        Section(header: Text("H2")) {
          Text("Medium")
            .font(.h2(weight: .medium))
          Text("Bold")
            .font(.h2(weight: .bold))
        }

        Section(header: Text("Paragraph")) {
          Text("Regular")
            .font(.paragraph())
        }
      }
      .listStyle(GroupedListStyle())
      .navigationBarTitle("Fonts")
    }
  }
}
