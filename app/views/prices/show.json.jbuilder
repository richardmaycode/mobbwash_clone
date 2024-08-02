json.id @price.id
json.formatted_amount number_to_currency(@price.amount.to_f * 0.01)
json.amount @price.amount
