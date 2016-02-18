class ImportsController < ApplicationController
  before_filter :require_admin

  before_filter :require_import, only: [:show, :confirm, :destroy]

  def new
    @import = Import.new
  end

  def create
    @import = Import.new(csv: import_params[:csv].try(:read))

    if @import.save
      redirect_to @import
    else
      render :new
    end
  end

  def show
  end

  def confirm
    @import.confirm!
    redirect_to tour_path, flash: {success: "Shows imported!"}
  end

  def destroy
    @import.destroy
    redirect_to root_path, flash: {success: "Import removed."}
  end

  private

    def import_params
      params.require(:import).permit(:csv)
    end

    def require_import
      @import = Import.find(params[:id])
    end
end
