require 'rails_helper'
require 'product'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before :each do
      test_category = Category.new(name: 'test cat')
      @test_product = Product.create({ name: 'test product', quantity: 100, price: 1000, category: test_category })
    end

    it 'save successfully' do
      expect(@test_product).to be_valid
    end
    it 'validates :name' do
      @test_product.name = nil
      expect(@test_product).to be_invalid
    end
    it 'validates :price' do
      @test_product.price_cents = nil
      expect(@test_product).to be_invalid
    end
    it 'validates :quantity' do
      @test_product.quantity = nil
      expect(@test_product).to be_invalid
    end
    it 'validates :category' do
      @test_product.category = nil
      expect(@test_product).to be_invalid
    end
  end
end
