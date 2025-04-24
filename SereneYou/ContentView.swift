import SwiftUI
import AVFoundation
import PencilKit

struct ContentView: View {
    @State private var selectedTab = 0  // Track selected tab

    var body: some View {
           TabView(selection: $selectedTab) {
                NavigationStack {
                    DogAnimationView(selectedTab: $selectedTab)
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)  // Tag Home as 0
                
                NextView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Mood Tracker")
                    }
                    .tag(1)  // Tag Mood Tracker as 1
            }
    }
}

struct DogAnimationView: View {
    @Binding var selectedTab: Int
    
    @State private var dogPositionX: CGFloat = -200 // Start off-screen
    @State private var dogScale: CGFloat = 1.0 // Normal size
    @State private var showGreetingAndButton: Bool = false
    
    var body: some View {
        
        ZStack{
           
            
            Image("home")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            
            VStack(spacing: 20) {
   
                    if showGreetingAndButton {
                        VStack(spacing: 20) {
                            Text("WOOF I was waiting for you!")
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                                .transition(.opacity)
                            
                            
                            NavigationLink(destination: NextView()) {
                                Text("How was your day?")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 200)
                                    .background(Color.yellow)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                
                            }
                            
                            
                            .transition(.opacity) // Fade-in effect
                        }
                    }
                    Image("dog1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                        .offset(x: dogPositionX, y: 20) // Move on the X-axis
                        .scaleEffect(dogScale, anchor: .center) // Prevent downward movement
                        .onAppear {
                            animateDog()
                        }
             
                }
                .padding()
            
        }
    }
        
        
    
        
        
        
        
        func animateDog() {
            
            withAnimation(.linear(duration: 2.0)) {
                dogPositionX = 0
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeOut(duration: 1.0)) {
                    dogScale = 1.5
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        showGreetingAndButton = true
                    }
                }
            }
        }
    }
       
    
        
        
        
        
      
struct NextView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("green") // Replace with actual image name
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                ZStack {
                    // Glass effect with blur
                    Color.white.opacity(0.15)
                        .blur(radius: 15)
                    
                    // Border with subtle light reflection
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.4), lineWidth: 1)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: -5, y: 0) // Left shadow
                .shadow(color: Color.white.opacity(0.4), radius: 5, x: 5, y: 0)  // Right highlight
                .frame(width: 350, height: 450) // Adjust the size as needed
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.2), Color.white.opacity(0.05)]), startPoint: .top, endPoint: .bottom)
                        .blur(radius: 15)
                )
                // VStack inside glass container
                VStack(spacing: 10) {
                    Text("How \nDo You \nFeel Today?")
                        .font(.system(size: 47))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .bold()
                        .padding(.bottom, 20.0)
                        .bold()
                    
                    VStack(spacing: 15) {
                        MoodButton(text: "Happy", destination: HappyView()
                            .padding(.top, 9.0))
                        MoodButton(text: "Anxious", destination: AnxietyView())
                        MoodButton(text: "Sad", destination: UpliftingView())
                    }
                }
                .padding()
            }
            .navigationBarTitle("Mood Tracker", displayMode: .inline)
        }
    }
}
// Mood Button
struct MoodButton<Destination: View>: View {
    var text: String
    var destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            Text(text)
                .padding()
                .frame(width: 120, height: 45)
                .background(Color.white.opacity(0.1)) // Transparent glass effect
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.15), radius: 6, x: -3, y: 0) // Left shadow
                .shadow(color: Color.white.opacity(0.4), radius: 3, x: 3, y: 0)  // Right highlight
                .hoverEffect(.lift)
        }
    }
}



