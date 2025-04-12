module Madmin
  class FeedsController < Madmin::ResourceController
    def fetch_entries
      @record = Feed.find(params[:id])
      
      begin
        @record.fetch_entries
        redirect_to madmin.feed_path(@record), notice: "Entries successfully fetched!"
      rescue => e
        redirect_to madmin.feed_path(@record), alert: "Error fetching entries: #{e.message}"
      end
    end
  end
end
