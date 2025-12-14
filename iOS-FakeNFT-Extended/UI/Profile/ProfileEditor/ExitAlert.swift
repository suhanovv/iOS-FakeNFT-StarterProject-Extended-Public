//
//  ExitAlert.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 10/12/25.
//

import SwiftUI

struct ExitAlert: View {
    @Binding var isPresented: Bool
    var onExit: () -> Void
    
    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture { isPresented = false }
                alertBox
            }
            .transition(.opacity)
            .animation(.easeInOut, value: isPresented)
        }
    }
    
    private var alertBox: some View {
        VStack(spacing: 0) {
            VStack {
                Text(Constants.Titles.exitAlert)
                    .font(Font(UIFont.bodyBold))
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 16)
            .frame(height: 76)
            
            Divider()
            
            HStack(spacing: 0) {
                Button {
                    isPresented = false
                } label: {
                    Text(Constants.Buttons.stayConfirmation)
                        .font(Font(UIFont.bodyRegular))
                        .foregroundColor(.ypBlueUniversal)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 11)
                }
                
                Divider()
                
                Button {
                    isPresented = false
                    onExit()
                } label: {
                    Text(Constants.Buttons.exitConfirmation)
                        .font(Font(UIFont.bodyBold))
                        .foregroundColor(.ypBlueUniversal)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 11)
                }
            }
            .frame(height: 42.5)
        }
        .frame(width: 270)
        .background(Color(.ypLightGray))
        .cornerRadius(14)
        .shadow(radius: 22)
    }
}

#Preview {
    ExitAlert(isPresented: .constant(true), onExit: {})
}

