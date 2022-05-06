class Friend < ApplicationRecord
    belongs_to :user
    
    VALID_EMAIL_REGEX= /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
    validates :email , presence: true,uniqueness:{case_sensetive:false},
    format:{with:VALID_EMAIL_REGEX,multiline:true}
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :phone, presence: true

    scope :searching, ->(params) { 
        where('first_name LIKE ? OR last_name LIKE ? OR phone LIKE ? OR email LIKE ? OR first_name || " " || last_name LIKE ?', 
            ["%#{params}%"], 
            ["%#{params}%"], 
            ["%#{params}%"], 
            ["%#{params}%"],
            ["%#{params}%"]) 
    }

    def full_name
        return self.first_name + ' ' + self.last_name
    end
end
