class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    order_list = @order.line_items
    @order_products = Product.where(id: order_list.map do |item|
                                          item.product_id
                                        end).map.with_index do |product, index|
      { product:,
        quantity: order_list[index][:quantity] }
    end
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end
  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source: params[:stripeToken],
      amount: cart_subtotal_cents,
      description: current_user ? "#{current_user.first_name} #{current_user.last_name} Jungle Order" : "#{params[:stripeEmail]} Jungle Order",
      currency: 'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product:,
        quantity:,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end
end
