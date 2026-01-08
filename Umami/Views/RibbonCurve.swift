
import SwiftUI

// ... inside SakeDetailView or file ...

// Add this shape at the bottom of the file
struct RibbonCurve: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        
        // Right side anchor (slightly higher)
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - 40))
        
        // Curve to Left side anchor (Lower)
        // Control points create the "Wave"
        path.addCurve(to: CGPoint(x: 0, y: rect.height),
                      control1: CGPoint(x: rect.width * 0.6, y: rect.height + 20),
                      control2: CGPoint(x: rect.width * 0.3, y: rect.height - 30))
        
        path.closeSubpath()
        return path
    }
}
