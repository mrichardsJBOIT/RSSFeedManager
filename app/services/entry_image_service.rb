class EntryImageService
  def self.process_entry(entry)
    Rails.logger.info "Processing images for entry #{entry.id}"
    Rails.logger.info "Enclosure URL: #{entry.enclosure_url}" if entry.enclosure_url
    entry.store_first_image
    if entry.image.attached?
      Rails.logger.info "Successfully attached image to entry #{entry.id}"
    else
      Rails.logger.info "No image attached to entry #{entry.id}"
    end
  end
end