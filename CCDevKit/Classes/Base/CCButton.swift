//
//  CCButton.swift
//  clz
//
//  Created by cc on 2021/8/5.
//

import UIKit

public extension CCButton {
    enum ImagePosition {
        case top
        case bottom
        case left
        case right
    }
}

public class CCButton: UIControl {
    public var imagePosition: ImagePosition = .top {
        didSet {
            setNeedsLayout()
        }
    }

    public var space: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    public var imageSize: CGSize = .zero {
        didSet {
            setNeedsLayout()
        }
    }

    public var imageNormal: UIImage? {
        didSet {
            imageView.image = imageNormal
        }
    }

    public var imageSelected: UIImage?
    public var titleNormal: String? {
        didSet {
            label.text = titleNormal
            setNeedsLayout()
        }
    }

    public var titleSelected: String?
    public var font: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            label.font = font
            setNeedsLayout()
        }
    }

    public var titleColorNormal: UIColor = .black {
        didSet {
            label.textColor = titleColorNormal
        }
    }

    public var titleColorSelected: UIColor = .black

    public lazy var label: UILabel = {
        let label = UILabel()
        label.font = self.font
        label.textColor = titleColorNormal
        return label
    }()

    public lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(imageView)
    }

    override public var isSelected: Bool {
        didSet {
            if isSelected {
                if imageSelected != nil {
                    imageView.image = imageSelected
                }

                if titleSelected != nil {
                    label.text = titleSelected
                }
            } else {
                imageView.image = imageNormal
                label.text = titleNormal
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        print(#function)
        calculateTextSize(bounds)
        calculateImageSize(bounds)
        calculateTextOrigin(bounds)
        calculateImageOrigin(bounds)
    }
}

// MARK: - calculate size

extension CCButton {
    private func calculateTextSize(_ rect: CGRect) {
        var rectW: CGFloat = 0
        switch imagePosition {
        case .top, .bottom:
            rectW = rect.width
        case .left, .right:
            rectW = rectW - space - imageSize.width
        }

        let text = titleNormal ?? ""
        let textSize = (text as NSString).boundingRect(with: CGSize(width: rectW, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).size
        label.frame.size = textSize
    }

    private func calculateImageSize(_ rect: CGRect) {
        imageView.frame.size = imageSize
    }

    private func calculateTextOrigin(_ rect: CGRect) {
        var x: CGFloat = 0, y: CGFloat = 0
        switch imagePosition {
        case .top:
            x = (rect.width - label.frame.size.width) / 2
            y = (rect.height - imageSize.height - space - label.frame.height) / 2 + imageSize.height + space
        case .bottom:
            x = (rect.width - label.frame.size.width) / 2
            y = (rect.height - imageSize.height - space - label.frame.height) / 2
        case .left:
            x = (rect.width - label.frame.size.width - imageSize.width - space) / 2 + imageSize.width + space
            y = (rect.height - label.frame.size.height) / 2
        case .right:
            x = (rect.width - label.frame.size.width - imageSize.width - space) / 2
            y = (rect.height - label.frame.size.height) / 2
        }

        label.frame.origin = CGPoint(x: x, y: y)
    }

    private func calculateImageOrigin(_ rect: CGRect) {
        var x: CGFloat = 0, y: CGFloat = 0
        switch imagePosition {
        case .top:
            x = (rect.width - imageSize.width) / 2
            y = (rect.height - imageSize.height - space - label.frame.height) / 2
        case .bottom:
            x = (rect.width - imageSize.width) / 2
            y = (rect.height - imageSize.height - space - label.frame.height) / 2 + space + label.frame.size.height
        case .left:
            x = (rect.width - label.frame.size.width - imageSize.width - space) / 2
            y = (rect.height - imageSize.height) / 2
        case .right:
            x = (rect.width - label.frame.size.width - imageSize.width - space) / 2 + label.frame.size.width + space
            y = (rect.height - imageSize.height) / 2
        }

        imageView.frame.origin = CGPoint(x: x, y: y)
    }
}
