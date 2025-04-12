class Entry < ApplicationRecord
  belongs_to :feed
  
  validates :title, presence: true
  validates :url, presence: true
  validates :guid, uniqueness: { scope: :feed_id }
  
  default_scope { order(published_at: :desc) }

  has_one_attached :image

  # Extract and store first image from content
  def store_first_image
    return if image.attached? || content.blank?

    # Check for enclosure first
    if enclosure_url.present?
      begin
        downloaded_image = URI.open(enclosure_url)
        image.attach(io: downloaded_image, filename: "entry-#{id}.jpg")
      rescue => e
        Rails.logger.error "Failed to download enclosure image: #{e.message}"
      end
      # Fallback to content images if no enclosure
    elsif content.present?
      doc = Nokogiri::HTML(content)
      img_src = doc.css('img').first&.attr('src')

      if img_src
        begin
          downloaded_image = URI.open(img_src)
          image.attach(io: downloaded_image, filename: "entry-#{id}.jpg")
        rescue => e
          Rails.logger.error "Failed to download content image: #{e.message}"
        end
      end
    end

    # return unless img_src

    # Download and attach image
    # begin
    #   downloaded_image = URI.open(img_src)
    #   image.attach(io: downloaded_image, filename: "entry-#{id}.jpg")
    # rescue => e
    #   Rails.logger.error "Failed to download image: #{e.message}"
    # end
  end

end