struct AnxietyView: View {
    var body: some View {
        ZStack{
            Image("Aura")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            ZStack {
                // Glass effect with blur
                Color.white.opacity(0.25)
                    .blur(radius: 15)
                
                // Border with subtle light reflection
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.4), lineWidth: 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: -5, y: 0) // Left shadow
            .shadow(color: Color.white.opacity(0.4), radius: 5, x: 5, y: 0)  // Right highlight
            .frame(width: 350, height: 450)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.2), Color.white.opacity(0.05)]), startPoint: .top, endPoint: .bottom)
                    .blur(radius: 15)
            )
                
            
            
               
            VStack {
                Text("Hey, Take a deep breathe...You're safe here. \nLet’s ease your mind together.")
                    .foregroundColor(Color(hue: 0.529, saturation: 0.922, brightness: 0.196))
                    .padding(.bottom, 30.0)
                    .italic()
             NavigationLink(destination: BreathingTechniquesListView()) {
                Text("Breathing Techniques")
                     .font(.subheadline)
                     .foregroundColor(.black)
                     .padding()
                     .frame(width: 200)
                     .background(Color.white.opacity(0.1)) // Transparent glass effect
                     .clipShape(RoundedRectangle(cornerRadius: 15))
                     .foregroundColor(.black)
                     .overlay(
                         RoundedRectangle(cornerRadius: 15)
                             .stroke(Color.white.opacity(0.5), lineWidth: 1)
                     )
                     .shadow(color: Color.black.opacity(0.15), radius: 6, x: -3, y: 0) // Left shadow
                     .shadow(color: Color.white.opacity(0.4), radius: 3, x: 3, y: 0)  // Right highlight
                     .hoverEffect(.lift)
                 
            }
                
                NavigationLink(destination: AnxietyReliefView()) {
                    Text("Talk About It")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 200)
                        .background(Color.white.opacity(0.1)) // Transparent glass effect
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.15), radius: 6, x: -3, y: 0) // Left shadow
                        .shadow(color: Color.white.opacity(0.4), radius: 3, x: 3, y: 0)  // Right highlight
                        .hoverEffect(.lift)
                    
                    // Add more content as needed
                }
                NavigationLink(destination: CoffeePouringView()) {
                    Text("Pour Coffee!!")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 200)
                        .background(Color.white.opacity(0.1)) // Transparent glass effect
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.15), radius: 6, x: -3, y: 0) // Left shadow
                        .shadow(color: Color.white.opacity(0.4), radius: 3, x: 3, y: 0)  // Right highlight
                        .hoverEffect(.lift)
                 }
                }
            
            }
            .navigationTitle("Anxiety Relief")
        }
    }

struct BreathingTechnique: Identifiable {
    let id = UUID()
    let name: String
    let description: String
}

    
    let breathingTechniques = [
        BreathingTechnique(
            name: "Diaphragmatic Breathing",
            description: "1.Take full deep breaths.\nDeep breathing to fully engage the diaphragm."
        ),
        BreathingTechnique(
            name: "4-7-8 Breathing",
            description: "1.Inhale for 4 seconds \n2.hold for 7 seconds \n3.exhale for 8 seconds."
        ),
        BreathingTechnique(
            name: "Box Breathing",
            description: "1.Breathe in for four counts \n2.hold for four counts \n3.exhale for four counts \n4.hold again for four counts.."
        ),
        BreathingTechnique(
            name: "Alternate Nostril Breathing",
            description: "Breathing through one nostril at a time to balance energy.You can practice this by holding one nostril and inahling,exahaling through the other nostril."
        ),
        BreathingTechnique(
            name: " 3-3-3 rule breathing",
            description: "1.Breathe in for three seconds \n2.hold for three seconds \n3.exhale for three seconds.."
        )
    ]

struct BreathingTechniquesListView: View {
    var body: some View {
        List(breathingTechniques) { technique in
            NavigationLink(destination: BreathingTechniqueDetailView(technique: technique)) {
                Text(technique.name)
            }
        }
        .navigationTitle("Breathing Techniques")
    }
}
struct BreathingTechniqueDetailView: View {
    let technique: BreathingTechnique
    var body: some View {
        ZStack {
            Color.cyan.opacity(0.2) // Background
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 20) {
                Text(technique.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(technique.description)
                    .font(.body)
                
                Spacer()
            }
            .padding()
            .navigationTitle(technique.name)
        }
    }
}
struct AnxietyReliefView: View {
    @State private var ventText: String = ""
    @State private var currentPrompt: String = ""
    @State private var showCrumpledPaper: Bool = false
    @State private var crumpleAnimation: Bool = false

    private let prompts = [
        "What are the top three thoughts causing you anxiety today?",
        "Describe a recent situation where you felt anxious. How did you handle it?",
        "Will this event have an effect on you after 5 years?",
       
    ]

    var body: some View {
        ZStack{
            Color.cyan.opacity(0.2) // Subtle cyan background
                .edgesIgnoringSafeArea(.all) // Extends background to full screen
            
            
            VStack(alignment: .leading) {
                Text("A safe space for you to vent, you can always delete this entry from the app as well as your mind ;)")
                Text("Reflective Prompt:")
                    .font(.headline)
                    .padding(.top)
                
                Text(currentPrompt)
                    .font(.subheadline)
                    .padding(.bottom)
                
                TextEditor(text: $ventText)
                    .padding()
                    .border(Color.gray, width: 1)
                    .frame(height: 200)
                    .padding()
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        crumpleAnimation = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        ventText = ""
                        currentPrompt = prompts.randomElement() ?? ""
                        showCrumpledPaper = false
                        crumpleAnimation = false
                    }
                })
                {
                    Text("Delete Note")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                
                Button(action: {
                    ventText = ""
                    currentPrompt = prompts.randomElement() ?? ""
                }) {
                    Text("Get New Prompt")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .onAppear {
                currentPrompt = prompts.randomElement() ?? ""
            }
            .overlay(
                Group {
                    if showCrumpledPaper {
                        Image("paper")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .rotationEffect(.degrees(crumpleAnimation ? 720 : 0))
                            .offset(x: crumpleAnimation ? 300 : 0, y: crumpleAnimation ? -600 : 0)
                            .scaleEffect(crumpleAnimation ? 0.1 : 1.0)
                            .opacity(crumpleAnimation ? 0 : 1)
                            .animation(.easeInOut, value: crumpleAnimation)
                    }
                }
            )
        }
        
        .navigationTitle("Anxiety Relief")
    }
}
class RainSoundManager {
    var rainPlayer: AVAudioPlayer?

