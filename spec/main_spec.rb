require_relative './spec_helper'
require_relative '../sales_sum'

describe SalesSum do
  test 'test case 1' do
    sales_sum = SalesSum.new
    sales_sum.read_input('2 book at 12.49')
    sales_sum.read_input('1 music CD at 14.99')
    sales_sum.read_input('1 chocolate bar at 0.85')

    expect(sales_sum.show_result).to eq(
      "2 book: 24.98\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.5\nTotal: 42.32"
    )
  end
end
