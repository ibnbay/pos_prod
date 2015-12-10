class BarangsController < ApplicationController
  before_action :find_barang, only: [:show, :edit, :update, :destroy]

  def index
    @barangs = BarangKategori.all.order("nama_barang ASC").paginate(page: params[:page], per_page: 2)

    respond_to do |format|
      format.html {}
      format.json { render json: @barangs }
    end
  end

  def new
    @barang = Barang.new
    @kategoris = Kategori.all.order("nama ASC")

    @r_classes = RClass.all.order("nama ASC")
    @r_classes.count.times {
      @barang.h_barangs.build
    }
  end

  def create
    @barang = Barang.new(barang_params)
    if @barang.save
      redirect_to barangs_path, notice: "Sukses tambah Barang"
    else
      render 'new', notice: "Gagal tambah Kategori"
    end
  end

  # def show
  #   @kategoris = Kategori.all.order("nama ASC")
  #   @r_classes = RClass.all.order("nama ASC")
  # end

  def edit
    @kategoris = Kategori.all.order("nama ASC")
    @r_classes = RClass.all.order("nama ASC")
  end

  def update
    r_array = Array.new
    rclassid = Hash.new
    rclassid = params[:barang][:h_barangs_attributes].values

    rclassid.each { |r_class|
      r_array << r_class['r_class_id']
    }

    if r_array.uniq.length == r_array.length
      puts 'Tidak ada duplikat...'
      if @barang.update(barang_params)
        redirect_to barangs_path, notice: "Sukses update Barang"
      else
        render 'edit', notice: "Gagal update Kategori, silahkan check kembali."
      end
    else
      puts 'Ada duplikat...'
      render 'edit', notice: "Gagal update Kategori, silahkan check kembali."
    end
  end

  def destroy

  end

  private
  def find_barang
    @barang = Barang.find(params[:id])
  end

  def barang_params
    params.require(:barang).permit(:nama, :stock, :status, :kategori_id, kategoris_attributes:[:nama], detail_penjualans_attributes:[:id, :barang_id, :jumlah, :amount], h_barangs_attributes:[:id, :satuan, :r_class_id])
  end
end
