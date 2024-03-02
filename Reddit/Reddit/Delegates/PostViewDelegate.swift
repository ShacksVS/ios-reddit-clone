//
//  PostViewDelegate.swift
//  Reddit
//
//  Created by Viktor Sovyak on 2/26/24.
//

import Foundation

protocol PostViewDelegate: AnyObject {
    func didTapShareButton(for post: Post)
    func didTapCommentButton(for post: Post)
//    func didTapFavoriteButton(for post: Post)
}
