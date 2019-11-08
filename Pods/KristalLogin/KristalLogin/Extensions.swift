//
//  Extensions.swift
//  commonlogin
//
//  Created by Prince Mathew on 07/11/19.
//  Copyright © 2019 Prince Mathew. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit

extension Data {
    func sha256() -> String {
        var hash = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))
        CC_SHA256((self as NSData).bytes, CC_LONG(self.count), &hash)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}

extension String {
    func sha256() -> String {
        guard let data = self.data(using: .utf8) else {
            return ""
        }
        return data.sha256()
    }
}

extension UIView {
    public func fixIn(_ view: UIView) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = view.frame;
        view.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}

