class FilmsController < ApplicationController
  before_action :set_film, only: %i[show]

  def index
    # render json: FilmRepository.instance.all
    page = params[:page] || 1
    per_page = 10
    paginated_result = FilmRepository.instance.paginate(page: page, per_page: per_page)
    @films = paginated_result.records
    @pagination = paginated_result
    # # @films = FilmRepository.instance.all
    # if params[:query].present?
    #   @films = FilmRepository.instance.search(params[:query])
    # end
    if params[:query].present?
      search_result = FilmRepository.instance.search(params[:query])
      @films = paginate_collection(search_result, page: page, per_page: per_page)
      @pagination = nil # Clear the pagination object for search results
    # else
    #   paginated_result = FilmRepository.instance.paginate(page: page, per_page: per_page)
    #   @films = paginated_result
    #   @pagination = paginated_result
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.json { render json: @films }
      format.text { render partial: "films/list", locals: { films: @films }, formats: [:html] }
    end
  end

  def show
    # render json: FilmRepository.instance.find(params[:id].to_i)
  end

  private

  def set_film
    @film = FilmRepository.instance.find(params[:id].to_i)
  end

  def film_params
    params.require(:film).permit(:title, :director)
  end

  def paginate_collection(collection, options = {})
    offset = (options[:page].to_i - 1) * options[:per_page].to_i
    collection[offset, options[:per_page].to_i]
  end
end
