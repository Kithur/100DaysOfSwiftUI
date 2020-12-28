//
//  ContentView.swift
//  Drawing
//
//  Created by Roberto Gutiérrez on 25/09/20.
//

import SwiftUI

/*
struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: CGFloat
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = CGFloat(self.outerRadius)
        let innerRadius = CGFloat(self.innerRadius)
        let distance = CGFloat(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * CGFloat.pi * outerRadius / CGFloat(divisor)) * amount
        
        var path = Path()
        
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
}*/

/*
struct Arrow: Shape {
    var thickness: CGFloat
    
    var animatableData: CGFloat {
        get { thickness }
        set{ self.thickness = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX / 3, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 2 / 3, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 2 / 3, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX / 3, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX / 3, y: rect.maxY))
        
        return path
    }
}
*/

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 149
    var gradientStart: CGFloat
    var gradientEnd: CGFloat
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: UnitPoint(x: 0.5, y: gradientStart), endPoint: UnitPoint(x: 0.5, y: gradientEnd)), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    /*
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount: CGFloat = 1.0
    @State private var hue = 0.6
    @State private var thickness: CGFloat = 10
    */
    
    @State private var colorCycle = 0.0
    
    @State private var gradientStart: CGFloat = 0.0
    @State private var gradientEnd: CGFloat = 1.0
    
    var body: some View {
        
        VStack {
            ColorCyclingRectangle(amount: self.colorCycle, gradientStart: gradientStart, gradientEnd: gradientEnd)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
            Text("Start")
            Slider(value: $gradientStart, in: 0...1)
            Text("End")
            Slider(value: $gradientEnd, in: 0...1)
            
        }
        /*
        Arrow(thickness: thickness)
            .stroke(Color.orange, style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round))
            .frame(width: 300, height: 200)
            .onTapGesture {
                withAnimation {
                self.thickness = CGFloat.random(in: 5...30)
                }
            }
        */
        
        /*VStack(spacing: 0) {
            Spacer()
            
            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                .frame(width: 300, height: 300)
            
            Spacer()
            
            Group {
                Text("Inner radius: \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Outer radius: \(Int(outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Distance: \(Int(distance))")
                Slider(value: $distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Amount: \(amount, specifier: "%.2f")")
                Slider(value: $amount)
                    .padding([.horizontal, .bottom])
                
                Text("Color")
                Slider(value: $hue)
                    .padding(.horizontal)
            }
        }*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
