class PenjualansController < ApplicationController
  before_action :find_penjualan, only: [:show, :edit, :update, :confirm]

  def index
    @penjualans = PenjualanList.all.order("penjualan_id DESC").paginate(page: params[:page], per_page: 3)

    respond_to do |format|
      format.html {}
      format.json { render json: @penjualans }
    end
  end

  def new
    @penjualan = Penjualan.new

    @resellers = Reseller.all.order("nama ASC")
    @barangs = Barang.all.order("nama ASC")
  end

  def show
    respond_to do |format|
      format.html {}
      format.pdf { render_penjualan_list(@penjualan) }
    end
    #@penjualan = Penjualan.find(params[:id])
    #@penjualan = Penjualan.where(id: :id)
    #@detail_penjualans = DetailPenjualan.where(id: 29)

    # respond_to do |format|
    #   format.html {}
    #   #format.json { render json: @detail_penjualans}
    #   #format.json { render json: @detail_penjualans(only:[:barang_id,:jumlah, :amount])}
    #   format.json { render :json => @penjualan.as_json(only: [:id, :tanggal, :total]) }
    #
    #   # format.json { render json: @penjualan.to_json(only:[:tanggal, :total],
    #   #               :include => [:reseller, {detail_penjualans: {only: [:barang_id,:jumlah, :amount]}} ]) }
    #   #format.json { render json: @article.as_json(only: [:id, :name, :content], include: [:author, {comments: {only:[:id, :name, :content]}}]) }
    # end
  end

  def create
    @penjualan = Penjualan.new(penjualan_params)

    if @penjualan.save
      spreadsheet = Roo::Excelx.new(params[:file].path)
      header = spreadsheet.sheet(0).row(1)

      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        #@penjualan.detail_penjualans.create(barang_id: row["barang_id"], jumlah: row["jumlah"], amount: row["amount"])
        @penjualan.detail_penjualans.create(barang_id: row["barang_id"], jumlah: row["jumlah"])
        #total = total + count_penjualan(row["barang_id"], row["jumlah"])
      end
      @penjualan.save

      redirect_to penjualans_path, notice: "Silahkan confirm atas penjualan yang sudah disubmit / diupload sebelumnya"
    else
      render 'new'
    end
  end

  def edit
    @resellers = Reseller.all.order("nama ASC")
    @barangs = Barang.all.order("nama ASC")
  end

  def update
    DetailPenjualan.where(penjualan_id: @penjualan.id).find_each do |s|
      s.destroy
    end

    if @penjualan.update(penjualan_params)
      spreadsheet = Roo::Excelx.new(params[:file].path)
      header = spreadsheet.sheet(0).row(1)

      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        #@penjualan.detail_penjualans.create(barang_id: row["barang_id"], jumlah: row["jumlah"], amount: row["amount"])
        @penjualan.detail_penjualans.create(barang_id: row["barang_id"], jumlah: row["jumlah"])
        #total = total + count_penjualan(row["barang_id"], row["jumlah"])
      end
      @penjualan.save

      redirect_to penjualans_path, notice: "Sukses update penjualan"
    else
      render 'edit'
    end
  end

  def upload
    @penjualan = Penjualan.new
    @resellers = Reseller.all.order("nama ASC")
  end

  def confirm
    @penjualan.warning = 2
    if @penjualan.save
      redirect_to penjualans_path, notice: "Sukses Confirm"
    else
      render 'show'
    end
  end

  private
  def find_penjualan
    @penjualan = Penjualan.find(params[:id])
  end

  def penjualan_params
    params.require(:penjualan).permit(:tanggal, :total, :upload, :warning, :reseller_id, resellers_attributes:[:nama],detail_penjualans_attributes:[:id, :barang_id, :jumlah, :amount])
  end

  def upload_params()
    spreadsheet = Roo::Excelx.new(file.path)
    header = spreadsheet.sheet(0).row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      #puts "BarangId ===> " + row["barang_id"].to_s
      @penjualan.detail_penjualans.create!(barang_id: row["barang_id"], jumlah: row["jumlah"], amount: row["amount"])

      # @penjualan.detail_penjualans.each do |f|
      #   f.barang_id = row["barang_id"]
      #   f.jumlah = row["jumlah"]
      #   f.amount = row["amount"]
      # end
    end
  end

  def count_penjualan(barang_id, jumlah)
    @barang = Barang.find(barang_id)
    return total_all = @barang.satuan * jumlah
  end

  def render_penjualan_list(penjualan)
    report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'jual2.tlf')

    report.start_new_page do |page|
      page.item(:id).value(penjualan.id)
      page.item(:tanggal).value(penjualan.tanggal)
      page.item(:nama_reseller).value(penjualan.reseller.nama)

      # values(id: penjualan.id,
      #        tanggal: penjualan.tanggal,
      #        nama_reseller: penjualan.reseller.nama
      #       )


        penjualan.detail_penjualans.each do |detail|
          page.list.add_row do |row|
            row.values nama: detail.barang.nama,
                       satuan: detail.barang.h_barangs.find_by(barang_id: detail.barang.id).satuan,
                       jumlah: detail.jumlah,
                       amount: detail.amount
          end
        end

        # on_page_footer_insert do |footer|
        #   footer.item(:total).value(total: penjualan.total)
        # end

        #values(total: penjualan.total)
    end

    # report.pages.each do |page|
    #   page.item(:total).value(penjualan.total)
    # end

    send_data report.generate, filename: 'penjualan.pdf',
                               type: 'application/pdf',
                               disposition: 'attachment'
  end
end
