class FeedResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :url
  attribute :name
  attribute :description
  attribute :last_fetched_at
  attribute :created_at, form: false
  attribute :updated_at, form: false

  # Associations
  attribute :entries

  # Add scopes to easily filter records
  # scope :published

  # Add actions to the resource's show page
  member_action do |record|
    button_to "Fetch Entries", "/madmin/feeds/#{record.id}/fetch_entries", method: :post, class: "btn btn-primary"
  end

  # Customize the display name of records in the admin area.
  def self.display_name(record) = record.name

  # Customize the default sort column and direction.
  # def self.default_sort_column = "created_at"
  #
  # def self.default_sort_direction = "desc"
end
