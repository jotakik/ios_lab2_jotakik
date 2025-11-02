//
//  GameBoard.swift
//  Lab2
//
//  Created by Joshua Tan on 2025/10/9.
//

import SwiftUI

let flagEmojis = [
    "🇲🇱": "flag: Mali",
    "🇬🇳": "flag: Guinea",
    "🇮🇹": "flag: Italy",
    "🇨🇮": "flag: Côte d'Ivoire",
    "🇮🇪": "flag: Ireland",
    "🇫🇷": "flag: France",
    "🇹🇩": "flag: Chad",
    "🇱🇹": "flag: Lithuania",
    "🇬🇦": "flag: Gabon",
    "🇲🇺": "flag: Mauritius",
    "🇳🇱": "flag: Netherlands",
//    "🇱🇺": "flag: Luxembourg",
    "🇬🇲": "flag: Gambia"
]


//  Formats the element that will be seen when the cell is face-up
struct FaceUpElement: View {
    let cellElement: String
    let elementSize: CGFloat
    
    var body: some View {
        Text(cellElement)
            .font(.system(size: elementSize))
    }
}


//  Formats the generic overlay that will be seen when the cell is face-down
struct FaceDownElement: View {
    let overlay: String
    let overlayColor: Color
    
    let elementSize: CGFloat
    var overlaySize: CGFloat { elementSize * 0.85 }
    
    var body: some View {
        Image(systemName: overlay)
            .font(.system(size: overlaySize))
            .foregroundStyle(overlayColor)
    }
}


//  The content of a single cell (face-up element, face-down overlay, cell border)
struct CellContent: View {
    let cellElement: String //  The face-up element
    let overlay: String     //  The name of the SF symbol used as the overlay element
    
    let elementSize: CGFloat = 70   // The size of the face-up element
    let overlayColor = Color(white: 0.4)    // The color of the overlay element and cell border
    
    @State private var isFaceUp = false
    
    //  Creates the frame that aligns the face-up element and the overlay
    struct CellBox: ViewModifier {
        let elementSize: CGFloat
        var boxWidth: CGFloat { elementSize * 1.5 }
        var boxHeight: CGFloat { elementSize * 1.2 }
        
        func body(content: Content) -> some View {
            content
                .frame(width: boxWidth, height: boxHeight, alignment: .center)
        }
    }
    
    var body: some View {
        ZStack {
            FaceUpElement(cellElement: cellElement, elementSize: elementSize)
                .modifier(CellBox(elementSize: elementSize))
                .opacity(isFaceUp ? 1 : 0)
            
            FaceDownElement(overlay: overlay, overlayColor: overlayColor, elementSize: elementSize)
                .modifier(CellBox(elementSize: elementSize))
                .opacity(isFaceUp ? 0 : 1)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20).stroke(overlayColor, lineWidth: 5)
        }
        .padding()
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}


struct GameBoard: View {
    //  Creates 2 copies of each face-up element
    let cellElements = Array(repeating: flagEmojis.keys, count: 2).flatMap { $0 }.shuffled()
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(cellElements.enumerated(), id: \.offset) { _, cellElement in
                    CellContent(cellElement: cellElement, overlay: "flag.fill")
                }
            }
        }
    }
}

#Preview {
    GameBoard()
}
