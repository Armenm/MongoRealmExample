//

import SwiftUI

struct PreviewTemplate<Content: View>: View {
  let title: String
  let content: Content
  
  init(title: String, @ViewBuilder content: () -> Content) {
    self.title = title
    self.content = content()
  }
  
  var body: some View {
    NavigationView {
      List {
        content
      }
      .navigationBarTitle(title)
    }
  }
}
