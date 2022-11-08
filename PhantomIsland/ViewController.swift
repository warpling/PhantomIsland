//
//  ViewController.swift
//  PhantomIsland
//
//  Created by Ryan McLeod on 10/13/22.
//

import UIKit

class ViewController: UIViewController {

    let dynamicIsland = UIView()
    let screenEdges = UIView()
    
    let totalYOffset = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(white: 0.1, alpha: 1)
        
        screenEdges.frame = view.bounds.offsetBy(dx: 0, dy: totalYOffset)
        screenEdges.backgroundColor = UIColor(white: 0.25, alpha: 1)
        screenEdges.layer.cornerCurve = .continuous
        screenEdges.layer.cornerRadius = 55
        
        dynamicIsland.backgroundColor = .black
        
        view.addSubview(screenEdges)
        screenEdges.addSubview(dynamicIsland)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let dynamicIslandFrame = UIDevice.dynamicIslandCompactFrame else {
            print("Only works on devices with dynamic island")
            let warningLabel = UILabel(frame: CGRect(x: 0, y: 15, width: view.bounds.width, height: 100))
            warningLabel.textAlignment = .center
            warningLabel.textColor = .systemRed
            warningLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            warningLabel.text = "No dyanmic island found!"
            view.addSubview(warningLabel)
            return
        }
        
        dynamicIsland.frame = dynamicIslandFrame
        dynamicIsland.layer.cornerRadius = dynamicIsland.bounds.height/2
    }
    
    // MARK: - Touch
    
    let xMark = {
        let view = UIImageView(image: UIImage(systemName: "xmark",
                                              withConfiguration: UIImage.SymbolConfiguration(pointSize: 66, weight: .thin)))
        view.tintColor = UIColor.white.withAlphaComponent(0.5)
        return view
    }()

    
    let touchMark = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 35, height: 35)))
        view.backgroundColor = UIColor.systemPink.withAlphaComponent(0.5)
        view.layer.cornerRadius = view.bounds.width/2
        return view
    }()
    
    let preciseTouchMark = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 35, height: 35)))
        view.backgroundColor = UIColor.systemCyan.withAlphaComponent(0.5)
        view.layer.cornerRadius = view.bounds.width/2
        return view
    }()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        view.addSubview(xMark)
        view.addSubview(touchMark)
        view.addSubview(preciseTouchMark)
        
        updateViewPositions(touch: touch)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        xMark.removeFromSuperview()
        touchMark.removeFromSuperview()
        preciseTouchMark.removeFromSuperview()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        updateViewPositions(touch: touch)
    }
    
    func updateViewPositions(touch: UITouch) {
        let touchLocation = touch.location(in: view)
        let offsetTouchLocation = touch.location(in: view).offset(y: totalYOffset)
        let offsetPreciseTouchLocation = touch.preciseLocation(in: view).offset(y: totalYOffset)

        xMark.layer.position = touchLocation
        touchMark.layer.position = offsetTouchLocation
        preciseTouchMark.layer.position = offsetPreciseTouchLocation

    }
}

extension CGPoint {
    func offset(x: CGFloat = 0, y: CGFloat = 0) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
}

