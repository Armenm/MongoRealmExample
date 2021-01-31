//

import SwiftUI

struct ColorsPreviewSection: View {
  let title: String
  let colors: [Color]

  var body: some View {
    Section(header: Text(title)) {
      HStack {
        ForEach(colors, id: \.self) { color in
          RoundedRectangle(cornerRadius: 12)
            .fill(color)
        }
      }
    }
  }
}