    init() {
        prepareRainSound()
    }

    private func prepareRainSound() {
        guard let url = Bundle.main.url(forResource: "rain_sound", withExtension: "mp3") else {
            print("Rain sound file not found!")
            return
        }
        do {
            rainPlayer = try AVAudioPlayer(contentsOf: url)
            rainPlayer?.numberOfLoops = -1 // Loop infinitely
            rainPlayer?.prepareToPlay()
        } catch {
            print("Error loading rain sound: \(error.localizedDescription)")
        }
    }

    func toggleRainSound(isRaining: inout Bool) {
        if isRaining {
            rainPlayer?.stop()
        } else {
            rainPlayer?.play()
        }
        isRaining.toggle()
    }
}

struct CoffeePouringView: View {
    @State private var isPouring: Bool = false
    @State private var fillAmount: CGFloat = 0.0
    @State private var isRaining: Bool = false
    private var rainSoundManager = RainSoundManager()

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("Grab your favourite book and indulge in some good coffee while listening to the rain outside.")
                    .foregroundColor(Color(hue: 0.06, saturation: 0.882, brightness: 0.377))
                    .italic()
                    .padding(.top, 40)
                
                Image("coffee")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }
            
            if isPouring {
                // Coffee cup with filling animation
                VStack {
                    Spacer()
                    ZStack {
                        Image("cup2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 420, height: 500)
                        
                        // Coffee fill animation
                        Rectangle()
                            .fill(Color(red: 101 / 255, green: 67 / 255, blue: 33 / 255))
                            .frame(width: 200, height: 300 * fillAmount)
                            .mask(
                                Image("cupmask")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 400, height: 500)
                            )
                            .offset(y: 70 - (70 * fillAmount)) // Adjust offset to fill from bottom
                    }
                    Spacer()
                }
                .transition(.opacity) // Fade in transition
            }
            
            
            VStack{
                Spacer() // Pushes everything to the bottom
                
                HStack(spacing: 20) { // Adds space between buttons
                    Button(action: {
                        withAnimation {
                            isPouring.toggle()
                            if isPouring {
                                startPouring()
                            } else {
                                resetPouring()
                            }
                        }
                    }) {
                        Text(isPouring ? "Stop" : "Pour")
                            .font(.title3)
                            .padding()
                            .background(Color(red: 101 / 255, green: 67 / 255, blue: 33 / 255))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .opacity(0.75)
                    }
                    
                    Button(action: {
                        rainSoundManager.toggleRainSound(isRaining: &isRaining)
                    }) {
                        Text(isRaining ? "Stop Rain" : "Make it Rain")
                            .font(.title3)
                            .padding()
                            .background(Color(red: 101 / 255, green: 67 / 255, blue: 33 / 255))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .opacity(0.75)
                    }
                }
                .padding(.bottom, 60) // Adjust distance above Home button
            }
        }
    }

    private func startPouring() {
        withAnimation(.easeInOut(duration: 2.0)) {
            fillAmount = 1.0
        }
    }

    private func resetPouring() {
        withAnimation(.easeInOut(duration: 2.0)) {
            fillAmount = 0.0
        }
    }
}
struct HappyView: View {
    var body: some View {
        ZStack {
            Image("happy")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            ZStack {
                // Glass effect with blur
                Color.white.opacity(0.09)
                    .blur(radius: 15)
                
                // Border with subtle light reflection
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.4), lineWidth: 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: -5, y: 0) // Left shadow
            .shadow(color: Color.white.opacity(0.4), radius: 5, x: 5, y: 0)  // Right highlight
            .frame(width: 350, height: 450)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.2), Color.white.opacity(0.05)]), startPoint: .top, endPoint: .bottom)
                    .blur(radius: 15)
            )
                
            
            VStack {
                
                Text(" Savor this moment, \n for joy is found in the present" )
                    .padding(.bottom, 30.0)
                    .italic()
                
                NavigationLink(destination: JournalEntryView()) {
                    Text("What made you happy today?")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 200)
                        .background(Color.white.opacity(0.1)) // Transparent glass effect
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.15), radius: 6, x: -3, y: 0) // Left shadow
                        .shadow(color: Color.white.opacity(0.4), radius: 3, x: 3, y: 0)  // Right highlight
                        .hoverEffect(.lift)
                }
                NavigationLink(destination: CookbookView()) {
                    Text("Cookbook")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 200)
                        .background(Color.white.opacity(0.1)) // Transparent glass effect
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.15), radius: 6, x: -3, y: 0) // Left shadow
                        .shadow(color: Color.white.opacity(0.4), radius: 3, x: 3, y: 0)  // Right highlight
                        .hoverEffect(.lift)
                }
            }
        }
        .navigationTitle("Dopamine Release") // Keep navigation title
    }
}
struct JournalEntry: Identifiable, Codable {
    let id: UUID
    let text: String

