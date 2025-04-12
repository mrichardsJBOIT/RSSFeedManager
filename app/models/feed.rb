require 'httparty'
require 'feedjira'

class Feed < ApplicationRecord
  has_many :entries, dependent: :destroy

  validates :url, presence: true
  validates :name, presence: true

  def fetch_entries
    content = HTTParty.get(url).body
    feed = Feedjira.parse(content)
    
    feed.entries.each do |entry_data|
      entry = entries.find_or_initialize_by(guid: entry_data.entry_id)
      entry.update!(
        title: entry_data.title,
        url: entry_data.url,
        author:get_author(entry_data),
        published_at: entry_data.published,
        content: entry_data.content || entry_data.summary,
        # Add this line to store enclosure URL if available
        enclosure_url: entry_data.try(:enclosure_url) || entry_data.try(:image)
      )
      # Process image immediately or leave for later
      EntryImageService.process_entry(entry)

      # guid = entry.entry_id || entry.url
      # existing_entry = entries.find_by(guid: guid)
      #
      # unless existing_entry
      #   entries.create!(
      #     title: entry.title,
      #     url: entry.url,
      #     author: entry.author || "Unknown",
      #     published_at: entry.published || Time.current,
      #     content: entry.content || entry.summary || "",
      #     guid: guid
      #   )
      # end
    end
    update(last_fetched_at: Time.current)
  end

  private

  def get_author(entry)
    # Try different author field variations
    entry.try(:dc_creator) || # Dublin Core creator
      entry.try(:author) ||     # Standard author
      entry.try(:creator) ||    # Alternative creator
      "Unknown"                 # Fallback
  end

end
