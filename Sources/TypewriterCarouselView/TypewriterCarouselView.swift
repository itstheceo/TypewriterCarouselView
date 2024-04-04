//
//  TypewriterView.swift
//
//
//  Created by Colin O'Brien on 4/04/24.
//

import SwiftUI

struct TypewriterCarouselView: View {

  @State var text: [String]
  @State private var currentText: String?
  @State private var cursor: Int = -1
  
  var typingDelay: Duration = .milliseconds(50)
  var onWritingFinishedDelay: Duration = .seconds(5)
  var onDeletingFinishedDelay: Duration = .seconds(1)
  var mode: TypewriterView.Mode = .writeAndDelete

  var body: some View {
    TypewriterView(
      text: currentText,
      typingDelay: typingDelay,
      onTypingFinished: {
        cursor += 1
        currentText = text[cursor % text.count]
      },
      onWritingFinishedDelay: onWritingFinishedDelay,
      onDeletingFinishedDelay: onDeletingFinishedDelay,
      mode: mode
    )
    .font(.title)
    .padding()
  }
}

#Preview {
  TypewriterCarouselView(text: ["Hello", "World!"])
}
