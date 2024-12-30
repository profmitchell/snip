import SwiftUI

struct Note: Codable, Identifiable, Equatable {
    let id: UUID
    var content: String
    var name: String
    
    init(id: UUID = UUID(), content: String, name: String? = nil) {
        self.id = id
        self.content = content
        self.name = name ?? "Note \(UUID().uuidString.prefix(4))"
    }
}

struct Tab: Codable, Identifiable, Equatable {
    let id: UUID
    var name: String
    var notes: [Note]
    
    private static var noteCounter = 1
    
    init(id: UUID = UUID(), name: String, notes: [Note] = []) {
        self.id = id
        self.name = name
        self.notes = notes
    }
    
    mutating func addNote(content: String = "") {
        let noteName = "Note \(Tab.noteCounter)"
        notes.append(Note(content: content, name: noteName))
        Tab.noteCounter += 1
    }
    
    static func resetCounter() {
        noteCounter = 1
    }
}

struct ContentView: View {
    @State private var tabs: [Tab] = {
        if let data = UserDefaults.standard.data(forKey: "snipTabs"),
           let decoded = try? JSONDecoder().decode([Tab].self, from: data) {
            return decoded
        }
        return [Tab(name: "General", notes: [Note(content: "Type your first note here...")])]
    }()
    
    @State private var selectedTab: UUID?
    @State private var newTabName: String = ""
    @State private var isAddingTab: Bool = false
    @State private var showingSettings = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            ForEach(tabs) { tab in
                                TabButton(name: tab.name, isSelected: selectedTab == tab.id) {
                                    selectedTab = tab.id
                                }
                            }
                            
                            Button(action: { isAddingTab = true }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.1))
                    )
                    .padding(.horizontal)
                    
                    if isAddingTab {
                        HStack {
                            TextField("Tab name", text: $newTabName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 8)
                            
                            Button("Add") {
                                if (!newTabName.isEmpty) {
                                    let newTab = Tab(name: newTabName)
                                    tabs.append(newTab)
                                    selectedTab = newTab.id
                                    newTabName = ""
                                    isAddingTab = false
                                    saveTabs()
                                }
                            }
                            
                            Button("Cancel") {
                                isAddingTab = false
                                newTabName = ""
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
                
                Button(action: { showingSettings.toggle() }) {
                    Image(systemName: "gear")
                        .foregroundColor(.gray)
                }
                .buttonStyle(BorderlessButtonStyle())
                .popover(isPresented: $showingSettings) {
                    VStack(alignment: .leading, spacing: 15) {
                        Button("Quit Snip") {
                            NSApplication.shared.terminate(nil)
                        }
                        
                        Divider()
                        
                        Text("Developed by Mitchell Cohen")
                            .font(.caption)
                        Text("Newton, MA 2024")
                            .font(.caption)
                        Link("www.mitchellcohen.net", destination: URL(string: "https://www.mitchellcohen.net")!)
                            .font(.caption)
                    }
                    .padding()
                    .frame(width: 200)
                }
            }
            .padding(.horizontal)

            // Notes Section
            if let currentTabIndex = tabs.firstIndex(where: { $0.id == selectedTab ?? tabs.first?.id }) {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach($tabs[currentTabIndex].notes) { $note in
                            VStack(alignment: .leading, spacing: 8) {
                                TextField("Note name", text: $note.name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal, 12)
                                
                                TextEditor(text: $note.content)
                                    .frame(minHeight: 60)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 12)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                
                                HStack {
                                    Button(action: {
                                        NSPasteboard.general.clearContents()
                                        NSPasteboard.general.setString(note.content, forType: .string)
                                    }) {
                                        Label("Copy", systemImage: "doc.on.doc")
                                            .foregroundColor(.blue)
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        tabs[currentTabIndex].notes.removeAll(where: { $0.id == note.id })
                                        saveTabs()
                                    }) {
                                        Label("Delete", systemImage: "minus.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 2)
                        }
                    }
                    .padding()
                }

                VStack(spacing: 10) {
                    Divider()
                    
                    HStack {
                        Button(action: {
                            tabs[currentTabIndex].addNote()
                            saveTabs()
                        }) {
                            Label("Add Note", systemImage: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            if tabs.count > 1 {
                                tabs.remove(at: currentTabIndex)
                                selectedTab = tabs.first?.id
                                saveTabs()
                            }
                        }) {
                            Label("Delete Tab", systemImage: "trash")
                                .foregroundColor(.red)
                        }
                        
                        Button("Clear All") {
                            tabs[currentTabIndex].notes.removeAll()
                            saveTabs()
                        }
                    }
                    .padding(.horizontal)
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
        .frame(minWidth: 350, minHeight: 400)
        .padding()
        .onChange(of: tabs) { _ in
            saveTabs()
        }
    }
    
    private func saveTabs() {
        if let encoded = try? JSONEncoder().encode(tabs) {
            UserDefaults.standard.set(encoded, forKey: "snipTabs")
        }
        Tab.resetCounter()
    }
}

struct TabButton: View {
    let name: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(name)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color.clear)
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(8)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}