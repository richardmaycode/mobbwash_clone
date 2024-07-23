module Vendor::RequestsHelper
  def classes_for_request_status(status)
    case status
    when "awaiting_payment"
      "bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300"
    when "available"
      "bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-300"
    when "assigned"
      "bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-300"
    when "completed"
      "bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300"
    when "expired"
      "bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300"
    else
      "bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-300"
    end
  end
end
