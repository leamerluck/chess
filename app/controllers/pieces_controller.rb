class PiecesController < ApplicationController
  before_action :select_pc, :only => [:show, :update]
  before_action :only => :update do
    validate_move(:x_position, :y_position)
  end

  def show
    @pieces = select_pc.game.pieces
  end

  def update

    row = params[:y_position].to_i
    col = params[:x_position].to_i
    select_pc.update_attributes(y_position: row, x_position: col)
    redirect_to game_path(select_pc.game.id)
  end

  private

  def validate_move(x_position, y_position)
    row = params[:y_position].to_i
    col = params[:x_position].to_i
    if !select_pc.valid_move?(col, row)
      flash[:alert] = "That move is not allowed!  Please choose your piece and try again."
      redirect_to game_path(select_pc.game.id)
    end
  end

  def select_pc
    @select_pc = Piece.find(params[:id])
  end
end
