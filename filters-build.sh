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

wget -O $MAKE_DIR/stevenblack-f_raw.txt https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts
python3 /filters-converter/to-rpz/host_rpz_argv.py $MAKE_DIR/stevenblack-f_raw.txt $MAKE_DIR/output/stevenblack-f_rpz.txt

wget -O $MAKE_DIR/adguard-dns_raw.txt https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_15_DnsFilter/filter.txt
python3 /filters-converter/to-rpz/adguard-host_rpz_argv.py $MAKE_DIR/adguard-dns_raw.txt $MAKE_DIR/output/Adguard-dns_rpz.txt

wget -O $MAKE_DIR/cname-tracker_raw.txt https://github.com/AdguardTeam/cname-trackers/raw/master/combined_disguised_trackers.txt
python3 /filters-converter/to-rpz/adguard-host_rpz_argv.py $MAKE_DIR/cname-tracker_raw.txt $MAKE_DIR/output/Adguard-cname-tracker_rpz.txt

wget -O $MAKE_DIR/cname-original_raw.txt https://github.com/AdguardTeam/cname-trackers/raw/master/combined_original_trackers.txt
python3 /filters-converter/to-rpz/adguard-host-wildcards_rpz_argv.py $MAKE_DIR/cname-original_raw.txt $MAKE_DIR/output/Adguard-cname-original_rpz.txt

wget -O $MAKE_DIR/adguard-exceptions_raw.txt https://github.com/AdguardTeam/AdGuardSDNSFilter/raw/master/Filters/exceptions.txt
python3 /filters-converter/to-rpz/adguard-host_rpz_argv.py $MAKE_DIR/adguard-exceptions_raw.txt $MAKE_DIR/output/Adguard-exceptions_rpz.txt

mkdir $MAKE_DIR/Bromite
cd $MAKE_DIR/Bromite
wget https://github.com/bromite/filters/releases/download/92.0.4515.103/ruleset_converter
chmod +x ruleset_converter
curl https://raw.githubusercontent.com/minoplhy/Bromite-custom-adblock/main/wget-all-filters.txt | bash
curl https://raw.githubusercontent.com/minoplhy/Bromite-custom-adblock/main/lazy-converter.txt | bash >/dev/null
cp filters.dat $MAKE_DIR/output/filters.dat

cd /aniki
echo $API_TOKEN_GITHUB > token.txt
gh auth login --with-token < token.txt
rm token.txt
gh release delete "filters-build" -y
git tag -d "filters-build"
git push origin :"filters-build"
gh release create filters-build -t "FILTERS-BUILD IN RELEASES" $MAKE_DIR/output/* -F /aniki/Resources/Releases_filters-build.md
