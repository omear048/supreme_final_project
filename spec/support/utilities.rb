def sign_in(user)
  visit new_user_session_path
  fill_in 'Email',    with: user.email
  fill_in 'Password', with: user.password
  click_button('Log in')
end

def sign_out
  visit root_path
  click_link "Sign Out"
end

def list_product
  visit new_product_path
  fill_in 'Title', with: "Supreme Box Logo Hoodie"
  fill_in 'Price', with: 750
  fill_in 'Picture url', with: "https://stockx.imgix.net/products/streetwear/Supreme-Compact-Logo-Hoodie-Black.jpg?fit=fill&bg=FFFFFF&w=358&h=255&auto=format,compress&trim=color&q=90&dpr=2&updated_at=1539713149"
  click_button('List Product')
end
