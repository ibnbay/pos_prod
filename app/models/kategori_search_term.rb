class KategoriSearchTerm
  attr_reader :where_clause, :where_args, :order

  def initialize(search_term)
    search_term = search_term.downcase
    @where_clause = ""
    @where_args = {}
    build_for_nama_search(search_term)
  end


  private

  def build_for_nama_search(search_term)
    @where_clause << case_insensitive_search(:nama)
    @where_args[:nama]  = starts_with(search_term)

    @order = "nama asc"
  end

  def starts_with(search_term)
    search_term + "%"
  end

  def case_insensitive_search(field_name)
    "lower(#{field_name}) like :#{field_name}"
  end
end