//
//  FollowerCollectionLayout.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 05/04/2025.
//

import UIKit

enum FollowerCollectionViewLayout {
    static func layout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 80, height: 80)
        flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        
        return flowLayout
    }
}
