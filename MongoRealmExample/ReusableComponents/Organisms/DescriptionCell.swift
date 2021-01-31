//

import SwiftUI

public struct DescriptionCell: View {
  public let title: LocalizedStringKey
  public let description: String

  public init(title: LocalizedStringKey, description: String) {
    self.title = title
    self.description = description
  }

  public var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.h1(weight: .bold))
        .foregroundColor(.textDarkGrey)
      Text(description)
        .fixedSize(horizontal: false, vertical: true)
        .font(.h1(weight: .regular))
        .foregroundColor(.textGrey)
    }.frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct DescriptionCell_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      List {
        DescriptionCell(title: "Title", description: "Description")
        DescriptionCell(title: "Title", description: "Long long long long long long long description")
      }
      .navigationBarTitle("Description Cell")
    }
  }
}
