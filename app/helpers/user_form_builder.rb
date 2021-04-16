class UserFormBuilder < ActionView::Helpers::FormBuilder
  def labeled_field method, options = {}
    @template.tag.div(class: "form-group") do 
      @template.label(object_name, method,'.', objectify_options(options)) <<
      @template.text_field(object_name, method, objectify_options(options))  <<
      # binding.pry
      @template.tag.span(object.field_error(method), style: 'display: inline-block;color:red')
    end
  end

  def sign_in_fields
    self.labeled_field(:email, class:"zmdi zmdi-email", placeholder:"Your Email") +
    self.labeled_field(:password, class:"zmdi zmdi-lock", placeholder:"Your Password")
  end

  def sign_in_or_update_fields
    self.labeled_field(:name, class:"zmdi zmdi-account material-icons-name", placeholder:"Your Name") + 
    self.sign_in_fields +
    self.labeled_field(:password_cofirmation, class:"zmdi zmdi-lock-outline", placeholder:"Confirm Password")
  end
end