class FeedsController < ApplicationController
  def index
    @feeds = Feed.all.order(created_at: :desc)
  end

  def show
    @feed = Feed.find(params[:id])
    @entries = @feed.entries.order(published_at: :desc).page(params[:page]).per(20)
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(feed_params)
    
    if @feed.save
      redirect_to @feed, notice: "Feed was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @feed = Feed.find(params[:id])
  end
  
  def update
    @feed = Feed.find(params[:id])
    
    if @feed.update(feed_params)
      redirect_to @feed, notice: "Feed was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    
    redirect_to feeds_path, notice: "Feed was successfully deleted."
  end

  def fetch_entries
    @feed = Feed.find(params[:id])
    
    begin
      @feed.fetch_entries
      redirect_to @feed, notice: "Entries successfully fetched!"
    rescue => e
      redirect_to @feed, alert: "Error fetching entries: #{e.message}"
    end
  end
  
  private
  
  def feed_params
    params.require(:feed).permit(:url, :name, :description)
  end
end
