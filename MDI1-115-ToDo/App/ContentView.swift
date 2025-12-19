//
//  ContentView.swift
//  MDI1-114-ToDo
//
//  Created by Christian Bonilla on 09/12/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var taskGroups: [TaskGroup] = []
    @State private var selectedGroup: TaskGroup? // Selected group
    @State private var columnVisibility: NavigationSplitViewVisibility = .all // Navigation side panel
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    
    let saveKey = "savedTaskGroups"
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(selection: $selectedGroup) {
                ForEach(taskGroups) { group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle("ToDo App")
            .listStyle(.sidebar)
            .toolbar {
                Button {
                    isDarkMode.toggle()
                } label: {
                    Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                }
                Button {
                    isShowingAddGroup = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        } detail: {
            if let group = selectedGroup {
                if let index = taskGroups.firstIndex(where: { $0.id == group.id }) {
                    TaskGroupDetailView(groups: $taskGroups[index])
                }
            } else {
                ContentUnavailableView("Select a Group" , systemImage: "sidebar.left")
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                taskGroups.append(newGroup)
                selectedGroup = newGroup // automatically show up the details of the new group I created
            }
        }
        .onAppear{
            loadData()
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            if newValue == .active {
                print("App is active and running")
            } else if newValue == .inactive {
                print("App is inactive / not used right now")
            } else if newValue == .background {
                print("App is in background mode")
                saveData()
            }
        }
    }
    
    func saveData() {
        if let encodeData = try? JSONEncoder().encode(taskGroups) {
            UserDefaults.standard.set(encodeData, forKey: saveKey)
        }
    }
    
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData) {
                taskGroups = decodedGroups
                return
            }
        }
        
        // Show mock data for dev purposes
        taskGroups = TaskGroup.sampleData
    }
}
