//

import SwiftUI

public extension Color {

  // MARK: Primary

  static let green600 = Color("green600")
  static let green500 = Color("green500")

  // MARK: Accents

  static let gold200 = Color("gold200")
  static let gold100 = Color("gold100")

  // MARK: Status

  static let success200 = Color("success200")
  static let error200 = Color("error200")
}

struct Colors_Previews: PreviewProvider {
  static let primaryColors: [Color] = [.green600, .green500]
  static let accentsColors: [Color] = [.gold200, .gold100]
  static let statusColors: [Color] = [.success200, .error200]

  static var previews: some View {
    NavigationView {
      List {
        ColorsPreviewSection(title: "Primary", colors: self.primaryColors)
        ColorsPreviewSection(title: "Accents", colors: self.accentsColors)
        ColorsPreviewSection(title: "Status", colors: self.statusColors)
      }
      .listStyle(GroupedListStyle())
      .navigationBarTitle("Colors")
    }
  }
}
