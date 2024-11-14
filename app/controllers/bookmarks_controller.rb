class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create]

  # def index
  #   @bookmarks = Bookmark.all
  # end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.create(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      # Je redirige vers la liste du bookmark
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = List.find(@bookmark.list_id)
    @bookmark.destroy
    redirect_to list_path(@list)
  end



  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end

  def set_list
    @list = List.find(params[:list_id])
  end

end
