//
//  ARMainView.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 6/19/24.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

 struct ARViewContainer: UIViewRepresentable {
    @Binding var selectedAudio: Audio?
    @Binding var showAudioView: Bool
    @Binding var showAudioButton: Bool
    @Binding var currentEntity: ModelEntity?

   // var coordinator: Coordinator?




    public func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        context.coordinator.setup(arView: arView)
        return arView
    }

    public func updateUIView(_ uiView: ARView, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(selectedAudio: $selectedAudio, showAudioView: $showAudioView, showAudioButton: $showAudioButton, currentEntity: $currentEntity)
    }

    public class Coordinator: NSObject, ARSessionDelegate {
        @Binding var selectedAudio: Audio?
        @Binding var showAudioView: Bool
        @Binding var showAudioButton: Bool
        @Binding var currentEntity: ModelEntity?

        var cancellables = Set<AnyCancellable>()


        var arView: ARView?
        var objectNames = ["Hotsauce", "toy_car", "gramophone"]
        var addedObjects = Set<String>()
        var planeAnchor: ARAnchor?


        init(selectedAudio: Binding<Audio?>, showAudioView: Binding<Bool>, showAudioButton: Binding<Bool>, currentEntity: Binding<ModelEntity?>) {
           _selectedAudio = selectedAudio
           _showAudioView = showAudioView
           _showAudioButton = showAudioButton
            _currentEntity = currentEntity
       }

        func setup(arView: ARView) {
            self.arView = arView
            arView.session.delegate = self
            // Enable horizontal plane detection
            let configuration = ARWorldTrackingConfiguration()
            configuration.planeDetection = [.horizontal]
            arView.session.run(configuration)
            //
         //   addRandomObjects()

        }

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
                    for anchor in anchors {
                        if let planeAnchor = anchor as? ARPlaneAnchor {
                            self.planeAnchor = planeAnchor
                            addRandomObjects(to: planeAnchor)
                        }
                    }
                }

        func addRandomObjects(to planeAnchor: ARPlaneAnchor) {
            guard let arView = arView else { return }
            
            for objectName in objectNames {
                            // Check object
                if addedObjects.contains(objectName) {
                    continue
                }
                           let objectEntity = try! Entity.loadModel(named: objectName)
                           objectEntity.name = objectName
                           objectEntity.generateCollisionShapes(recursive: true)

                           // Generate random positions within the detected plane bounds
                           let xPos = Float.random(in: -1.5...0.5)
                           let zPos = Float.random(in: -2.0...1.0)

                           let position = SIMD3<Float>(x: xPos, y: 0, z: zPos)

                           // Anchor to the detected plane
                          let anchorEntity = AnchorEntity(anchor: planeAnchor)
                           objectEntity.position = position
                           anchorEntity.addChild(objectEntity)
                           arView.scene.addAnchor(anchorEntity)

                addedObjects.insert(objectName)

                           arView.installGestures([.all], for: objectEntity).forEach { gesture in
                               gesture.addTarget(self, action: #selector(handleTapGesture))
                           }
                       }
//            for objectName in objectNames {
//                let objectEntity = try! Entity.loadModel(named: objectName)
//                objectEntity.name = objectName
//                objectEntity.generateCollisionShapes(recursive: true)
//
//                // Generate random positions
////                let xPos = Float.random(in: -1.5...1.5)
////                let yPos = Float.random(in: -0.5...0.5)
////                let zPos = Float.random(in: -2.0...1.0)
//
//                // New
//                let xPos = Float.random(in: -3.0...3.0)  // Adjust the range for more distance
//                let yPos = Float.random(in: -2.0...0.0)  // Lower the y-position
//                let zPos = Float.random(in: -4.0...1.0) // Place further away on the z-axis
//
//
//                let position = SIMD3<Float>(x: xPos, y: yPos, z: zPos)
//
//                let anchorEntity = AnchorEntity(world: position)
//                anchorEntity.addChild(objectEntity)
//                arView.scene.addAnchor(anchorEntity)
//
//
//                arView.installGestures([.all], for: objectEntity).forEach { gesture in
//                    gesture.addTarget(self, action: #selector(handleTapGesture))
//                }
//            } // for object
        }

        @objc func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
            guard let arView = arView else { return }
            let tapLocation = recognizer.location(in: arView)
            if let entity = arView.entity(at: tapLocation) as? ModelEntity {
                let entityName = entity.name
                didTapObject(entityName, entity: entity)
            }
        }

        func didTapObject(_ entityName: String, entity: ModelEntity) {
            if let audio = getAudioForEntity(name: entityName) {
                selectedAudio = audio
                showAudioButton = true
                currentEntity = entity
            }
              //  entity.removeFromParent()

        }

        func getAudioForEntity(name: String) -> Audio? {
            // Add your logic to get the corresponding Audio object based on entity name
            switch name {
                case "Hotsauce":
                    return Audio(bookTitle: "Lorenzo the Beast", englishAudioFile: "Audio1", spanishAudioFile: "Audio1")
                case "toy_car":
                    return Audio(bookTitle: "Beast of Dreams", englishAudioFile: "Audio2", spanishAudioFile: "Audio2")
                case "gramophone":
                    return Audio(bookTitle: "Beast of the Glades", englishAudioFile: "Audio3", spanishAudioFile: "Audio3")
                default:
                    return nil
            }
        }
    }
}
