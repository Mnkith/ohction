module ApplicationHelper
  # include ItemsHelper::InstanceHelper
  # extend ItemsHelper::ClassHelper


  # def labeled_field form_builder, user, attrbt, classes, ph
  #   tag.div(class: "form-group") do 
  #     # binding.pry
  #     form_builder.label(attrbt, '.', class: classes) <<
  #     form_builder.text_field(attrbt, id: attrbt, placeholder: ph) << user.field_error(attrbt)
  #   end
  # end
  

  def navbar
    tag.nav(class: 'navbar navbar-expand-lg navbar-light bg-light sticky-top') do
      tag.div(class: 'collapse navbar-collapse', id: 'collapsibleNavId') do
        link_to('Home', '/', class: 'nav-link btn btn-outline-success') <<
          if current_user
            content_tag(:a, 'My Account', href: user_path(current_user), class: ' btn btn-outline-success my-2 my-sm-0',
                                          style: 'display: inline-flex;')
          end <<
          tag.a((current_user ? 'Log Out' : 'Login/Sign Up'), href: (current_user ? logout_path : login_path),
                                                              class: 'btn btn-outline-success  float-right')
      end
    end
  end

  def sign_up_in_or_update user, action 
    form_with(model: user, builder: UserFormBuilder, class: "register-form", url:(login_path if action == 'Sign in')) do |form| 
      if action == 'Sign in'
        form.sign_in_fields 
      else
        form.sign_in_or_update_fields
      end <<
      tag.div(class:"form-group form-button") do 
        form.submit(id: "signup", class: "form-submit", value: action) 
      end
    end
  end

  def action_class action 
    action == 'Update' || action == 'Sign up' ? 'signup' : 'signin'
  end

  def action_title action 
    action == 'Update' ? 'Edit account ' :  action
  end

  def action_link action 
    if action == 'Sign up'
      tag.a 'I am already member', href:login_path, class:"signin-image-link"
    elsif action == 'Sign in'
      tag.a 'Create an account', href:new_user_path, class:"signup-image-link"
    end
  end
end
