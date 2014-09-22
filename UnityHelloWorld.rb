
require 'json'
require 'net/http'
require 'pry'
require 'pdf/reader'


# change these to your server and credentials
$Uri = URI.parse('http://tw1141ga.unitysandbox.com')
$Svc_username = 'webtwozero'
$Svc_password = 'www!web20!'
$Appname      = 'web20'
$Ehr_username = 'jmedici'

# *******************************************************************************************************
# * NAME:        UnityHelloWorld.rb
# *
# * DESCRIPTION: Example Ruby application code to illustrate basic usage of Unity with Allscripts
# *              TouchWorks/Professional EHR.
# *
# * Unpublished (c) 2014 Allscripts Healthcare Solutions, Inc. and/or its affiliates. All Rights Reserved.
# *
# * This software has been provided pursuant to a License Agreement, with Allscripts Healthcare Solutions,
# * Inc. and/or its affiliates, containing restrictions on its use. This software contains valuable trade
# * secrets and proprietary information of Allscripts Healthcare Solutions, Inc. and/or its affiliates
# * and is protected by trade secret and copyright law. This software may not be copied or distributed
# * in any form or medium, disclosed to any third parties, or used in any manner not provided for in
# * said License Agreement except with prior written authorization from Allscripts Healthcare Solutions,
# * Inc. and/or its affiliates. Notice to U.S. Government Users: This software is "Commercial Computer
# * Software."
# *
# * This is example code, not meant for production use.
# *******************************************************************************************************

def magic_action(action, userid, appname, patientid, token, param1='', param2='', param3='', param4='', param5='', param6='', data='')
	# build Magic action JSON string
	my_magic_action = {:Action => action, :AppUserID => userid, :Appname => appname,
		:PatientID => patientid, :Token => token,
		:Parameter1 => param1, :Parameter2 => param2, :Parameter3 => param3,
		:Parameter4 => param4, :Parameter5 => param5, :Parameter6 => param6, :Data => data}
	json_magic_action = JSON.generate(my_magic_action)

	# post action JSON to MagicJson endpoint, get JSON in return
	http = Net::HTTP.new($Uri.host, $Uri.port)
	request = Net::HTTP::Post.new('/Unity/UnityService.svc/json/MagicJson', {'Content-Type' => 'application/json'})
	request.body = json_magic_action
	response = http.request(request)
	json_output = response.body
	return json_output
end

# get Unity security token from GetToken endpoint
def get_token(username, password)
	# build {"Username":"un", "Password":"pw"} string
	json_service_credentials = JSON.generate({:Username => username, :Password => password})

	# send credentials to GetToken endpoint, get token UUID in return
	http = Net::HTTP.new($Uri.host, $Uri.port)
	request = Net::HTTP::Post.new('/Unity/UnityService.svc/json/GetToken', {'Content-Type' => 'application/json'})
	request.body = json_service_credentials
	response = http.request(request)
	unity_token = response.body
	return unity_token
end

# Get Unity security token
token = get_token($Svc_username, $Svc_password)
puts("Using Unity security token: #{token}\n\n")

# Call GetServerInfo Magic action; patient ID, Parameter1-6, and data not used
out = magic_action('GetServerInfo', $Ehr_username, $Appname, '', token)

puts('Output from GetServerInfo: ')
puts(JSON.pretty_generate(JSON.parse(out)))

# Call GetPatient Magic action; Parameter1-6 and data not used in this example
print('Enter a patient ID to display (e.g., 22): ')
patient = gets.chomp

itemname={vendorFileName:MyFileName.PDF}
patient_name = magic_action('GetPatient', $Ehr_username, $Appname, patient, token)
m_l = magic_action('GetClinicalSummary', $Ehr_username, $Appname, patient, token, "medications")
render :file => 'app\views\upload\uploadfile.html.erb'
# pdf = magic_action('SaveDocumentImage', $Ehr_username, $Appname, patient, token, itemname)
puts render
# puts(JSON.pretty_generate(JSON.parse(m_l)))
# puts(JSON.pretty_generate(JSON.parse(patient_name)))
