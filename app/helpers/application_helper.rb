module ApplicationHelper
  # include ItemsHelper::InstanceHelper
  # extend ItemsHelper::ClassHelper

  def status_based_display item
    if item.sold?
      tag.li 'This item is sold', class: 'list-group-item'
    elsif item.owner? current_user
      tag.li 'Your the owner of this item', class: 'list-group-item'
      item.active? ? tag.li("Can't Edit an item under active auction", class: 'list-group-item') : tag.li(tag.a("Edit this item", href: edit_item_path(item)), class: 'list-group-item')
    elsif item.active?
      # tag.li(item.title, class: 'list-group-item') <<
      form_with(Bid.new) do |f|
        f.number_field :amount
        f.submit 'Place your bid'
      end
      
    end
  
  end

  def navbar
    tag.nav(class: 'navbar navbar-expand-lg navbar-light bg-light sticky-top') do
      tag.div(class: 'collapse navbar-collapse', id: 'collapsibleNavId') do
        link_to('Home', '/', class: 'nav-link btn btn-outline-success') <<
          if current_user
            # form_tag(class:"form-inline my-2 my-lg-0") do
            content_tag(:a, 'My Account', href: user_path(current_user), class: ' btn btn-outline-success my-2 my-sm-0',
                                          style: 'display: inline-flex;')
            # end
          end <<
          # form_tag(class:"form-inline my-2 my-lg-0") do
          tag.a((current_user ? 'Log Out' : 'Login/Sign Up'), href: (current_user ? logout_path : login_path),
                                                              class: 'btn btn-outline-success  float-right')
        # end
      end
    end
  end
end
