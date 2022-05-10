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
      expect(@test_product.errors.full_messages).to include("Name can't be blank")
    end
    it 'validates :price' do
      @test_product.price_cents = nil
      expect(@test_product).to be_invalid
      expect(@test_product.errors.full_messages).to include("Price can't be blank")
    end
    it 'validates :quantity' do
      @test_product.quantity = nil
      expect(@test_product).to be_invalid
      expect(@test_product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'validates :category' do
      @test_product.category = nil
      expect(@test_product).to be_invalid
      expect(@test_product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
