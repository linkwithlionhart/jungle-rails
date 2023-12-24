require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: 'Example Category')
    end

    # Example 1: Ensure a product with all fields set will save successfully
    it 'is valid with valid attributes' do
      product = Product.new(
        name: 'Example',
        price: 10.99,
        quantity: 5,
        category: @category
      )
      expect(product).to be_valid
    end

    # Example 2: Validate presence of name
    it 'is not valid without a name' do
      product = Product.new(
        name: nil,
        price: 10.99,
        quantity: 5,
        category: @category
      )
      product.valid?
      expect(product.errors.full_messages).to include ("Name cannot be blank.")
    end

    # Example 3: Validate presence of price
    it 'is not valid without a price' do
      product = Product.new(
        name: 'Example',
        price: nil,
        quantity: 5,
        category: @category
      )
      product.valid?
      expect(product.errors.full_messages).to include("Price cannot be blank.")
    end

    # Example 4: Validate presence of quantity
    it 'is not valid without a quantity' do
      product = Product.new(
        name: 'Example',
        price: 10.99,
        quantity: nil,
        category: @category
      )
      product.valid?
      expect(product.errors.full_messages).to include("Quantity cannot be blank.")
    end

    # Example 5: Validate presence of category
    it 'is not valid without a category' do
      product = Product.new(
        name: 'Example',
        price: 10.99,
        quantity: 5,
        category: nil
      )
      product.valid?
      expect(product.errors.full_messages).to include("Category cannot be blank.")
    end

  end # describe block
end # outer-most 
