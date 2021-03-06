task :dsa_letters_bootstrap => :environment do
  Template.delete_all
  Entity.delete_all
  Asset.delete_all
  
  template = Template.create( :name => "DSA Transcription Template",
                              :description => "A template for transcribing letters",
                              :project => "David Simonsen Archive",
                              :display_width => 600,
                              :default_zoom => 1.5)
                          
  
  
  letter_entity = Entity.create( :name => "Letter Data",
                                  :description => "",
                                  :help => "Please fill in all of the values",
                                  :resizeable => false,
                                  :width => 450,
                                  :height => 80)

  sender_entity = Entity.create( :name => "Sender",
                                 :description => "Data about the sender of a letter",
                                 :help => "Please fill in all of the values",
                                 :resizeable => false,
                                 :width => 450,
                                 :height => 80)

  recipient_entity = Entity.create( :name => "Recipient",
                                 :description => "Data about the recipient of a letter",
                                 :help => "Please fill in all of the values",
                                 :resizeable => false,
                                 :width => 450,
                                 :height => 80)

  title_field = Field.new( :name => "Title",
                          :field_key => "title",
                          :kind => "text",
                          :initial_value => "--",
                          :options => { :text => { :max_length => 30, :min_length => 0 } })

  sender_field = Field.new(:name => "Sender",
                          :field_key => "sender",
                          :kind => "text",
                          :initial_value => "--",
                          :options => { :text => { :max_length => 30, :min_length => 0 } })
                          
  sender_type = Field.new(:name => "Sender Type",
                              :field_key => "sender_type",
                              :kind => "select",
                              :initial_value => "--",
                              :options => { :select => ['Conference', 'Corporate', 'Family', 'Personal'] })
                                
  recipient_field = Field.new(:name => "Recipient",
                              :field_key => "recipient",
                              :kind => "text",
                              :initial_value => "--",
                              :options => { :text => { :max_length => 30, :min_length => 0 } })

  recipient_type = Field.new(:name => "Recipient Type",
                          :field_key => "recipient_type",
                          :kind => "select",
                          :initial_value => "--",
                          :options => { :select => ['Conference', 'Corporate', 'Family', 'Personal'] })

  resource_type = Field.new(:name => "Resource Type",
                             :field_key => "resource_type",
                             :kind => "select",
                             :initial_value => "--",
                             :options => { :select => ['Text', 'Cartographic', 'Still image', 'Moving image', 'Notated music', 'Sound recording'] })

  extent_field = Field.new(:name => "Extent",
                            :field_key => "extent_field",
                            :kind => "text",
                            :initial_value => "--",
                            :options => { :text => { :max_length => 5, :min_length => 0 } })

  language_field = Field.new(:name => "Language",
                           :field_key => "language_field",
                           :kind => "select",
                           :initial_value => "--",
                           :options => { :select => ['Danish', 'English', 'Yiddish', 'Hebrew', 'German'] })

  person_field = Field.new(:name => "Persons Mentioned",
                           :field_key => "person_field",
                           :kind => "text",
                           :initial_value => "--",
                           :options => { :text => { :max_length => 30, :min_length => 0 } })


  date_field = Field.new( :name => "Date",
                          :field_key => "date",
                          :kind => "date",
                          :initial_value => "",
                          :options => {})

  location_field = Field.new(:name => "Location of Sender",
                             :field_key => "location_field",
                             :kind => "text",
                             :initial_value => "",
                             :options => {})


  letter_entity.fields << title_field
  letter_entity.fields << date_field
  letter_entity.fields << resource_type
  letter_entity.fields << extent_field
  letter_entity.fields << language_field
  letter_entity.fields << person_field
  letter_entity.fields << location_field
  letter_entity.save

  sender_entity.fields << sender_field
  sender_entity.fields << sender_type
  sender_entity.save

  recipient_entity.fields << recipient_field
  recipient_entity.fields << recipient_type
  recipient_entity.save

  template.entities << letter_entity
  template.entities << sender_entity
  template.entities << recipient_entity

  template.save 

  #generate a single asset and a single user for testing just now
  correspondence = AssetCollection.create(:title => "David Simonsen Archive", :author => "Various", :extern_ref => "http://da.wikipedia.org/wiki/David_Simonsen")
  
  Asset.create(:location => "http://www.kb.dk/imageService/w1000/online_master_arkiv_3/non-archival/Letters/judsam/2010/jan/dsa/jaf-joi/dsa_jaf-joi_0590.jpg", :display_width => 1000, :height => 1237, :width => 1000, :template => template, :asset_collection => correspondence)
  Asset.create(:location => "http://www.kb.dk/imageService/w1000/online_master_arkiv_3/non-archival/Letters/judsam/2010/jan/dsa/jaf-joi/dsa_jaf-joi_0591.jpg", :display_width => 1000, :height => 1237, :width => 1000, :template => template, :asset_collection => correspondence)
  Asset.create(:location => "http://www.kb.dk/imageService/w1000/online_master_arkiv_3/non-archival/Letters/judsam/2010/jan/dsa/jaf-joi/dsa_jaf-joi_0592.jpg", :display_width => 1000, :height => 1237, :width => 1000, :template => template, :asset_collection => correspondence)

  ZooniverseUser.create()
  
end