//
//  ContentView.swift
//  05Transferable_CO
//
//  Created by deathot on 10/22/24.
//

import SwiftUI
import Algorithms
import UniformTypeIdentifiers

struct ContentView: View {
    
    // init var
    @State private var todoTasks: [DeveloperTask] = [MockData.taskOne, MockData.taskTwo, MockData.taskThree]
    @State private var inprogressTasks: [DeveloperTask] = []
    @State private var doneTasks: [DeveloperTask] = []
    
    @State private var isinprogressTargeted = false
    @State private var istodoTargeted = false
    @State private var isdoneTargeted = false


    
    var body: some View {
        HStack(spacing: 12) {
            
            // use KanbanView
            KanbanView(title: "To Do", tasks: todoTasks, isTargeted: istodoTargeted)
            
            // drop function
                .dropDestination(for: DeveloperTask.self) { droppedTasks, location in
                
                // delete original task
                for task in droppedTasks {
                    todoTasks.removeAll { $0.id == task.id }
                    inprogressTasks.removeAll { $0.id == task.id }
                    doneTasks.removeAll { $0.id == task.id }
                }
                
                // avoid duplicates
                let totalTasks = todoTasks + droppedTasks
                todoTasks = Array(totalTasks.uniqued())
                return true
            } isTargeted: { isTargeted in
                istodoTargeted = isTargeted
            }
            
            KanbanView(title: "In Process", tasks: inprogressTasks, isTargeted: isinprogressTargeted)
            
                // drop function
                .dropDestination(for: DeveloperTask.self) { droppedTasks, location in
                    
                    // delete original task
                    for task in droppedTasks {
                        todoTasks.removeAll { $0.id == task.id }
                        inprogressTasks.removeAll { $0.id == task.id }
                        doneTasks.removeAll { $0.id == task.id }
                    }
                    
                    // avoid duplicates
                    let totalTasks = inprogressTasks + droppedTasks
                    inprogressTasks = Array(totalTasks.uniqued())
                    return true
                } isTargeted: { isTargeted in
                    isinprogressTargeted = isTargeted
                }
            KanbanView(title: "Done", tasks: doneTasks, isTargeted: isdoneTargeted)
            
            // drop function
                .dropDestination(for: DeveloperTask.self) { droppedTasks, location in
                
                // delete original task
                for task in droppedTasks {
                    todoTasks.removeAll { $0.id == task.id }
                    inprogressTasks.removeAll { $0.id == task.id }
                    doneTasks.removeAll { $0.id == task.id }
                }
                
                // avoid duplicates
                let totalTasks = doneTasks + droppedTasks
                doneTasks = Array(totalTasks.uniqued())
                return true
            } isTargeted: { isTargeted in
                isdoneTargeted = isTargeted
            }
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

// init kanbanview View
struct KanbanView: View {
    
    let title: String
    let tasks: [DeveloperTask]
    let isTargeted: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.footnote.bold())
            
            // set kanbanview shape
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(isTargeted ? .teal.opacity(0.15) : Color(.secondarySystemFill))
                
                // set tasks shape
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(tasks, id: \.self) { task in
                        Text(task.title)
                            .padding(12)
                            .background(Color(uiColor: .secondarySystemGroupedBackground))
                            .cornerRadius(8)
                            .shadow(radius: 0.1, x: 0.1, y: 0.1)
//                            .draggable(task)
                            .draggable(task, preview: {
                                // Return an empty view as the drag preview to prevent flashing
                                Color.clear.frame(width: 3, height: 3)
                            })
                    }
                    Spacer()
                }
                .padding(.vertical)
            }
        }
    }
}

struct DeveloperTask: Codable, Hashable, Transferable {
    let id: UUID
    let title: String
    let owner: String
    let note: String
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .developerTask)
    }
}

extension UTType {
    static let developerTask = UTType(exportedAs: "co.deathot.developerTask")
}

struct MockData {
    static let taskOne = DeveloperTask(id: UUID(),
                                       title: "deathot0",
                                       owner: "deathot",
                                       note: "Note placeholder")
    
    static let taskTwo = DeveloperTask(id: UUID(),
                                       title: "deathot1",
                                       owner: "deathot",
                                       note: "Note placeholder")
    
    static let taskThree = DeveloperTask(id: UUID(),
                                       title: "deathot2",
                                       owner: "deathot",
                                       note: "Note placeholder")
}
