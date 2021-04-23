module ApplicationHelper
  def navbar
    tag.nav(class: 'navbar navbar-expand-lg navbar-light bg-light sticky-top') do
      tag.div(class: 'collapse navbar-collapse', id: 'collapsibleNavId') do
        link_to('Home', '/', class: 'nav-link btn btn-outline-success') <<
          if current_user
            content_tag(:a, 'My Account', href: user_path(current_user), class: ' btn btn-outline-success my-2 my-sm-0',
                                          style: 'display: inline-flex;')
          end <<
          link_to_if(current_user, 'Log out', logout_path, method: 'DELETE',
                                                           class: 'btn btn-outline-success  float-right') do
            link_to('Login/Sign Up', login_path, class: 'btn btn-outline-success  float-right')
          end
      end
    end
  end

  def sign_up_in_or_update(user, action)
    form_with(model: user, builder: UserFormBuilder, class: 'register-form',
              url: (login_path if action == 'Sign in')) do |form|
      if action == 'Sign in'
        form.sign_in_fields
      else
        form.sign_in_or_update_fields
      end <<
        tag.div(class: 'form-group form-button') do
          form.submit(id: 'signup', class: 'form-submit', value: action)
        end
    end
  end

  private

  def action_class(action)
    ['Update', 'Sign up'].include?(action) ? 'signup' : 'signin'
  end

  def action_title(action)
    action == 'Update' ? 'Edit account ' : action
  end

  def action_link(action)
    link_to_if(action == 'Sign up', 'I am already member', login_path, class: 'signin-image-link') do
      link_to 'Create an account', new_user_path, class: 'signup-image-link'
    end
  end
end
