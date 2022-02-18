//
//  ImageSelector.swift
//  AnoopExercises
//
//  Created by Anoop Subramani on 16/02/22.
//

import UIKit

class ImageSelector: UIControl {
    // on selected index change, set highlight background color, and centerXAnchor
    var selectedIndex = 0 {
        didSet {
            if selectedIndex < 0 {
                selectedIndex = 0
            }
            if selectedIndex >= imageButtons.count {
                selectedIndex = imageButtons.count - 1
            }
            
            highlightView.backgroundColor = highlightColor(forIndex: selectedIndex)
            
            let imageButton = imageButtons[selectedIndex]
            highLightViewXConstraint = highlightView.centerXAnchor.constraint(equalTo: imageButton.centerXAnchor)
        }
    }
    
    // highlight view background color changes based on the index selected.
    var highlightColors: [UIColor] = [] {
        didSet {
            highlightView.backgroundColor = highlightColor(forIndex: selectedIndex)
        }
    }
    
    // arrange image buttons
    private var imageButtons: [UIButton] = [] {
        didSet {
            oldValue.forEach{ $0.removeFromSuperview() }
            imageButtons.forEach{ selectorStackView.addArrangedSubview($0) }
        }
    }
    
    // highlight view to highlight the button selected
    private let highlightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    // update highlightView X axis.
    private var highLightViewXConstraint: NSLayoutConstraint! {
        didSet{
            oldValue?.isActive = false
            highLightViewXConstraint.isActive = true
        }
    }
    
    // on images set, update image button
    var images: [UIImage] = [] {
        didSet {
            imageButtons = images.map { image in
                let imageButton = UIButton()
                imageButton.setImage(image, for: .normal)
                imageButton.imageView?.contentMode = .scaleAspectFit
                imageButton.adjustsImageWhenHighlighted = false
                imageButton.addTarget(self, action: #selector(imageButtonTapped(_:)), for: .touchUpInside)
                return imageButton
            }
            selectedIndex = 0
        }
    }
    
    // action when image is tapped
    @objc private func imageButtonTapped(_ sender: UIButton) {
        guard let buttonIndex = imageButtons.firstIndex(of: sender) else {
            preconditionFailure("buttons images are not parallel")
        }
        
        let selectionAnimation = UIViewPropertyAnimator(duration: 0.25, dampingRatio: 0.4, animations: {
            self.selectedIndex = buttonIndex
            self.layoutIfNeeded()
        })
        selectionAnimation.startAnimation()
        sendActions(for: .valueChanged)
    }
    
    // horizontal stack view to store images
    private let selectorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    // activate constraints
    private func configureViewHierarchy() {
        addSubview(selectorStackView)
        insertSubview(highlightView, belowSubview: selectorStackView)
        NSLayoutConstraint.activate([
            selectorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectorStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectorStackView.topAnchor.constraint(equalTo: topAnchor),
            selectorStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            highlightView.heightAnchor.constraint(equalTo: highlightView.widthAnchor),
            highlightView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            highlightView.centerYAnchor.constraint(equalTo: selectorStackView.centerYAnchor)
        ])
    }
    
    // dynamic highlight color
    private func highlightColor(forIndex index: Int) -> UIColor {
        guard index >= 0 && index < highlightColors.count else {
            return UIColor.blue.withAlphaComponent(0.6)
        }
        return highlightColors[index]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        highlightView.layer.cornerRadius = highlightView.bounds.width / 2.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
