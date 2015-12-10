class ResellersController < ApplicationController
  before_action :find_reseller, only: [:edit, :update, :destroy]

  def index
    @resellers = Reseller.all.order("nama ASC").paginate(page: params[:page], per_page: 3)

    respond_to do |format|
      format.html {}
      format.json { render json: @resellers }
    end
  end

  def new
    @reseller = Reseller.new
    @r_classes = RClass.all.order("nama ASC")    
  end

  def create
    @reseller = Reseller.new(reseller_params)
    if @reseller.save
      redirect_to resellers_path, notice: "Sukses tambah Reseller"
    else
      render 'new'
    end
  end
  def edit
    @r_classes = RClass.all.order("nama ASC")
  end

  def update
    if @reseller.update(reseller_params)
      redirect_to resellers_path, notice: "Sukses update Reseller"
    else
      render 'edit'
    end
  end

  def destroy

  end

  private
  def find_reseller
    @reseller = Reseller.find(params[:id])
  end

  def reseller_params
    params.require(:reseller).permit(:nama, :alamat, :tlp, :email, :status, :r_class_id, r_classes_attributes:[:nama])
  end
end
