//
//  CameraView.swift
//  Umami
//
//  Created on 2025-01-05.
//

import SwiftUI

struct CameraView: View {
    @State private var showingImagePicker = false
    @State private var isRecognizing = false

    var body: some View {
        ZStack {
            // Camera placeholder background
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                // Top bar
                HStack {
                    Button(action: {}) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }

                    Spacer()

                    Button(action: {}) {
                        Image(systemName: "bolt.slash.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }
                }

                Spacer()

                // Camera frame guide
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.5), lineWidth: 2)
                    .frame(width: 280, height: 400)
                    .overlay(
                        VStack {
                            Image(systemName: "camera.viewfinder")
                                .font(.system(size: 80))
                                .foregroundColor(.white.opacity(0.3))

                            Text("Position bottle in frame")
                                .font(AppTheme.Typography.headline)
                                .foregroundColor(.white)
                                .padding(.top)

                            Text("Camera will auto-detect sake bottle")
                                .font(AppTheme.Typography.caption)
                                .foregroundColor(.white.opacity(0.7))
                                .padding(.top, 4)
                        }
                    )

                Spacer()

                // Bottom controls
                HStack(spacing: 60) {
                    // Gallery button
                    Button(action: { showingImagePicker = true }) {
                        Image(systemName: "photo.on.rectangle")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }

                    // Capture button
                    Button(action: {
                        isRecognizing = true
                        // Simulate recognition
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isRecognizing = false
                        }
                    }) {
                        ZStack {
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                                .frame(width: 80, height: 80)

                            Circle()
                                .fill(Color.white)
                                .frame(width: 68, height: 68)
                        }
                    }
                    .disabled(isRecognizing)

                    // Switch camera button
                    Button(action: {}) {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 100)
            }

            // Recognition overlay
            if isRecognizing {
                ZStack {
                    Color.black.opacity(0.7)
                        .edgesIgnoringSafeArea(.all)

                    VStack(spacing: 20) {
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(.white)

                        Text("Recognizing sake...")
                            .font(AppTheme.Typography.headline)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            Text("Image Picker Placeholder")
        }
    }
}

#Preview {
    CameraView()
}
