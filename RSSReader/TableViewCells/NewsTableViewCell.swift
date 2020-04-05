import SnapKit
import UIKit

class NewsTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupElements()
        addSubviews()
        
        updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        super.updateConstraints()
    }

    private func setupElements() {
        backgroundColor = .clear
        
        titleLabel.text = "text"
        titleLabel.numberOfLines = 0
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
    }
    
    
}
