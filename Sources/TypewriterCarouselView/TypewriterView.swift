//
//  TypewriterView.swift
//
//
//  Created by Colin O'Brien on 4/04/24.
//

import SwiftUI

struct TypewriterView: View {
  
  enum Mode {
    case write, writeAndDelete
  }
  
  var text: String?
  var typingDelay: Duration = .milliseconds(50)
  var onTypingFinished: (() -> Void) = {}
  var onWritingFinishedDelay: Duration = .seconds(5)
  var onDeletingFinishedDelay: Duration = .seconds(1)
  var mode: Mode = .writeAndDelete
  
  @State private var animatedText: AttributedString = ""
  @State private var typingTask: Task<Void, Error>?
  
  var body: some View {
    Text(animatedText)
      .onChange(of: text, perform: { _ in animateText() })
      .onAppear { animateText() }
  }
  
  private func animateText() {
    typingTask?.cancel()

    guard let text = text else {
      onTypingFinished()
      return
    }

    typingTask = Task {
      let defaultAttributes = AttributeContainer()
      animatedText = AttributedString(
        text,
        attributes: defaultAttributes.foregroundColor(.clear)
      )

      var index = animatedText.startIndex
      while index < animatedText.endIndex {
        try Task.checkCancellation()

        // Update the style
        animatedText[animatedText.startIndex...index]
          .setAttributes(defaultAttributes)

        // Wait
        try await Task.sleep(for: typingDelay)

        // Advance the index, character by character
        index = animatedText.index(afterCharacter: index)
      }

      // Wait
      try await Task.sleep(for: onWritingFinishedDelay)

      switch mode {
      case .write: onTypingFinished()

      case .writeAndDelete:
        index = animatedText.endIndex

        while index > animatedText.startIndex {
          try Task.checkCancellation()

          animatedText[index..<animatedText.endIndex]
            .setAttributes(defaultAttributes.foregroundColor(.clear))

          try await Task.sleep(for: typingDelay)

          index = animatedText.index(beforeCharacter: index)
        }

        animatedText.setAttributes(defaultAttributes.foregroundColor(.clear))

        try await Task.sleep(for: onDeletingFinishedDelay)

        onTypingFinished()
      }
    }
  }
}

#Preview {
  TypewriterView(text: "Hello World!")
}
