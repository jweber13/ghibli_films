class FilmsController < ApplicationController
  before_action :set_film, only: %i[show]

  def index
    # render json: FilmRepository.instance.all
    @films = FilmRepository.instance.all
  end

  def show
    # @film = FilmRepository.instance.find(params[:id].to_i)
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
