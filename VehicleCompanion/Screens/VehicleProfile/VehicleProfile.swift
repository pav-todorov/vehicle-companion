//
//  AddCarProfile.swift
//  VehicleCompanion
//

import SwiftUI
import SwiftData

enum Field: CaseIterable, Identifiable {
    case name, make, model, vin
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .name: return "Name"
        case .make: return "Make"
        case .model: return "Model"
        case .vin: return "VIN"
        }
    }
}

struct VehicleProfile: View {
    @SwiftUI.Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    
    @State var viewModel: VehicleProfileViewModel
    
    init(vehicle: Vehicle = .empty(), repository: VehicleRepository) {
        viewModel = VehicleProfileViewModel(repository: repository, vehicle: vehicle)
    }
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    EditableCircularProfileImage(
                        viewModel: viewModel.profileImageViewModel
                    )
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            
            
            Section {
                ForEach(Field.allCases) { field in
                    textField(field: field)
                }
            }
            
            Section {
                Picker("Year", selection: $viewModel.vehicle.year) {
                    ForEach((Date.yearOfFirstCar...Date.currentYear).reversed(), id: \.self) {
                        Text(String($0)).tag($0)
                    }
                }
                .pickerStyle(.menu)
                
                
                Picker("Fuel Type", selection: $viewModel.vehicle.fuelType) {
                    ForEach(FuelType.allCases) { fuelType in
                        Text(fuelType.name).tag(fuelType)
                    }
                }
                
            } footer: {
                if !viewModel.missingFields.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Please, fill in all required fields:")
                        ForEach(viewModel.missingFields, id: \.self) { field in
                            Text("• \(field)")
                        }
                    }
                    .foregroundStyle(.red)
                }
            }
        }
        .animation(.easeInOut, value: viewModel.missingFields)
        .safeAreaInset(edge: .bottom) {
            Button("Save", action: {
                viewModel.userTappedSave()
                dismiss()
            })
            .buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal, 16)
            
        }
        .navigationTitle("Car Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
    
    private func textField(field: Field) -> some View {
        var text: Binding<String>
        
        switch field {
        case .name: text = $viewModel.vehicle.name
        case .make: text = $viewModel.vehicle.make
        case .model: text = $viewModel.vehicle.model
        case .vin: text = $viewModel.vehicle.vin
        }
        
        return TextField(
            field.title,
            text: text,
            prompt: Text(field.title)
                .foregroundStyle(
                    viewModel.missingFields.contains(field.title)
                    ? Color.errorFont
                    : Color.placeholderFont
                )
        )
        .focused($focusedField, equals: field)
        .submitLabel(.next)
        .onSubmit {
            focusedField = field.next()
        }
        .onChange(of: text.wrappedValue, { _, _ in
            viewModel.clearErrorWarning(for: field.title)
        })
    }
}

#Preview {
    VehicleProfile(
        vehicle: .mocks().first!,
        repository: DefaultMockVehicleRepository()
    )
}
