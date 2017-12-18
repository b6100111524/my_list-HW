module ListsHelper
  def list_delete_button(list) # 回傳刪除按鈕給 index.html.erb 
    return unless list.can_destroy?   # list.rb 經過判斷後 如果無法刪除的 lists 直接回傳 nil，不顯示按鈕
    link_to 'DEL', list_path(list), class: 'btn btn-danger', method: :delete, data: { confirm: 'Delete this list ?' }
  end

  def list_edit_button(list)   # 回傳編輯按鈕給 index.html.erb 
    link_to 'EDIT', edit_list_path(list), class: 'btn btn-primary'
  end
end


