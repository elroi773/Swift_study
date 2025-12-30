//:[Previous]

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    @State private var scale: CGFloat = 1.0
    @State private var isAnimating = false
    var body: some View {
        VStack {
            Text("Hello Playground")
                .font(.title)
                .foregroundColor(.blue)

            Circle()
                .fill(Color(.systemBlue))
                .frame(width: 100, height: 100)
                .scaleEffect(scale)
                .padding()
                .onTapGesture {
                    withAnimation {
                        isAnimating.toggle()
                        scale = isAnimating ? 1.5 : 1.0
                    }
                }
        }
    }
}

let contentView = ContentView()

PlaygroundPage.current.setLiveView(contentView)


//: [Next]
