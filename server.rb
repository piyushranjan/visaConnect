require 'java'
require "./VisaConnect.jar"
require "json"
require "date"
require "sinatra"

java_import com.piyushranjan.VisaConnect

get "/" do
  File.read(File.join('public', 'form.html'))
end

post "/do" do
  json = JSON.parse(File.read("request.json"))
  json["SystemsTraceAuditNumber"] = (Time.now.to_i/10000).to_i.to_s
  json["RetrievalReferenceNumber"] = DateTime.now.strftime("%Y%m%d%H%M")
  json["SenderAccountNumber"] = params[:sender_account_number]
  json["TransactionCurrency"] = params[:currency]
  json["SenderName"] = params[:sender_name]
  json["RecipientCardPrimaryAccountNumber"] = params[:recipient_card_number]
  json["Amount"] = params[:amount]
  p File.read("request.json")
  p json.to_json
  return VisaConnect.doIt(json.to_json)
end
