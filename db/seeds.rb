# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

company_name_list = %w[A AA AAC AACG AACQ AACQU AAIC AAL AAMC AAME AAN AAOI AAON AAP AAPL AAT AAU AAWW AB ABB ABBV ABC ABCB ABCL ABCM ABEO ABEV ABG ABGI ABIO ABM ABMD ABNB ABR ABST ABT ABTX ABUS AC ACA ACAC ACACU ACACW ACAD ACAHU ACB ACBAU ACBI ACC ACCD ACCO ACEL ACER ACET ACEV ACEVU ACEVW ACGL ACGLO ACGLP ACH ACHC ACHL ACHV ACI ACIC ACII ACIU ACIW ACKIT ACKIU ACKIW ACLS ACM ACMR ACN ACNB ACND ACOR ACP ACQRU ACR ACRE ACRS ACRX ACST ACTC ACTCU ACTCW AGS AGTC AGX AGYS AHAC AHACU AHACW AHC AHCO AHH AHPI AHT AI AIC AIF AIG AIH AIHS AIKI AIM AIMC AIN AINC AINV AIO AIR AIRC AIRG AIRI AIRT AIRTP AIRTW AIT AIV]
company_name_list.each{|name| Company.create!(name: name)}

Client.create!(name: 'Client nr 1')
Client.create!(name: 'Client nr 2')

Company.first(40).each{|company| Client.first.client_companies.create!(company: company, weight: 0.025)}
Company.first(45).last(40).each{|company| Client.second.client_companies.create!(company: company, weight: 0.025)}

AdminUser.create!(first_name: 'Admin', last_name: 'User', email: 'admin@user.test', password: 'passwd123', password_confirmation: 'passwd123')

Client.first.notifications.create!(title: 'Test notification1', desc: 'This is a test notification')
Client.first.notifications.create!(title: 'Test notification2', desc: 'This is a test notification 2')
Client.first.notifications.create!(title: 'Test notification3', desc: 'This is a test notification 3')