    init(text: String, id: UUID = UUID()) {
        self.id = id  // ✅ Assigns UUID only once
        self.text = text
    }
}
struct JournalEntryView: View {
    @State private var entryText: String = ""
    @State private var savedEntries: [JournalEntry] = []
    @State private var selectedEntry: JournalEntry? // Now uses Identifiable struct

    var body: some View {
        ZStack {
            Image("paper1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 15) {
                headerText
                entryTextEditor
                saveButton
                entryList
            }
            .padding()
            .onAppear(perform: loadEntries)
        }
        .navigationTitle("Journal Entry")
        .sheet(item: $selectedEntry) { entry in
            JournalDetailView(entry: entry)
        }
    }

    private var headerText: some View {
        VStack {
            Text("What made you happy today?")
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.leading, 50.0)
            
            
            
            Text("(Document and save your happy memories.)")
                .font(.headline)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(.leading, 60.0)
                .italic()
        }
        .padding(.bottom, 10)
    }
        
    

    private var entryTextEditor: some View {
        ZStack(alignment: .topLeading) {
            if entryText.isEmpty {
                Text("Start writing here...")
                    .foregroundColor(.gray.opacity(0.7))
                    .padding(.leading, 30)
                    .padding(.top, 8)
            }
            TextEditor(text: $entryText)
                .scrollContentBackground(.hidden)
                .frame(height: 150)
                .padding(.leading, 30.0)
                .background(Color.white.opacity(0.7))
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }
        .padding(.horizontal, 20)
    }

    private var saveButton: some View {
        Button(action: saveEntry) {
            Text("Save Entry")
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .frame(width: 220)
                .background(Color.pink.opacity(0.7))
                .cornerRadius(10)
                .shadow(radius: 4)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
    }

    private var entryList: some View {
        VStack(alignment: .leading) {
            Text("Previous Entries")
                .font(.headline)
                .padding(.leading, 50.0)

            if savedEntries.isEmpty {
                Text("No entries yet.")
                    .foregroundColor(.gray)
                    .padding(.leading, 30.0)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(savedEntries) { entry in
                            Button(action: { selectedEntry = entry }) {
                                entryRow(entry: entry)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.leading, 30.0)
                }
                .frame(height: 200)
            }
        }
        .padding(.top, 10)
    }

    private func entryRow(entry: JournalEntry) -> some View {
        HStack {
            Text(entry.text.prefix(30) + (entry.text.count > 30 ? "..." : "")) // Preview
                .font(.body)
                .foregroundColor(.black)
                .padding(10)
                .background(Color.white.opacity(0.6))
                .cornerRadius(10)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: { deleteEntry(entry) }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .padding(.trailing, 10)
        }
    }

    private func saveEntry() {
        guard !entryText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let newEntry = JournalEntry(text: entryText)
        savedEntries.append(newEntry)
        saveToUserDefaults()
        entryText = ""
    }

    private func deleteEntry(_ entry: JournalEntry) {
        savedEntries.removeAll { $0.id == entry.id }
        saveToUserDefaults()
    }

    private func loadEntries() {
        if let data = UserDefaults.standard.data(forKey: "journalEntries"),
           let decodedEntries = try? JSONDecoder().decode([JournalEntry].self, from: data) {
            savedEntries = decodedEntries
        }
    }

    private func saveToUserDefaults() {
        if let encodedData = try? JSONEncoder().encode(savedEntries) {
            UserDefaults.standard.set(encodedData, forKey: "journalEntries")
        }
    }
}

// MARK: - Journal Detail View
struct JournalDetailView: View {
    let entry: JournalEntry
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Text("Journal Entry")
                .font(.title)
                .bold()

