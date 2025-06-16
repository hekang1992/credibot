//
//  Untitled.swift
//  credibot
//
//  Created by 何康 on 2025/6/16.
//

import UIKit

class MarqueeView: UIView {
    private var speed: CGFloat = 0.5
    private var spacing: CGFloat = 30.0
    private var fontSize: CGFloat = 12.pix()
    private var textColor: UIColor = .white
    
    private var items: [skinnyModel] = []
    private var displayLabels: [UILabel] = []
    
    private var animationTimer: CADisplayLink?
    private var currentOffset: CGFloat = 0
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.isHidden = true
        return label
    }()
    
    var onItemTapped: ((skinnyModel) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        clipsToBounds = true
        addSubview(placeholderLabel)
    }
    
    func configure(with items: [skinnyModel]?,
                   speed: CGFloat = 0.5,
                   spacing: CGFloat = 30.0,
                   fontSize: CGFloat = 12.pix(),
                   textColor: UIColor = .white) {
        stopAnimation()
        
        guard let validItems = items, !validItems.isEmpty else {
            showPlaceholder()
            return
        }
        
        let filteredItems = validItems.filter { ($0.likesnake ?? "").isEmpty == false }
        guard !filteredItems.isEmpty else {
            showPlaceholder()
            return
        }
        
        self.items = filteredItems
        self.speed = max(0.5, speed)
        self.spacing = max(10, spacing)
        self.fontSize = fontSize
        self.textColor = textColor
        
        prepareDisplayLabels()
        startAnimation()
    }
    
    private func showPlaceholder() {
        displayLabels.forEach { $0.removeFromSuperview() }
        displayLabels.removeAll()
        placeholderLabel.isHidden = false
    }
    
    private func hidePlaceholder() {
        placeholderLabel.isHidden = true
    }
    
    private func prepareDisplayLabels() {
        displayLabels.forEach { $0.removeFromSuperview() }
        displayLabels.removeAll()
        hidePlaceholder()
        
        guard bounds.width > 0, bounds.height > 0 else {
            return
        }
        
        for (index, item) in items.enumerated() {
            guard let text = item.likesnake, !text.isEmpty else {
                continue
            }
            let certainly = item.certainly ?? ""
            let amount = item.repay_amount ?? ""
            let label = UILabel()
            label.attributedText = GetColorConfig.attributedString(for: amount, in: text, colorHex: certainly)
            label.font = UIFont.systemFont(ofSize: fontSize)
            label.textColor = textColor
            label.sizeToFit()
            
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
            label.addGestureRecognizer(tap)
            
            let xPosition: CGFloat
            if displayLabels.isEmpty {
                xPosition = 20.pix()
            } else {
                guard let lastLabel = displayLabels.last else { continue }
                xPosition = lastLabel.frame.maxX + spacing
            }
            
            label.frame = CGRect(
                x: xPosition,
                y: 0,
                width: label.frame.width,
                height: bounds.height
            )
            
            addSubview(label)
            displayLabels.append(label)
            label.tag = index
        }
        
        if displayLabels.count == 1, let firstLabel = displayLabels.first {
            let copyLabel = createLabelCopy(from: firstLabel)
            copyLabel.frame.origin.x = firstLabel.frame.maxX + spacing
            addSubview(copyLabel)
            displayLabels.append(copyLabel)
        }
    }
    
    private func createLabelCopy(from label: UILabel) -> UILabel {
        let newLabel = UILabel()
        newLabel.text = label.text
        newLabel.font = label.font
        newLabel.textColor = label.textColor
        newLabel.frame = label.frame
        
        newLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        newLabel.addGestureRecognizer(tap)
        
        newLabel.tag = label.tag
        return newLabel
    }
    
    private func startAnimation() {
        guard !displayLabels.isEmpty else {
            showPlaceholder()
            return
        }
        
        stopAnimation()
        
        animationTimer = CADisplayLink(target: self, selector: #selector(updateAnimation))
        animationTimer?.add(to: .main, forMode: .common)
    }
    
    private func stopAnimation() {
        animationTimer?.invalidate()
        animationTimer = nil
        currentOffset = 0
    }
    
    @objc private func updateAnimation() {
        currentOffset -= speed
        
        guard let firstLabel = displayLabels.first else {
            stopAnimation()
            return
        }
        
        if firstLabel.frame.maxX + currentOffset <= 0 {
            let lastLabel = displayLabels.last!
            firstLabel.frame.origin.x = lastLabel.frame.maxX + spacing
            displayLabels.append(displayLabels.removeFirst())
            currentOffset = 0
        }
        
        for label in displayLabels {
            label.frame.origin.x += currentOffset
        }
        
        currentOffset = 0
    }
    
    @objc private func labelTapped(_ sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else { return }
        let index = label.tag
        guard index >= 0 && index < items.count else { return }
        
        onItemTapped?(items[index])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.frame = bounds
        
        if !displayLabels.isEmpty {
            prepareDisplayLabels()
        }
    }
    
    deinit {
        stopAnimation()
    }
}
