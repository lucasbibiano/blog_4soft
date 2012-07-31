# -*- encoding : utf-8 -*-
class Post < ActiveRecord::Base
  attr_accessible :content, :name, :title

  validates :name,  :presence => { :message => "Nome não pode ser vazio!" }   
  validates :title, :presence => { :message => "Deve haver um título para o post" },
                    :length => { :minimum => 5,
                      :message => "Tamanho mínimo do título é de 5 caracteres" }
end
