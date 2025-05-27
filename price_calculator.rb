ITEMS = {
  "milk" => { unit_price: 3.97, sale: { quantity: 2, price: 5.00 } },
  "bread" => { unit_price: 2.17, sale: { quantity: 3, price: 6.00 } },
  "apple" => { unit_price: 0.89, sale: nil },
  "banana" => { unit_price: 0.99, sale: nil }
}

def calculate_total(items)
  item_counts = Hash.new(0)
  items.each do |item|
    item = item.strip.downcase
    item_counts[item] += 1 if ITEMS.key?(item)
  end

  total = 0.0
  savings = 0.0

  puts "\n%-10s %-10s %-10s" % ["Item", "Quantity", "Price"]
  puts "-" * 32

  item_counts.each do |item, count|
    data = ITEMS[item]
    unit_price = data[:unit_price]
    sale = data[:sale]
    item_total = 0.0
    item_savings = 0.0

    if sale
      num_sales = count / sale[:quantity]
      remainder = count % sale[:quantity]

      item_total += num_sales * sale[:price] + remainder * unit_price
      original_price = count * unit_price
      item_savings = original_price - item_total
      savings += item_savings
    else
      item_total += count * unit_price
    end

    total += item_total

    puts "%-10s %-10d $%-9.2f" % [item.capitalize, count, item_total]
  end

  puts "-" * 32
  puts "\nTotal price: $#{'%.2f' % total}"
  puts "You saved $#{'%.2f' % savings} today."
end

puts "Enter the list of purchased items separated by comma"
input = gets.chomp
items = input.split(",")

calculate_total(items)
