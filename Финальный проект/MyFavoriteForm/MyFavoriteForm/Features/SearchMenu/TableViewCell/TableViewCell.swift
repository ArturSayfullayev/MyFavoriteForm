//
//  TableViewCell.swift
//  MyFavoriteForm
//
//  Created by Artur on 21.02.2021.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    // MARK: - Properties
    private let edgesInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    // MARK: - Identifier
    static let reuseIdentifier = "SearchMenuCellIdentifier"
    
    // MARK: - GUI Properties
    private lazy var mainView = UIView()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var titleDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    private lazy var rightIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        
        return image
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initView() {
        self.contentView.addSubview(self.mainView)
        self.mainView.addSubviews([self.title,
                          self.titleDescription,
                          self.rightIcon])
    }
    
    // MARK: - Constraints
    override func updateConstraints() {
        self.mainView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.title.snp.updateConstraints { (make) in
            make.top.left.equalToSuperview().inset(self.edgesInsets)
        }
        self.titleDescription.snp.updateConstraints { (make) in
            make.top.equalTo(self.title.snp.bottom).offset(10)
            make.left.bottom.equalToSuperview().inset(self.edgesInsets)
        }
        self.rightIcon.snp.updateConstraints { (make) in
            make.left.greaterThanOrEqualTo(self.title.snp.right).offset(20)
            make.left.greaterThanOrEqualTo(self.titleDescription.snp.right).offset(20)
            make.right.equalToSuperview().inset(self.edgesInsets)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(30)
        }
        super.updateConstraints()
    }
    
    // MARK: - Methods
    func setCell(title: String, description: String) {
        self.title.text = title
        self.titleDescription.text = description
        
        self.setNeedsUpdateConstraints()
    }
}
