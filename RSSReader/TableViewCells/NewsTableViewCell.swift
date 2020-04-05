import SnapKit
import UIKit
import Kingfisher

protocol NewsTableViewCellDelegate: class {
    func descriptionHidden()
}

class NewsTableViewCell: UITableViewCell {
    
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let sourceLabel = UILabel()
    let dateLabel = UILabel()
    let descriptionLabel = UILabel()
    
    weak var delegate: NewsTableViewCellDelegate?
    
    private var news: NewsModel?
    
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
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(110)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-16)
        }

        sourceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-16)
        }

        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sourceLabel.snp.bottom)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-16)
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            make.height.equalTo(0)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }

        super.updateConstraints()
    }
    
    func setElements(news: NewsModel) {
        self.news = news
        
        hideDescription(news.descriptionIsHidden)
        
        if let url = URL(string: news.imageUrl) {
            iconImageView.kf.setImage(with: url)
        } else {
            iconImageView.image = nil
        }
        titleLabel.text = news.title
        sourceLabel.text = news.source.rawValue
//        dateLabel.text = news.date
        descriptionLabel.text = news.description
    }

    private func setupElements() {
        backgroundColor = .clear
        let cellGesture = UITapGestureRecognizer(target: self,
                                                 action: #selector(tapOnCell))
        self.addGestureRecognizer(cellGesture)
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.borderWidth = 2
        iconImageView.layer.borderColor = UIColor.black.cgColor
        
        titleLabel.numberOfLines = 0
        
        descriptionLabel.numberOfLines = 0
    }
    
    private func addSubviews() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(sourceLabel)
        addSubview(dateLabel)
        addSubview(descriptionLabel)
    }
    
    private func hideDescription(_ isHidden: Bool) {
        news?.descriptionIsHidden = isHidden
        
        descriptionLabel.snp.remakeConstraints { (make) in
            make.top.greaterThanOrEqualTo(iconImageView.snp.bottom).offset(10)
            make.top.greaterThanOrEqualTo(dateLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
            if isHidden {
                make.height.equalTo(0)
            } else {
                make.height.greaterThanOrEqualTo(0)
            }
        }
    }
    
    @objc private func tapOnCell() {
        if let news = self.news {
            hideDescription(!news.descriptionIsHidden)
            delegate?.descriptionHidden()
        }
    }
    
    
}
