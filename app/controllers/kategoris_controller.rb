class KategorisController < ApplicationController
  before_action :find_kategori, only: [:edit, :update, :destroy]

  def index
    #@kategoris = Kategori.all.order("nama ASC")
    @page = params[:page].present? ? params[:page] : 1
    #if params[:keywords].present?
      #@keywords = params[:keywords]
      #kategori_search_term =  KategoriSearchTerm.new(@keywords)

      #@kategoris = Kategori.where(
          #kategori_search_term.where_clause,
          #kategori_search_term.where_args).
          #order(kategori_search_term.order)#.paginate(page: @page, per_page: 15)
    #else
      #@kategoris = Kategori.all.order("nama ASC")
      @kategoris = Kategori.all.order("nama ASC").paginate(page: params[:page], per_page: 5)
    #end



    # if params[:search].present?
    #   @kategoris = Kategori.where(nama: params[:search]).order("nama ASC")
    # else
    #   @kategoris = Kategori.all.order("nama ASC").paginate(page: params[:page], per_page: 15)
    # end
    
    respond_to do |format|
      format.html {}
      format.json { render json: @kategoris.as_json(only: [:id, :nama, :status]) }
      #format.json { render json: Paginator.pagination_attributes(@books).merge!(books: @kategoris.as_json(only: [:id, :nama, :status])) }
      #render :json => Paginator.pagination_attributes(@books).merge!(books: @kategoris.as_json(only: [:id, :nama, :status]))
    end
  end

  def new
    @kategori = Kategori.new
  end

  def create
    @kategori = Kategori.new(kategori_params)

    if @kategori.save
      redirect_to root_path, notice: "Sukses tambah Kategori"
    else
      render 'new'#, notice: "Gagal tambah Kategori"
    end
  end

  def update
    if @kategori.update(kategori_params)
      redirect_to root_path, notice: "Sukses update Kategori"
    else
      render 'edit'#, notice: "Gagal update Kategori"
    end
  end

  def destroy

  end

  private
  def find_kategori
    @kategori = Kategori.find(params[:id])
  end

  def kategori_params
    params.require(:kategori).permit(:nama, :status, barangs_attributes:[:kode, :nama, :stock, :satuan, :status])
  end
end
