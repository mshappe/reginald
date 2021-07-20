module UsersHelper
  def bless_button(user, role)
    data = {}
    data = { confirm: 'Are you sure you want to make an admin?' } if role == :admin
    link_to "Make #{role.capitalize}", bless_user_path(user, user: { role: role }), method: :put, class: 'btn btn-primary btn-sm', data: data
  end

  def curse_button(user, role)
    link_to "Revoke #{role.capitalize}", curse_user_path(user, user: { role: role }), method: :put, class: 'btn btn-danger btn-sm',
      data: { confirm: 'Are you sure you want to revoke this role?' }
  end
end
