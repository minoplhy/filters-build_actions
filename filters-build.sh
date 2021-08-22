MAKE_DIR=$(mktemp -d)

git clone https://github.com/minoplhy/filters-converter /filters-converter
git clone https://github.com/minoplhy/filters /aniki
mkdir $MAKE_DIR/output

wget -O $MAKE_DIR/abpvn_raw.txt https://abpvn.com/android/abpvn.txt
python3 /filters-converter/to-rpz/host_rpz_argv.py $MAKE_DIR/abpvn_raw.txt $MAKE_DIR/output/abpvn_rpz.txt

wget -O $MAKE_DIR/hosts-database-full-alive_raw.txt https://tgc.cloud/downloads/hosts.alive.txt
python3 /filters-converter/to-rpz/host_rpz_argv.py $MAKE_DIR/hosts-database-full-alive_raw.txt $MAKE_DIR/output/hosts-database-full-alive_rpz.txt

wget -O $MAKE_DIR/hostsVN-all_raw.txt https://github.com/bigdargon/hostsVN/raw/master/filters/domain-adservers-all.txt
python3 /filters-converter/to-rpz/domains_rpz_argv.py $MAKE_DIR/hostsVN-all_raw.txt $MAKE_DIR/output/hostsVN-all_rpz.txt

wget -O $MAKE_DIR/someonewhocares_raw.txt https://someonewhocares.org/hosts/hosts
python3 /filters-converter/to-rpz/host_rpz_argv.py $MAKE_DIR/someonewhocares_raw.txt $MAKE_DIR/output/someonewhocares_rpz.txt

wget -O $MAKE_DIR/stevenblack_raw.txt https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
python3 /filters-converter/to-rpz/host_rpz_argv.py $MAKE_DIR/stevenblack_raw.txt $MAKE_DIR/output/stevenblack_rpz.txt

wget -O $MAKE_DIR/stevenblack-f-s_raw.txt https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-social/hosts
python3 /filters-converter/to-rpz/host_rpz_argv.py $MAKE_DIR/stevenblack-f-s_raw.txt $MAKE_DIR/output/stevenblack-f-s_rpz.txt

wget -O $MAKE_DIR/1Hosts-wildcards-lite_raw.txt https://badmojr.github.io/1Hosts/Lite/wildcards.txt
python3 /filters-converter/to-rpz/domains_wildcards_rpz_argv.py $MAKE_DIR/1Hosts-wildcards-lite_raw.txt $MAKE_DIR/output/1Hosts-wildcards-lite_rpz.txt

wget -O $MAKE_DIR/1Hosts-wildcards-Pro_raw.txt https://badmojr.github.io/1Hosts/Pro/wildcards.txt
python3 /filters-converter/to-rpz/domains_wildcards_rpz_argv.py $MAKE_DIR/1Hosts-wildcards-Pro_raw.txt $MAKE_DIR/output/1Hosts-wildcards-Pro_rpz.txt

wget -O $MAKE_DIR/1Hosts-wildcards-Xtra_raw.txt https://badmojr.github.io/1Hosts/Xtra/wildcards.txt
python3 /filters-converter/to-rpz/domains_wildcards_rpz_argv.py $MAKE_DIR/1Hosts-wildcards-Xtra_raw.txt $MAKE_DIR/output/1Hosts-wildcards-Xtra_rpz.txt

wget -O $MAKE_DIR/adguard-dns_raw.txt https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_15_DnsFilter/filter.txt
python3 /filters-converter/to-rpz/adguard-host_rpz_argv.py $MAKE_DIR/adguard-dns_raw.txt $MAKE_DIR/output/adguard-dns_rpz.txt

wget -O $MAKE_DIR/cname-tracker_raw.txt https://github.com/AdguardTeam/cname-trackers/raw/master/combined_disguised_trackers.txt
python3 /filters-converter/to-rpz/adguard-host_rpz_argv.py $MAKE_DIR/cname-tracker_raw.txt $MAKE_DIR/output/cname-tracker_rpz.txt

wget -O $MAKE_DIR/cname-original_raw.txt https://github.com/AdguardTeam/cname-trackers/raw/master/combined_original_trackers.txt
python3 /filters-converter/to-rpz/adguard-host-wildcards_rpz_argv.py $MAKE_DIR/cname-original_raw.txt $MAKE_DIR/output/cname-tracker_rpz.txt

wget -O $MAKE_DIR/adguard-exceptions_raw.txt https://github.com/AdguardTeam/AdGuardSDNSFilter/raw/master/Filters/exceptions.txt
python3 /filters-converter/to-rpz/adguard-host_rpz_argv.py $MAKE_DIR/adguard-exceptions_raw.txt $MAKE_DIR/output/adguard-exceptions_rpz.txt

cd /aniki
echo $API_TOKEN_GITHUB > token.txt
gh auth login --with-token < token.txt
rm token.txt
gh release create filters-build -t "FILTERS-BUILD IN RELEASES" $MAKE_DIR/output/*