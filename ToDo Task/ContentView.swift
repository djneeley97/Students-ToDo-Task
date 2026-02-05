//
//  ContentView.swift
//  ToDo Task
//
//  Created by Gabriela Sanchez on 09/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var taskGroups = TaskGroup.sampleData // See MockData
    @State private var selectedGroup: TaskGroup? // selected group
    @State private var columnVisibility: NavigationSplitViewVisibility = .all // navigation side panel
    @State private var isShowingAddGroup = false
    
    @AppStorage("appLanguage") private var appLanguage: AppLanguage = .english
    @Environment(\.dismiss) private var dismiss
    @Binding var profile: Profile
    
    var currentLanguageFlag: String {
        appLanguage.flag
    }

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // SIDEBAR
            List(selection: $selectedGroup) {
                ForEach(profile.groups) { group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle("ToDo APP")
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingAddGroup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        let all = AppLanguage.allCases
                        if let index = all.firstIndex(of: appLanguage) {
                            appLanguage = all[(index + 1) % all.count]
                        }
                    } label: {
                        Text(currentLanguageFlag)
                            .font(.system(size: 22))
                            .frame(width: 44, height: 44)
                            .background(
                                Circle().fill(Color(.systemBackground))
                            )
                            .shadow(radius: 2)
                    }
                    .padding(.leading, 0)
                    .padding(.bottom, 12)
                }
            }
        } detail: {
            Group {
                if let group = selectedGroup, let index = taskGroups.firstIndex(where: { $0.id == group.id }) {
                    TaskGroupDetailView(groups: $profile.groups[index])
                } else {
                    ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
                }
            }
        }
        .navigationSplitViewStyle(.balanced)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                profile.groups.append(newGroup)
                selectedGroup = newGroup
            }
        }
    }
}

