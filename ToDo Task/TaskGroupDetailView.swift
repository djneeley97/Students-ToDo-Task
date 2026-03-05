//
//  TaskGroupDetailView.swift
//  ToDo Task
//
//  Created by Gabriela Sanchez on 09/12/25.
//

import SwiftUI


struct TaskGroupDetailView: View {
    @Binding var groups: TaskGroup
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        List {
            Section {
                if sizeClass == .regular {
                    GroupStatsView(tasks: groups.tasks)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color(.secondarySystemBackground))
                }
            }
            
            ForEach($groups.tasks) { $task in
                HStack {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(task.isCompleted ? .cyan : .gray)
                        .onTapGesture {
                            withAnimation {
                                task.isCompleted.toggle()
                            }
                        }
                        
                    
                    TextField("Task Title", text: $task.title)
                        .strikethrough(task.isCompleted)
                        .accessibilityIdentifier("TaskTextField_\(task.id)")
                }
                
                HStack {
                    DatePicker("Goal Date", selection: $task.dueDate, displayedComponents: .date)
                        .labelsHidden()
                        .scaleEffect()
                        .accessibilityIdentifier("TaskDatePicker")
                    
                    Text("Due: \(task.dueDate.formatted(date: .abbreviated, time: .omitted))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .accessibilityIdentifier("TaskDateLabel")
                }
                .padding(.leading, 12)
                
                Picker("Priority", selection: $task.priority) {
                    Text("Low").tag(Priority.low)
                    Text("Medium").tag(Priority.medium)
                    Text("High").tag(Priority.high)
                }
                .accessibilityIdentifier("PriorityPicker")
                    
                }
            }
            .onDelete { index in
                groups.tasks.remove(atOffsets: index)
            }
        }
        .navigationTitle(groups.title)
        .toolbar {
            Button("Add Task") {
                withAnimation {
                    groups.tasks.append(TaskItem(title: ""))
                }
            }
        }
    }

