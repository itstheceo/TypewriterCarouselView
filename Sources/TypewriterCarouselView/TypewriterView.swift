//
//  TypewriterView.swift
//
//
//  Created by Colin O'Brien on 4/04/24.
//

import SwiftUI

/// A text view that animates with a typewriter effect.
public struct TypewriterView: View {
  
  /// The animation modes.
  public enum Mode {
    
    /// Mode for only animating the write effect. Text will remain visible after the animation is finished.
    case write
    
    /// Mode for animating both the write and delete effect. The text will not remain visible after the animation is finished.
    ///
    /// - Parameters
    ///   - onWriteFinishedDelay: Duration of the delay at the end of the text being written.
    ///   - onDeleteFinishedDelay: Duration of the delay at the end of the text being deleted.
    case writeAndDelete(onWriteFinishedDelay: Duration, onDeleteFinishedDelay: Duration)
  }
  
  var text: String?
  var speed: Duration
  var mode: Mode
  var onComplete: (() -> Void)
  
  @State private var animatedText: AttributedString = ""
  @State private var typingTask: Task<Void, Error>?
  
  /// - Parameters
  ///   - text: Text to display.
  ///   - speed: Speed of the typing animation.
  ///   - mode: Mode of the animation.
  ///   - onComplete: Callback to run when the typing animation has finished.
  public init(
    text: String? = nil,
    speed: Duration = .milliseconds(50),
    mode: Mode = .writeAndDelete(onWriteFinishedDelay: .seconds(3), onDeleteFinishedDelay: .seconds(1)),
    onComplete: @escaping () -> Void = {}
  ) {
    self.text = text
    self.speed = speed
    self.mode = mode
    self.onComplete = onComplete
  }
  
  public var body: some View {
    Text(animatedText)
      .onChange(of: text, perform: { _ in animateText() })
      .onAppear { animateText() }
  }
  
  private func animateText() {
    typingTask?.cancel()

    guard let text = text else {
      onComplete()
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

        animatedText[animatedText.startIndex...index]
          .setAttributes(defaultAttributes)

        try await Task.sleep(for: speed)

        index = animatedText.index(afterCharacter: index)
      }

      switch mode {
      case .write: onComplete()

      case .writeAndDelete(let writeFinishedDelay, let deleteFinishedDelay):
        try await Task.sleep(for: writeFinishedDelay)
        
        index = animatedText.endIndex

        while index > animatedText.startIndex {
          try Task.checkCancellation()

          animatedText[index..<animatedText.endIndex]
            .setAttributes(defaultAttributes.foregroundColor(.clear))

          try await Task.sleep(for: speed)

          index = animatedText.index(beforeCharacter: index)
        }

        animatedText.setAttributes(defaultAttributes.foregroundColor(.clear))

        try await Task.sleep(for: deleteFinishedDelay)

        onComplete()
      }
    }
  }
}

#Preview {
  TypewriterView(text: "Hello World!")
    .font(.title)
    .padding()
}
