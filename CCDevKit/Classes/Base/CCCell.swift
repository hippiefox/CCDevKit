//
//  CCCell.swift
//  clz
//
//  Created by cc on 2021/8/5.
//

import UIKit

public class CCTableViewCell<T: UITableViewCell> {
    public static func with(_ tableView: UITableView, indexPath: IndexPath) -> T {
        tableView.dequeueReusableCell(withIdentifier: T.cc_reuseId, for: indexPath) as! T
    }
}

public class CCCollectionViewCell<T: UICollectionViewCell> {
    public static func with(_ collectionView: UICollectionView, indexPath: IndexPath) -> T {
        collectionView.dequeueReusableCell(withReuseIdentifier: T.cc_reuseId, for: indexPath) as! T
    }
}

public class CCCollectionReuseView<T: UICollectionReusableView> {
    public static func header(_ collectionView: UICollectionView, indexPath: IndexPath) -> T {
        collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.cc_reuseId, for: indexPath) as! T
    }

    public static func footer(_ collectionView: UICollectionView, indexPath: IndexPath) -> T {
        collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.cc_reuseId, for: indexPath) as! T
    }
}

public extension UIView {
    static var cc_reuseId: String {
        NSStringFromClass(Self.self)
    }
}
