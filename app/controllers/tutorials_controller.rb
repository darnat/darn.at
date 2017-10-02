class TutorialsController < ApplicationController
  before_action :set_tutorial, only: [:show]

  # GET /tutorials
  # GET /tutorials.json
  def index
    @tutorials = Tutorial.includes(:user).all
  end

  # GET /tutorials/1
  # GET /tutorials/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutorial
      @tutorial = Tutorial.find(params[:id])
    end
end
