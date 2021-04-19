# README



* Ruby version
 ruby 2.6.1p33
* System dependencies
  n/a
* Database creation
  rails db:migrate


Ohction is a classic auction website where users have the ability to list their items to sell and/or buy items listed by other users.
Onction starts with a home page with all items listed by different users. Visitors to the website will be able to view the detail of any item by clicking on it, but they won’t be able to participate in any auction or list items of their own without first creating an account or logging in if they already have an account. Items displayed on home the home page will not include the items owned by the currently logged-in user, those would be accessible through the user’s account home page.
To list an item, users can simply go to their account page and add an item they want to sell through an auction. Adding an item involves setting an item title for a brief description of the item name model and pertinent detail, setting up when the user would like the auction to start and end, setting up the initial price that the auction starts with, the shipment cost, the minimum price the item can be sold for (unlike all other details, the minimum price will only be visible to the item’s owner to ensure the auction integrity and fair play), loading up some images of the item is also an option plus more descriptive information regarding the item in the form of bullet points.
Once an item is posted, it will be displayed on the home page and the item’s page will also be accessible regardless of the auction has started or not to give the buyers a chance to view the item and — if they interested — they can come back later to bid on it when the auction starts. The item’s detail displayed on the item’s page will be heavily dependent on several factors, such as if the auction for this item has started or not, or if the item is displayed by its owner (which will offer the option to edit the item if and only if the auction hasn’t started yet or hasn’t ended), or whether the item is sold, or the item wasn’t sold because the auction has ended but the minimum price hasn’t been met. The bidding option will only be displayed when the item is in an active state, which simply means that the auction is taking place right now. All bids are displayed on the bottom of the item’s page with some relevant detail such as the bidder name, the amount of the bid, and a timestamp of the placed bid both when the auction is active and after the auction closed.
Finally, the users will be able to list as many items as they like on the website for auction. To do that, users need to have a legitimate account, and from their account page, they’ll be supplied with an option to manage their items. Clicking on that will take them to the item management page through which they can see all the items they listed categorized as listed items plus all items they bought listed as bought items. For items listed by the user, an option to edit the item will be available next to it only if the item’s auction hasn’t started yet.
Munkith Abid
MUNKITH ABID FOLLOWS
Medium Staff
Medium Staff
Why Have I Chosen Software Engineer
Why Have I Chosen Software Engineer



