//
//  ContentView.swift
//  Morning
//
//  Created by William Boyes on 2025-03-12.
//

import SwiftUI
extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

struct ContentView: View {
    var progress: some BinaryFloatingPoint {
            guard let dotw = Date().dayNumberOfWeek() else { return 0.0 }
            switch dotw {
            case 1, 7: return 1.00  // Sunday or Saturday
            case 2: return 0.16  // Monday
            case 3: return 0.32  // Tuesday
            case 4: return 0.48  // Wednesday
            case 5: return 0.64  // Thursday
            case 6: return 0.80  // Friday
            default: return 0.0
            }
        }
    @State private var dtasks = 0
    @State private var toggleStates: [(String, Bool)] = [
        ("Wake up", false),
        ("Make coffee", false),
        ("Make breakfast", false)
    ]
    var taskprog: Double {
        let totalTasks = toggleStates.count
        let completedTasks = toggleStates.filter { $0.1 }.count
        return totalTasks > 0 ? Double(completedTasks) / Double(totalTasks) : 0.0
    }
    var body: some View {
        
        VStack {
            HStack{
                Text("Start of the week")
                ProgressView(value: progress)
                Text("Weekend!!!")
            }
            .padding()
            Text("Tasks")
                .font(.largeTitle)
                .padding(7)
            ForEach(toggleStates.indices, id: \.self) { index in
                Toggle(toggleStates[index].0, isOn: Binding(
                    get: { toggleStates[index].1 },
                    set: { newValue in
                        toggleStates[index].1 = newValue
                        dtasks += newValue ? 1 : -1
                    }
                ))
            }
            ProgressView(value: taskprog)
        }
        .padding()

    }
}

#Preview {
    ContentView()
}
