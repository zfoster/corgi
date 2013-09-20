module UsersHelper
  def obtain_email
    unless @user.email.present?
      form_for @user do |f|
        f.label :email, "Please provide an email address"
        f.text_field :email, {required: 'required', placeholder: 'you@domain.com'}
        f.submit 'Save Email'
      end
    end
  end
end
