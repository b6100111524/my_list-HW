class List < ApplicationRecord
  validates_presence_of :title, :duedate      #驗證欄位必須有值，可用 allow_blank: :true 允許空白
  validates :title, length: { maximum: 20 }   #驗證長度20個英文字母(中文文字)

  def can_destroy?  # 沒過期代表可刪除 回傳true > lists_controller.rb 可執行 destroy action 刪除檔案
    !overdue?       # 是不是沒過期? 定義為私有方法 private method 是否過期 避免被直接使用
  end

  private
  def overdue?      # 是不是過期? 如果比今天小表示過期 回傳true 給 can_destroy? action
    duedate < Date.today
  end
end
