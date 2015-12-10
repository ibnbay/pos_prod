class RClassesController < ApplicationController
  before_action :find_rclass, only: [:edit, :update, :destroy]

  def index
    @r_classes = RClass.all.order("nama ASC")

    respond_to do |format|
      format.html {}
      format.json { render json: @r_classes }
    end
  end

  def new
    @rclass = RClass.new
  end

  def create
    @rclass = RClass.new(rclass_params)

    if @rclass.save
      redirect_to r_classes_path, notice: "Sukses tambah Reseller Class"
    else
      render 'new'#, notice: "Gagal tambah Kategori"
    end
  end

  def update
    if @rclass.update(rclass_params)
      redirect_to r_classes_path, notice: "Sukses update Reseller Class"
    else
      render 'edit'#, notice: "Gagal update Kategori"
    end
  end

  def destroy

  end

  private
  def find_rclass
    @rclass = RClass.find(params[:id])
  end

  def rclass_params
    params.require(:r_class).permit(:nama, :status, resellers_attributes:[:nama, :alamat, :tlp, :email, :status])
  end
end
