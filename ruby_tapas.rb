r = /\d{3}-\d{4}/
puts r.match('my number is 555-1234')

if (m = r.match('my number is 555-1234'))
  puts "Found #{m}"
end

##better

# r.match('my number if 444-1235') do |m|
#   puts "Found #{m}"
# end or fail 'no number found'

# r.match('my number if aaa-bbbb') do |m|
#   puts "Found #{m}"
# end or fail 'no number found'


Address = Struct.new(:street, :city, :state)
Order = Struct.new(:subtotal, :address)

class SaleCalculator
  TAX_RATES = {
      'PA' => 0.06,
      'CA' => 0.075
  }

  def total(order, tax_rate = tax_rate(order))
    order.subtotal + order.subtotal * tax_rate
  end

  def tax_rate(order)
    TAX_RATES[order.address.state]
  end
end

order = Order.new(100.0, Address.new("123 Main St.", "Anytown", "CA"))
calc = SaleCalculator.new
puts calc.total(order)

shopping_list = [:eggs, :olives, :cheese, :salsa]
p shopping_list[0]
p shopping_list.first
p shopping_list.first(3)
p shopping_list[0, 2]
file, _, ext = 'index.html.erb'.rpartition(".")
p file
p ext
