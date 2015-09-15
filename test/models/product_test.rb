require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test 'product attributes must not be empty' do 
    product = Product.new
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  test 'price must be at least one cent' do
    product = Product.new(
      title: 'My Book Title',
      description: 'Buy it plz',
      image_url: 'red.jpg'
      )
    product.price = -1
    assert product.invalid?
    assert_equal 'must be greater than or equal to 0.01',
      product.errors[:price].join('; ')
      
    product.price = 0
    assert product.invalid?
    assert_equal 'must be greater than or equal to 0.01', 
      product.errors[:price].join('; ')
      
    product.price = 1
    assert product.valid?
  end
  def new_product image_url
    Product.new(
      title: 'My Book Title',
      description: 'Buy it plz',
      image_url: image_url
    )
  end
  test 'image_url' do
    ok = %w{ fred.gif fred.jpg fred.png FRED.GIF FRED.Jpg
             http://a.b.c/x/y/fred.gif }
    bad = %w{ fred.doc fred.gifv fred.gif/load }
    
    ok.each do |name|
      assert new_product(name).valid? '#{name} should not be invalid.'
    end
    bad.each do |name|
      assert new_product(name).invalid?, '#{name} should be invalid'
    end
  end
  test 'product is not valid without a unique title' do 
    product = Product.new(
      title: products(:ruby).title,
      description: 'yyy',
      price: 1,
      image_url: 'fred.gif'
    )
    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'), product.errors[:title].join('; ')
  end
end