            ScrollView {
                Text(entry.text)
                    .font(.body)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .shadow(radius: 2)
            }
            .frame(height: 300)

            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.headline)
            .padding()
            .frame(width: 150)
            .background(Color.red.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

// MARK: - Custom Modifiers
extension View {
    func journalHeaderStyle() -> some View {
        self
            .font(.subheadline)
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.15), radius: 6, x: -3, y: 0)
            .shadow(color: Color.white.opacity(0.4), radius: 3, x: 3, y: 0)
            .hoverEffect(.lift)
    }
}
struct CookbookView: View {
    let recipes: [String: [(name: String, imageName: String, recipeText: String)]] = [
        "Breakfast": [
            ("Pancakes", "pancakes", "Ingredients:\n- 1 cup flour\n- 1 egg\n- 1 cup milk\n- 1 tbsp sugar\n- 1 tsp baking powder\n\nInstructions:\n1. Mix all ingredients.\n2. Cook on a non-stick pan.\n3. Serve with syrup."),
            
            ("Almond-Buckwheat Granola with Yogurt and Berries", "Almond-Buckwheat Granola with Yogurt and Berries", "Ingredients:\n- 1 cup oil\n- 1/2 cup maple syrup\n- 1/4 tsp salt\n- 2 cups groats\n- 1 tsp cinnamon\n- 1/2 cup almonds\n\nInstructions:\n1. Preheat oven to 300°F. Line a baking sheet with parchment paper. Whisk together oil, maple syrup, and salt in a bowl.\n2. Toast groats in a hot cast-iron skillet for 2–4 minutes until golden. Toss with maple syrup mixture, cinnamon, and almonds. Spread on baking sheet and bake for 15–20 minutes, stirring halfway through.\n3. Let cool, then serve with yogurt, berries, and extra maple syrup."),
            
            ("Sausage And Egg Muffins","sausage_and_egg_muffins", "Ingredients:\n- 2 tsp oil\n- 1 onion\n- 1 lb sausage\n- 2 tsp olive oil\n- 4 eggs\n- 4 English muffins\n- 4 slices Cheddar\n- 1/2 cup parsley\n- 1/2 cup pepper slices\n\nInstructions:\n1. Heat 2 tsp oil in a large cast-iron skillet on medium. Add onion and cook for 3 minutes. Shape sausage into four 1/4-inch-thick patties, add to skillet with onion, and increase heat to medium-high. Cook until onion is tender, 2–3 minutes. Cook patties until browned, 2–3 minutes, then flip.\n2. Separate onion into rings, place on top of patties, then top with Cheddar. Continue cooking until sausage is cooked through, 2–3 minutes more.\n3. Heat 2 tsp olive oil in a nonstick skillet and cook eggs to desired doneness, 4–5 minutes for runny yolks. Top muffins with sausage, eggs, pepper slices, and parsley."),
            
            ( "Avocado Toast","avocado_toast", "Ingredients:\n- 1 avocado\n- 1 tsp lemon juice\n- 1/4 tsp salt\n- 1/4 tsp pepper\n- 2 slices toast\n- 2 eggs\n- 2 radishes, sliced\n- 1 tbsp chives, chopped\n- 1 tsp sesame seeds\n\nInstructions:\n1. In a medium bowl, smash avocado with lemon juice, salt, and pepper.\n2. Spread on toast and top with eggs and radishes. Sprinkle with chives and sesame seeds.")
            
        ],
        
        "Lunch": [
            ("Veggie Wrap","veggie wrap", "Ingredients:\n- 1 whole wheat or spinach tortilla\n- 1/2 avocado, sliced\n- 1/2 cucumber, thinly sliced\n- 1/2 bell pepper, sliced\n- 1 small carrot, shredded\n- 2 tbsp hummus or cream cheese\n- A handful of spinach or mixed greens\n- Salt & pepper to taste\n\nInstructions:\n1. Spread hummus or cream cheese evenly across the tortilla.\n2. Layer avocado, cucumber, bell pepper, carrot, and spinach.\n3. Season with salt and pepper, then roll up the tortilla tightly.\n4. Slice in half and serve immediately."),
            
            ("Egg Salad Sandwich","egg_salad_sandwich", "Ingredients:\n- 2 hard-boiled eggs, chopped\n- 2 tbsp mayonnaise\n- 1 tsp mustard\n- 1 tbsp fresh parsley, chopped\n- Salt & pepper to taste\n- 2 slices of bread (whole grain or your choice)\n- Optional: Lettuce or tomato slices for extra crunch\n\nInstructions:\n1. In a bowl, combine chopped eggs, mayonnaise, mustard, parsley, salt, and pepper.\n2. Mix until everything is evenly coated.\n3. Spread the egg salad on one slice of bread.\n4. Top with lettuce or tomato if desired, then place the second slice of bread on top.\n5. Serve immediately or wrap for later."),
            
            ("Spinach and Feta Quesadilla","spinach_feta_quesadilla", "Ingredients:\n- 1 large flour tortilla\n- 1/2 cup fresh spinach, chopped\n- 1/4 cup crumbled feta cheese\n- 1/2 cup shredded mozzarella cheese\n- 1 tbsp olive oil\n- Salt & pepper to taste\n\nInstructions:\n1. Heat a skillet over medium heat and add a bit of olive oil.\n2. Place the tortilla in the skillet and sprinkle mozzarella, feta, and spinach evenly over half of the tortilla.\n3. Fold the tortilla in half, pressing gently.\n4. Cook for 2-3 minutes on each side until golden and the cheese has melted.\n5. Cut into wedges and serve with sour cream or salsa.")
        ],
        
        "Dinner": [
            ("Garlic Butter Chicken with Veggies","garlic_butter_chicken", "Ingredients:\n- 2 boneless, skinless chicken breasts\n- 2 tbsp butter\n- 3 cloves garlic, minced\n- 1 tsp dried oregano\n- 1 tsp dried thyme\n- 1 cup broccoli florets\n- 1 cup cherry tomatoes, halved\n- Salt & pepper to taste\n\nInstructions:\n1. Season chicken breasts with salt, pepper, oregano, and thyme.\n2. Melt 1 tbsp butter in a pan over medium heat, then cook chicken for about 5 minutes on each side until golden and fully cooked. Remove and set aside.\n3. In the same pan, add the remaining butter and garlic. Sauté for 30 seconds.\n4. Add broccoli and cherry tomatoes, cook for 4–5 minutes until tender.\n5. Return chicken to the pan, coat in garlic butter sauce, and serve hot."),
            
            ("Quick Veggie Stir-Fry with Rice","veggie_stir_fry", "Ingredients:\n- 1 cup cooked rice\n- 1 tbsp soy sauce\n- 1 tbsp sesame oil (or olive oil)\n- 1 carrot, sliced\n- 1 bell pepper, sliced\n- 1/2 cup snap peas or broccoli\n- 1 clove garlic, minced\n- 1/2 tsp ginger, minced\n\nInstructions:\n1. Heat oil in a pan over medium heat. Add garlic and ginger, sauté for 30 seconds.\n2. Add carrots, bell pepper, and snap peas. Stir-fry for 3–4 minutes.\n3. Pour in soy sauce and mix well.\n4. Add cooked rice, stir everything together, and cook for another 2 minutes. Serve hot."),
            
            ("One-Pot Creamy Pasta","creamy_pasta", "Ingredients:\n- 200g pasta (penne or fusilli)\n- 2 cups milk\n- 1 cup water\n- 2 cloves garlic, minced\n- 1 cup shredded cheese (cheddar or parmesan)\n- 1/2 tsp salt\n- 1/2 tsp black pepper\n- 1 tbsp butter\n- Optional: 1 cup spinach or mushrooms\n\nInstructions:\n1. In a pot, add pasta, milk, water, garlic, salt, and pepper. Bring to a simmer.\n2. Cook, stirring occasionally, until the pasta is soft and the liquid is mostly absorbed (about 12–15 minutes).\n3. Stir in butter and cheese until creamy.\n4. (Optional) Add spinach or mushrooms in the last few minutes of cooking. Serve warm."),
            
            ("Honey Garlic Shrimp with Rice","honey_garlic_shrimp", "Ingredients:\n- 200g shrimp (peeled & deveined)\n- 2 tbsp soy sauce\n- 1 tbsp honey\n- 2 cloves garlic, minced\n- 1 tbsp olive oil\n- 1 tsp sesame seeds (optional)\n- 1 cup cooked rice\n- 2 tbsp chopped green onions\n\nInstructions:\n1. In a bowl, mix soy sauce, honey, and minced garlic. Add shrimp and let marinate for 10 minutes.\n2. Heat olive oil in a pan over medium heat. Add shrimp and cook for 2–3 minutes per side until pink and slightly caramelized.\n3. Pour in the remaining marinade and let it cook for another minute until slightly thickened.\n4. Serve shrimp over cooked rice, garnished with green onions and sesame seeds.")
        ]
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Gradient Background
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.pink.opacity(0.2)]),
                               startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack {
                    List {
                        Section {
                            Text("When you’re in a positive mood, the process of cooking can trigger the release of dopamine, the 'feel-good' neurotransmitter, which enhances your mood and reduces stress.")
                                .font(.body)
                                .padding(.vertical, 8)
                                .listRowBackground(Color.clear) // Transparent row background
                        }
                        
                        ForEach(recipes.keys.sorted(), id: \.self) { category in
                            Section(header: Text(category).font(.headline)) {
                                ForEach(recipes[category]!, id: \.name) { recipe in
                                    NavigationLink(destination: RecipeDetailView(recipeName: recipe.name, recipeData: recipe)) {
                                        Text(recipe.name)
                                    }
                                }
                            }
                            .listRowBackground(Color.clear) // Transparent section background
                        }
                    }
                    .background(Color.clear) // Remove default List background
                    .scrollContentBackground(.hidden) // iOS 16+ method
                }
            }
            .navigationBarTitle("Cookbook", displayMode: .inline)
        }
    }
}
    
    struct RecipeDetailView: View {
        var recipeName: String
        var recipeData: (name: String, imageName: String, recipeText: String)
        
        var body: some View {
            ScrollView(.vertical, showsIndicators: true){
                VStack(alignment: .leading, spacing: 10) {
                    
                    Image(recipeData.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .cornerRadius(15)
                        .padding()
                    
                    
                    
                    // Recipe Instructions
                    Text(recipeData.recipeText)
                        .font(.body)
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(hue: 0.886, saturation: 0.739, brightness: 0.918)/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
            }
            .navigationTitle(recipeName)
        }
    }
    
    struct Recipe: Identifiable {
        let id = UUID()
        let name: String
        let details: String
    }
    
    struct UpliftingView: View {
        var body: some View {
            ZStack{
                Image("sad")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                ZStack{
                    
                    // Glass effect with blur
                    Color.white.opacity(0.07)
                        .blur(radius: 25)
                    
                    // Border with subtle light reflection
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.4), lineWidth: 1)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: -5, y: 0) // Left shadow
                .shadow(color: Color.white.opacity(0.4), radius: 5, x: 5, y: 0)  // Right highlight
                .frame(width: 350, height: 450)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.2), Color.white.opacity(0.05)]), startPoint: .top, endPoint: .bottom)
                        .blur(radius: 15)
                )
                
                VStack{
                    Text("Hey there, tough day? Let’s do something  soothing together")
                        .foregroundColor(Color(hue: 0.529, saturation: 0.922, brightness: 0.196))
                        .padding(.bottom, 30.0)
                        .italic()
                    NavigationLink(destination: SongListView()){
                        Text("Jam Session")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 200)
                            .background(Color.white.opacity(0.1)) // Transparent glass effect
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.15), radius: 6, x: -3, y: 0) // Left shadow
                            .shadow(color: Color.white.opacity(0.4), radius: 3, x: 3, y: 0)  // Right highlight
                            .hoverEffect(.lift)
                    }
                    NavigationLink(destination: FortuneCookieView()){
                        Text("Fortune Cookie")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 200)
                            .background(Color.white.opacity(0.1)) // Transparent glass effect
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.15), radius: 6, x: -3, y: 0) // Left shadow
                            .shadow(color: Color.white.opacity(0.4), radius: 3, x: 3, y: 0)  // Right highlight
                            .hoverEffect(.lift)
                    }
                    NavigationLink(destination: ColoringBookView()){
                        Text("Doodle Your Feelings")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 200)
                            .background(Color.white.opacity(0.1)) // Transparent glass effect
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.15), radius: 6, x: -3, y: 0) // Left shadow
                            .shadow(color: Color.white.opacity(0.4), radius: 3, x: 3, y: 0)  // Right highlight
                            .hoverEffect(.lift)
                    }
                }
            }
            .navigationTitle("sadness relief")
        }
        
    }
    
    
    
    struct SongListView: View {
        let songs: [String: [String]] = [
            "🎤 Pop": [
                "Happy – Pharrell Williams",
                "Can't Stop the Feeling – Justin Timberlake",
                "Shake It Off – Taylor Swift",
                "Uptown Funk – Mark Ronson",
                "Feather - Sabrina Carpenter",
                "Late Night Talking - Harry Styles ",
                "Espresso - Sabrina Carpenter"
            ],
            "🎵 Rock": [
                "Don't Stop Me Now – Queen",
                "Eye of the Tiger – Survivor",
                "Livin' on a Prayer – Bon Jovi",
                "I Love Rock 'n' Roll – Joan Jett & The Blackhearts",
                "Oh Pretty Woman - Roy Obrison",
                "Centuries - Fall Out Boy"
            ],
            "🎸 Indie": [
                "Electric Feel – MGMT",
                "Dog Days Are Over – Florence + The Machine",
                "Take a Walk – Passion Pit",
                "On Top of the World – Imagine Dragons",
                "Kingston - Faye Webster",
                "Heart To Heart - Mac DeMarco"
            ]
        ]
        
        var body: some View {
            NavigationView {
                ZStack{ LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.pink.opacity(0.2)]),
                                       startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                    VStack {
                        Text("Upbeat music can uplift your mood and boost dopamine.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        List {
                            ForEach(songs.keys.sorted(), id: \.self) { genre in
                                Section(header: Text(genre).font(.headline)) {
                                    ForEach(songs[genre]!, id: \.self) { song in
                                        Text(song)
                                    }
                                }
                            }
                        }
                    }
                    .navigationBarTitle("Dopamine-Boosting Songs", displayMode: .inline)
                }
            }
        }
    }
    
    struct FortuneCookieView: View {
        @State private var showFortune: Bool = false
        @State private var selectedFortune: String = ""
        
        let fortunes = [
            "You are stronger than you think.",
            "A beautiful surprise is coming your way.",
            "Everything will work out for you.",
            "Happiness is within you, not outside.",
            "You are loved more than you know.",
            "Do it because it makes you happy.",
            "Your kindness will return to you in wonderful ways.",
            "Your closer to success than you imagine.",
            "Now is the time to start something new.",
            "You will not miss out on what's meant for you.",
            "Comparison is the thief of joy.",
            "Great days await you.",
            "Take that vacation,Eat that last slice of cake."
        ]
        
        var body: some View {
            ZStack {
                Image("fortune")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    Text("Unveil your future...")
                        .foregroundColor(Color(hue: 0.06, saturation: 0.882, brightness: 0.377))
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        selectedFortune = fortunes.randomElement() ?? "Stay positive!"
                        showFortune = true
                    }) {
                        Image("helo") // Make sure you have an image named "fortune_cookie"
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .shadow(radius: 5)
                    }
                }
                
                
                // Custom pop-up modal
                if showFortune {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all) // Background dim effect
                    
                    VStack {
                        Image("bg2") // Add a cute fortune paper background in assets
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 150)
                            .overlay(
                                Text(selectedFortune)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(hue: 0.06, saturation: 0.882, brightness: 0.377))
                                    .padding(),
                                alignment: .center
                            )
                        
                        Button(action: {
                            showFortune = false
                        }) {
                            Text("Close")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: 150)
                                .background(Color.white)
                                .opacity(0.70)
                                .cornerRadius(12)
                        }
                        .padding(.top, 10)
                        
                    }
                    .frame(width: 320, height: 220)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .transition(.scale)
                }
            }
            .animation(.easeInOut, value: showFortune)
        }
    }

