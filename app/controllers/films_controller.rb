class FilmsController < ApplicationController
  before_action :set_film, only: %i[show]

  def index
    # render json: FilmRepository.instance.all
    @films = FilmRepository.instance.all
    if params[:query].present?
      # @films = @films.global_search(params[:query])
      @films = FilmRepository.instance.search(params[:query])
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
end
