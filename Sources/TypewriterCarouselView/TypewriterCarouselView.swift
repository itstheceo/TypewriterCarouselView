//
//  TypewriterView.swift
//
//
//  Created by Colin O'Brien on 4/04/24.
//

import SwiftUI

/// A text view that cycles through multiple texts, animated with a typewriter effect.
public struct TypewriterCarouselView: View {

  var text: [String]
  var speed: Duration
  var mode: TypewriterView.Mode
  
  @State private var currentText: String?
  @State private var cursor: Int = -1
  
  /// - Parameters
  ///   - text: Array of text to cycle through.
  ///   - speed: Speed of the typing animation.
  ///   - mode: Mode of the animation.
  public init(
    text: [String] = [],
    speed: Duration = .milliseconds(50),
    mode: TypewriterView.Mode = .writeAndDelete(onWriteFinishedDelay: .seconds(3), onDeleteFinishedDelay: .seconds(1))
  ) {
    self.text = text
    self.speed = speed
    self.mode = mode
  }

  public var body: some View {
    TypewriterView(
      text: currentText,
      speed: speed,
      mode: mode
    ) {
      cursor += 1
      currentText = text[cursor % text.count]
    }
  }
}

#Preview {
  TypewriterCarouselView(text: ["Hello", "World!"])
    .font(.title)
    .padding()
}
