require_relative 'products'

class SalesSum
  include Products

  def initialize
    @total_sum = 0
    @tax_sum = 0
    @import_tax = 0.05
    @basic_tax = 0.1
    @basket = []
  end

  def read_input(input)
    input_arr = input.split(' ')
    quantity = input_arr[0].to_i
    price = input_arr[-1].to_f
    product_name = input_arr[1..-3].join(' ')
    sum_product(quantity, price, product_name)

    show_result
  end

  def show_result
    result = ''
    @basket.each do |product|
      result += "#{product[:product_name]}: #{product[:total_price].round(2)}"
      result += "\n"
    end
    result += "Sales Taxes: #{@tax_sum.round(2)}\n"
    result += "Total: #{@total_sum.round(2)}\n"

    result
  end

  private

  def sum_product(quantity, price, product_name)
    total_price = quantity * price
    tax = calculate_tax(product_name, total_price)
    total_price += tax
    add_to_basket(product_name, total_price)
    @total_sum += total_price
    @tax_sum += tax
  end

  def add_to_basket(product_name, total_price)
    @basket << { product_name: product_name, total_price: total_price }
  end

  def calculate_tax(product_name, price)
    tax = 0
    tax += price * @basic_tax if basic_tax?(product_name)
    tax += price * @import_tax if import_tax?(product_name)

    # # round up to the nearest 0.05
    # return tax.ceil - 0.05 if tax.ceil - tax > 0.05

    tax
  end

  def basic_tax?(product_name)
    clear_product_name = product_name.split(' ').reject { |word| word == 'imported' }.join(' ')
    product = list_products[clear_product_name.to_sym]

    product != 'food' && product != 'medical' && product != 'book'
  end

  def import_tax?(product_name)
    product_name.include?('imported')
  end
end

sales_sum = SalesSum.new

sales_sum.read_input('2 book at 12.49')
sales_sum.read_input('1 music CD at 14.99')
sales_sum.read_input('1 chocolate bar at 0.85')
puts sales_sum.show_result
# 2 book: 24.98
# 1 music CD: 16.49
# 1 chocolate bar: 0.85
# Sales Taxes: 1.50
# Total: 42.32

puts '---------------------'

sales_sum2 = SalesSum.new
sales_sum2.read_input('1 imported box of chocolates at 10.00')
sales_sum2.read_input('1 imported bottle of perfume at 47.50')
puts sales_sum2.show_result
# 1 imported box of chocolates: 10.50
# 1 imported bottle of perfume: 54.65
# Sales Taxes: 7.65
# Total: 65.15

puts '---------------------'

sales_sum3 = SalesSum.new
sales_sum3.read_input('1 imported bottle of perfume at 27.99')
sales_sum3.read_input('1 bottle of perfume at 18.99')
sales_sum3.read_input('1 packet of headache pills at 9.75')
sales_sum3.read_input('3 box of imported chocolates at 11.25')
puts sales_sum3.show_result
# 1 imported bottle of perfume: 32.19
# 1 bottle of perfume: 20.89
# 1 packet of headache pills: 9.75
# 3 imported box of chocolates: 35.55
# Sales Taxes: 7.90
# Total: 98.38
