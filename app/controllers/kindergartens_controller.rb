class KindergartensController < ApplicationController
  before_action :set_kindergarten, except: [:index, :new, :create]

  def index
    @kindergartens = Kindergarten.all
  end

  def new
    @kindergarten = Kindergarten.new
  end

  def create
    @kindergarten = Kindergarten.new(kindergarten_params)
    if @kindergarten.save
      flash[:success] = 'Kindergarten Created!'
      redirect_to kindergarten_path(@kindergarten)
    else
      flash[:error] = 'Fix errors and try again'
      render :new
    end
  end

  def update
    if @kindergarten.update(kindergarten_params)
      flash[:success] = 'kindergarten Updated!'
      redirect_to kindergarten_path(@kindergarten)
    else
      flash[:error] = 'kindergarten failed to update!'
      render :edit
    end
  end

  def show
  end

  def destroy
    @kindergarten.destroy
    flash[:success] = 'kindergarten Deleted!'
    redirect_to kindergartens_path
  end

  private
  def kindergarten_params
    params.require(:kindergarten).permit(:name, :students, :open)
  end
  
  def set_kindergarten
    @kindergarten = Kindergarten.find(params[:id])
  end
end
