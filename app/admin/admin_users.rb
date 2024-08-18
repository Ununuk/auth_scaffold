ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation
  config.filters = false
  index do
    id_column
    column :email
    column :last_sign_in_at
    column :sign_in_count
    actions
  end

  show do
    attributes_table do
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password if f.object.new_record?
      f.input :password_confirmation if f.object.new_record?
    end
    f.actions
  end
end
