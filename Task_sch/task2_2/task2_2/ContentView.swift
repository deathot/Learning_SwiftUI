//
//  ContentView.swift
//  task2_2
//
//  Created by deathot on 11/2/24.
//

import SwiftUI

// statement student argu
struct Student: Identifiable, Codable {
    var id = UUID()
    var name: String
    var age: Int
    var gender: String
}

// mian view
struct ContentView: View {
    @State private var students: [Student] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 41 / 255, green: 42 / 255, blue: 47 / 255)
                    .ignoresSafeArea()
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        Text("StuID: 221409040425")
                        Text(" ")
                        Text("StuNAME: 肖国豪")
                    }
                    .bold()
                    .foregroundStyle(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 20)
                    
                    VStack(spacing: 80) {
                        ForEach(0..<13) { index in
                            NavigationLink(destination: DetailView(imageName: "image\(index+1)", students: $students)) {
                                VStack(alignment: .leading) {
                                    Text("Major \(index+1)")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                    
                                    Image("image\(index+1)")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 330, height: 200)
                                        .cornerRadius(12)
                                        .padding()
                                        .background(
                                            Color(
                                                red: Double.random(in: 0...1),
                                                green: Double.random(in: 0...1),
                                                blue: Double.random(in: 0...1)
                                            )
                                        )
                                        .cornerRadius(15)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding(.top, 40)
                .navigationTitle("Major")
            }
        }
        .onAppear {
            loadStudents()
        }
    }
    
    func saveStudents() {
        if let encodedData = try? JSONEncoder().encode(students) {
            UserDefaults.standard.set(encodedData, forKey: "students")
        }
    }
    
    func loadStudents() {
        if let savedData = UserDefaults.standard.data(forKey: "students"),
           let decodedData = try? JSONDecoder().decode([Student].self, from: savedData) {
            students = decodedData
        }
    }
}

struct DetailView: View {
    var imageName: String
    @Binding var students: [Student]
    @State private var searchQuery = ""

    var filteredStudents: [Student] {
        if searchQuery.isEmpty {
            return students
        } else {
            return students.filter { $0.name.contains(searchQuery) }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 41 / 255, green: 42 / 255, blue: 47 / 255)
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        TextField("Search students", text: $searchQuery)
                            .padding()
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(8)
                            .foregroundColor(.black)
                            .bold()
                            .padding(.horizontal, 20)
                            .padding(.bottom, 30)
                            .padding(.top, 20)
                        
                        StudentGenderPieChart(students: filteredStudents)
                            .frame(width: 350, height: 300)
                            .padding(.top, 20)
                        
                        NavigationLink("View Student Details", destination: StudentListView(students: $students))
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(colors: [Color.blue, Color.purple], startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .padding(.top, 80)
                    }
                }
                .navigationTitle("Statistics")
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}
// specific chart view
struct StudentGenderPieChart: View {
    var students: [Student]
    
    var maleCount: Int {
        students.filter { $0.gender == "Male" }.count
    }
    
    var femaleCount: Int {
        students.filter { $0.gender == "Female" }.count
    }
    
    var malePercentage: Double {
        Double(maleCount) / Double(students.count)
    }
    
    var femalePercentage: Double {
        Double(femaleCount) / Double(students.count)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(malePercentage))
                .stroke(Color.blue, lineWidth: 50)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .trim(from: CGFloat(malePercentage), to: 1)
                .stroke(Color.pink, lineWidth: 50)
                .rotationEffect(.degrees(-90))
            
            VStack {
                Text("Gender Distribution")
                    .foregroundStyle(.white)
                    .font(.title)
                HStack {
                    Circle().fill(Color.blue).frame(width: 10, height: 10)
                    Text("Male: \(maleCount)")
                    Circle().fill(Color.pink).frame(width: 10, height: 10)
                    Text("Female: \(femaleCount)")
                }
                .font(.title3)
                .bold()
                .foregroundStyle(.white)
            }
        }
    }
}

// student list view
struct StudentListView: View {
    @Binding var students: [Student]
    @State private var showingAddStudent = false
    @State private var showingEditStudent = false
    @State private var selectedStudent: Student?

    var body: some View {
        NavigationView {
            List {
                ForEach(students) { student in
                    HStack {
                        Text(student.name)
                        Spacer()
                        Text("Age: \(student.age), Gender: \(student.gender)")
                    }
                    .onTapGesture {
                        selectedStudent = student
                        showingEditStudent = true
                    }
                }
                .onDelete(perform: deleteStudent)
                .onMove(perform: moveStudent)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingAddStudent = true }) {
                        Label("Add Student", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddStudent) {
                AddStudentView(students: $students)
            }
            .sheet(isPresented: $showingEditStudent) {
                if let student = selectedStudent {
                    EditStudentView(students: $students, student: student)
                }
            }
            .navigationTitle("Student List")
        }
    }

    func deleteStudent(at offsets: IndexSet) {
        students.remove(atOffsets: offsets)
        saveStudents()
    }

    func moveStudent(from source: IndexSet, to destination: Int) {
        students.move(fromOffsets: source, toOffset: destination)
        saveStudents()
    }
    
    func saveStudents() {
        if let encodedData = try? JSONEncoder().encode(students) {
            UserDefaults.standard.set(encodedData, forKey: "students")
        }
    }
}

// specific edit view
struct EditStudentView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var students: [Student]
    var student: Student
    @State private var name: String
    @State private var age: String
    @State private var gender: String
    
    init(students: Binding<[Student]>, student: Student) {
        self._students = students
        self.student = student
        _name = State(initialValue: student.name)
        _age = State(initialValue: "\(student.age)")
        _gender = State(initialValue: student.gender)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Age", text: $age)
                    .keyboardType(.numberPad)
                Picker("Gender", selection: $gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .navigationTitle("Edit Student")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let index = students.firstIndex(where: { $0.id == student.id }), let age = Int(age) {
                            students[index].name = name
                            students[index].age = age
                            students[index].gender = gender
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

// specific add view
struct AddStudentView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var students: [Student]
    @State private var name = ""
    @State private var age = ""
    @State private var gender = "Male"

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Age", text: $age)
                    .keyboardType(.numberPad)
                Picker("Gender", selection: $gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .navigationTitle("Add New Student")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let age = Int(age) {
                            let newStudent = Student(name: name, age: age, gender: gender)
                            students.append(newStudent)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
