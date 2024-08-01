module Vendor::VendorHelper
  def empty_state_titles(with)
    case with
    when "awaiting_bids"
      "No Available Requests"
    when "assigned"
      "No Active Requests"
    when "completed"
      "No Completed Requests"
    else
      "No Items Found"
    end
  end

  def empty_state_descriptions(with)
    case with
    when "awaiting_bids"
      "Currently there are no requests available in your area for bidding, please check back later"
    when "assigned"
      "You have no requests scheduled for your organization, requests that accept your bid will appear here."
    when "completed"
      "You don't have an completed requests logged in the last 30 days, once you complete a request it will appear here"
    else
      "There are no items given your current selections."
    end
  end
end
