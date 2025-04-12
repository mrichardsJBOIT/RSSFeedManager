class EntriesController < ApplicationController
  def index
    if params[:feed_id]
      @feed = Feed.find(params[:feed_id])
      @entries = @feed.entries.order(published_at: :desc).page(params[:page]).per(20)
    else
      @entries = Entry.order(published_at: :desc).page(params[:page]).per(20)
    end
  end

  def show
    @entry = Entry.find(params[:id])
    EntryImageService.process_entry(@entry)
    @feed = @entry.feed
  end
end
