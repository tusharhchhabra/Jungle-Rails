require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'saves successfully when all fields are present' do
      @category = Category.new(name: "Tech")
      @product = Product.new(
        name: "iPhone",
        price_cents: 500,
        quantity: 10,
        category: @category
      )
      expect(@product).to be_valid
    end

    it 'should not save without a name' do
      @category = Category.new(name: "Tech")
      @product = Product.new(
        name: nil,
        price_cents: 500,
        quantity: 10,
        category: @category
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save without a price' do
      @category = Category.new(name: "Tech")
      @product = Product.new(
        name: "PlayStation 5",
        price_cents: nil,
        quantity: 10,
        category: @category
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price cents can't be blank")
    end

    it 'should not save without a quantity' do
      @category = Category.new(name: "Tech")
      @product = Product.new(
        name: "reMarkable",
        price_cents: 500,
        quantity: nil,
        category: @category
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save without a category' do
      @product = Product.new(
        name: "Macbook Pro",
        price_cents: 500,
        quantity: 10,
        category: nil
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