// 🎨 ViewModel for Canvas
class CanvasViewModel: ObservableObject {
    @Published var canvasView = PKCanvasView()
}

// Main Coloring Book View
struct ColoringBookView: View {
    @StateObject private var canvasVM = CanvasViewModel()
    @State private var selectedImage: String = "coloring1"
    let coloringImages = ["coloring1", "coloring2", "coloring3"]
    
    // ToolPicker
    @State private var toolPicker: PKToolPicker? = PKToolPicker()

    var body: some View {
        VStack {
            // Image Selection Bar
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(coloringImages, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .border(selectedImage == image ? Color.blue : Color.clear, width: 3)
                            .onTapGesture {
                                selectedImage = image
                                canvasVM.canvasView.drawing = PKDrawing()
                            }
                    }
                }
                .padding(.horizontal)
            }

            // Drawing Area with Coloring Image in Background
            ZStack {
                Image(selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                PencilKitCanvas(canvasView: $canvasVM.canvasView, toolPicker: toolPicker)
                    .background(Color.clear)
            }
            .onAppear {
                if let toolPicker = toolPicker {
                    toolPicker.setVisible(true, forFirstResponder: canvasVM.canvasView)
                    toolPicker.addObserver(canvasVM.canvasView)
                    DispatchQueue.main.async {
                        canvasVM.canvasView.becomeFirstResponder()
                    }
                }
            }
            .onDisappear {
                if let toolPicker = toolPicker {
                    toolPicker.setVisible(false, forFirstResponder: canvasVM.canvasView)
                    toolPicker.removeObserver(canvasVM.canvasView)
                }
            }

            // Save & Clear Buttons
            HStack {
                Button("Clear") {
                    canvasVM.canvasView.drawing = PKDrawing()
                }
                .padding(.bottom, 30.0)
                .background(Color.red.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Save") {
                    saveDrawing()
                }
                .padding(.bottom, 30.0)
                .background(Color.green.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.top, 10)
        }
        .navigationTitle("Coloring Book")
    }

    // Function to Save Drawing
    private func saveDrawing() {
        let image = canvasVM.canvasView.drawing.image(from: canvasVM.canvasView.bounds, scale: UIScreen.main.scale)
        if let imageData = image.pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent("drawing_\(UUID().uuidString).png")
            try? imageData.write(to: filename)
            print("Drawing saved at: \(filename)")
        }
    }
}

// SwiftUI Wrapper for PKCanvasView
struct PencilKitCanvas: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    var toolPicker: PKToolPicker?

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.isOpaque = false
        canvasView.backgroundColor = .clear
        canvasView.drawingPolicy = .anyInput

        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) { }
}

// Get path to Documents directory
func getDocumentsDirectory() -> URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}

    #Preview {
        ContentView()
    }
    

    
    
    

