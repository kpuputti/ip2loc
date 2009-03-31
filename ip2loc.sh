#!/usr/bin/env sh
# Simple IP address analyzer.
# Outputs DNS and location info of the given IP address.
# Requires dig, whois, and lynx to be installed.
# Usage:
# ./ip2loc.sh YOUR_IP

ip_arg=$1

echo "== DIG OUTPUT =="
dig $ip_arg
echo "== END DIG OUTPUT =="

echo "== WHOIS OUTPUT =="
whois $ip_arg
echo "== END WHOIS OUTPUT =="

# Get the source dump from the blogama API.
url=http://blogama.org/ip_query.php?output=raw\&ip=$ip_arg
source=`lynx -source $url`
echo "Received info: $source"
echo

# Split the fields from the response.
ip=`echo $source | cut -d "," -f1`
status=`echo $source | cut -d "," -f2`
country_code=`echo $source | cut -d "," -f3`
country_name=`echo $source | cut -d "," -f4`
region_code=`echo $source | cut -d "," -f5`
region_name=`echo $source | cut -d "," -f6`
city=`echo $source | cut -d "," -f7`
zip_code=`echo $source | cut -d "," -f8`
lat=`echo $source | cut -d "," -f9`
lng=`echo $source | cut -d "," -f10`

echo "             IP: $ip"
echo "         STATUS: $status"
echo "   COUNTRY CODE: $country_code"
echo "   COUNTRY NAME: $country_name"
echo "    REGION CODE: $region_code"
echo "    REGION NAME: $region_name"
echo "           CITY: $city"
echo "ZIP/POSTAL CODE: $zip_code"
echo "       LATITUDE: $lat"
echo "      LONGITUDE: $lng"

echo "Google Maps url: http://maps.google.com/maps?q=${lat},${lng}"

exit 1
