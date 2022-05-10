module ProductHelper
  def sold_out?(product)
    product.quantity.zero?
  end
end
