//

import SwiftUI

public struct ToggleCell: View {
  public let title: LocalizedStringKey
  @Binding public var isOn: Bool

  public init(title: LocalizedStringKey, isOn: Binding<Bool>) {
    self.title = title
    self._isOn = isOn
  }

  public var body: some View {
    HStack {
      Text(title)
        .font(.h1(weight: .bold))
        .foregroundColor(.textDarkGrey)
      Spacer()
      // We should probably have a TSWToggle
      Toggle(isOn: $isOn) { EmptyView() }
        .labelsHidden()
    }.frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct ToggleCell_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      List {
        ToggleCell(title: "Title", isOn: .constant(true))
        ToggleCell(title: "Title", isOn: .constant(false))
        ToggleCell(title: "Long long long long Title", isOn: .constant(true))
      }
      .navigationBarTitle("Description Cell")
    }
  }
}
