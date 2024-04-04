<h1> TypewriterCarouselView
  <picture>
  <source srcset="https://github.com/itstheceo/TypewriterCarouselView/blob/assets/icon.png?raw=true">
    <img align="right" alt="Project logo" src="../assets/icon.png" width=74px>
  </picture>
</h1>

A SwiftUI library for rendering text with a typewriter effect.

<p>
  <img src="https://img.shields.io/badge/iOS-13.0+-blue.svg" />
  <img src="https://img.shields.io/badge/-SwiftUI-red.svg" />
</p>

## Installation
This repository is a Swift package; include it in your Xcode project and target under **File > Add package dependencies**, 
then `import TypewriterCarouselView` where you'll be using it.

## Usage
Two views are available for use, `TypewriterCarouselView` and `TypewriterView`.

### TypewriterCarouselView
A view that cycles through multiple texts, animated with a typewriter effect.

```
TypewriterCarouselView(
  text: ["Hello", "World!"],
  speed: .milliseconds(50),
  mode: .writeAndDelete(
    onWriteFinishedDelay: .seconds(3),
    onDeleteFinishedDelay: .seconds(1)
  )
)
```

### TypewriterView
A view that animates text with a typewriter effect.

```
TypewriterView(
  text: "Hello World!",
  speed: .milliseconds(50),
  mode: .writeAndDelete(
    onWriteFinishedDelay: .seconds(3),
    onDeleteFinishedDelay: .seconds(1)
  )
) {
  print("Animation finished!")
}
```

## Todo
Add support for other platforms, and reduce minimum supported versions where possible (pull requests welcome!).
As my current use case allows for the current support, I do not know when I will get around to doing this.

## Questions
If you have any questions or suggestions, you can create an issue or pull request on this GitHub repository.
