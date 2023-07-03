require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:category) { Category.create(name: 'Electronics') }

    it 'saves successfully when all fields are set' do
      product = Product.new(
        name: 'Smartphone',
        price: 999.99,
        quantity: 10,
        category: category
      )
      expect(product.save).to be true
    end

    it 'is not valid without a name' do
      product = Product.new(
        price: 999.99,
        quantity: 10,
        category: category
      )
      expect(product.valid?).to be false
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a price' do
      product = Product.new(
        name: 'Smartphone',
        quantity: 10,
        category: category
      )
      expect(product.valid?).to be false
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'is not valid without a quantity' do
      product = Product.new(
        name: 'Smartphone',
        price: 999.99,
        category: category
      )
      expect(product.valid?).to be false
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      product = Product.new(
        name: 'Smartphone',
        price: 999.99,
        quantity: 10
      )
      expect(product.valid?).to be false
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
