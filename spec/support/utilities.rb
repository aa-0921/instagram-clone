def full_title(page_title)
  base_title = "Instagram-clone"
  if page_title.empty?
    base_title
  else
    "#{page_title} | #{base_title}"
  end
end

def sign_in_as(user)
  post login_path, params: { session: {
    email: user.email,
    password: user.password,
  } }
end
