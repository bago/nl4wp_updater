#!/bin/bash
######################################################
#
# Script per il porting automatico di MC4WP -> NL4WP
# USAGE: ./upgrade_to_nl [MC4WP_DIR] [MC4WP_VERSION]
#
######################################################
function ProgressBar {
# Process data
    let _progress=(${1}*100/${2}*100)/100
    let _done=(${_progress}*4)/10
    let _left=40-$_done
# Build progressbar string lengths
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")

# 1.2 Build progressbar strings and print the ProgressBar line
# 1.2.1 Output example:
# 1.2.1.1 Progress : [########################################] 100%
printf "\rProgress : [${_fill// /#}${_empty// /-}] ${_progress}%% ${3}                                         " 
sleep 0.2;
}

# Prendo i due parametri directory e version (version serve per modificare i readme e i commenti)
DIRECTORY="$1"
VERSION="$2"

# Renaming completo di tutti i riferimenti a Mailchimp nel codice. 
# Mailchimp -> Newsletter
# mailchimp -> newsletter
# MC4WP -> NL4WP
# mc4wp -> nl4wp

grep --binary-file=without-match -rl mailchimp $DIRECTORY | xargs sed -i '' 's/mailchimp/newsletter/g'
ProgressBar 5 100 "Renaming MailChimp -> Newsletter"
grep --binary-file=without-match -rl MailChimp $DIRECTORY | xargs sed -i '' 's/MailChimp/Newsletter/g'
ProgressBar 10 100 "Renaming MailChimp -> Newsletter"
grep --binary-file=without-match -rl mc4wp $DIRECTORY | xargs sed -i '' 's/mc4wp/nl4wp/g'
ProgressBar 20 100 "Renaming MailChimp -> Newsletter"
grep --binary-file=without-match -rl MC4WP $DIRECTORY | xargs sed -i '' 's/MC4WP/NL4WP/g'

# Al momento manteniamo i riferimenti al sito originale mc4wp.com
ProgressBar 30 100 "Renaming MailChimp -> Newsletter"
grep --binary-file=without-match -rl nl4wp.com $DIRECTORY | xargs sed -i '' 's/nl4wp.com/mc4wp.com/g'

# Renaming anche delle cartelle
ProgressBar 40 100 "Renaming MailChimp -> Newsletter"
find $DIRECTORY/ -iname "*mailchimp*" | sed -e "p;s/mailchimp/newsletter/" | xargs -n2 mv

# Aggiunta di un return false; alla funzione show di /includes/admin/class-review-notice.php // evita di mostrare la richiesta di recensione
ProgressBar 50 100 "Hiding unwanted texts"
perl -0777 -i -pe 's/(public function show\(\) \{)/$1\n\/* NL_CHANGED - start\n* non mostra nulla\n*\/\nreturn false;\n\/* NL_CHANGED - end *\//g' $DIRECTORY/includes/admin/class-review-notice.php

# Imposta la versione premium del plugin (serve ad evitare testi pubblicitari), direttamente nel file principale /newsletter-for-wp.php
ProgressBar 55 100 "Hiding unwanted texts"
perl -0777 -i -pe 's/define\( \x27NL4WP_VERSION\x27, \x27(.*)\x27 \);/define\( \x27NL4WP_VERSION\x27, \x27$1\x27\);\n\/* NL_CHANGED - start\n* imposta la versione pro\n*\/\ndefine \(\x27NL4WP_PREMIUM_VERSION\x27, \x27$1\x27\);\n\/* NL_CHANGED - end *\//g' $DIRECTORY/newsletter-for-wp.php

# Evita la stampa del footer /includes/admin/class-admin-texts.php
ProgressBar 60 100 "Hiding unwanted texts"
perl -0777 -i -pe 's/(\$text = sprintf\( \x27If you enjoy.*\);)/\/* NL_COMMENT - start\n* Non mostra footer\n*\/\n\/\/$1\n\/* NL_COMMENT - end *\//g' $DIRECTORY/includes/admin/class-admin-texts.php

# Non mostra le funzioni relative all'usage tracking - disabilitandole /includes/views/other-settings.php
ProgressBar 65 100 "Hiding unwanted texts"
perl -0777 -i -pe 's/(<h3><\?php \_e\( \x27Miscellaneous settings\x27,[\s\S]*class=\"form-table\">)/$1\n<\?php\n\/* NL_COMMENT - start\n* Non mostra usage tracking settings\n*\/\n\/*/g' $DIRECTORY/includes/views/other-settings.php
ProgressBar 70 100 "Hiding unwanted texts"
perl  -0777 -i -pe 's/(<\?php \_e\( \x27This is what we track.\x27, \x27newsletter-for-wp\x27 \); \?>[\s\S]*<\/tr>)(\n\t\t\t<tr>)/$1\n*\/\n\?>$2/g' $DIRECTORY/includes/views/other-settings.php

# Disabilita altri blocchi del footer (translation notice, github e disclaimer) - /includes/views/parts/admin-footer.php
ProgressBar 75 100 "Hiding unwanted texts"
perl  -0777 -i -pe 's/(add_action\(.*\);)/\/* NL_COMMENT - start\n* Non mostra translation notice, github e disclaimer\n*\/\n\/*$1\n*\/\n/g' $DIRECTORY/includes/views/parts/admin-footer.php

# Disabilita i box a destra nella sidebar - /includes/views/parts/admin-sidebar.php
ProgressBar 80 100 "Hiding unwanted texts"
perl  -0777 -i -pe 's/(add_action\(.*\);)/\/* NL_COMMENT - start\n* Non mostra help e boxilla\n*\/\n\/*$1\n*\/\n/g' $DIRECTORY/includes/views/parts/admin-sidebar.php

# Non mostra link di editing delle opzioni che riportava al pannello di mailchimp direttamente - /includes/views/parts/lists-overview.php
ProgressBar 85 100 "Hiding unwanted texts"
perl  -0777 -i -pe 's/(echo sprintf\( \x27<p class=\"alignright\".*\);)/\/* NL_COMMENT - start\n* Non mostra link editing\n*\/\n\/*$1\n*\/\n/g' $DIRECTORY/includes/views/parts/lists-overview.php

# Elimina i link al knoledgebase di MC4WP
ProgressBar 87 100 "Hiding unwanted links"
perl -0777 -i -pe 's/<\?php printf\( \x27 <a href=\"\%s\" target=\"_blank\">\x27 \. __\( \x27What does this do\?\x27, \x27newsletter-for-wp\x27 \) \. \x27<\/a>\x27, \x27https:\/\/kb\.mc4wp\.com\/what-does-replace-groupings-mean\/\x27 \); \?>//g' $DIRECTORY/includes/integrations/views/integration-settings.php
perl -0777 -i -pe 's/<\?php printf\( \x27 <a href=\"\%s\" target=\"_blank\">\x27 \. __\( \x27What does this do\?\x27, \x27newsletter-for-wp\x27 \) \. \x27<\/a>\x27, \x27https:\/\/kb\.mc4wp\.com\/what-does-replace-groupings-mean\/#utm_source=wp-plugin&utm_medium=newsletter-for-wp&utm_campaign=settings-page\x27 \); \?>//g' $DIRECTORY/includes/forms/views/tabs/form-settings.php
perl -0777 -i -pe 's/(\$links\[\] = \x27<a href=\"https:\/\/kb\.mc4wp\.com\/#utm_source=wp-plugin&utm_medium=newsletter-for-wp&utm_campaign=plugins-page\">\x27\. __\( \x27Documentation\x27, \x27newsletter-for-wp\x27 \) \. \x27<\/a>\x27;)/\/\/ $1/g' $DIRECTORY/includes/admin/class-admin-texts.php


# Mette a posto copyright e readme
ProgressBar 88 100 "Adding Copyrights"
perl -0777 -i -pe 's/<\?php[\s\S]*This program is free software:/<\?php\n\/\*\nPlugin Name: Newsletter for WordPress\nPlugin URI: https:\/\/github\.com\/mailrouter\/Newsletter-for-Wordpress\nDescription: Newsletter for WordPress by mailrouter. Aggiunge vari metodi di iscrizione newsletter al tuo sito.\nVersion: \[nl4wp_version\]\nAuthor: mailrouter\nText Domain: newsletter-for-wp\nDomain Path: \/languages\nLicense: GPL v3\n\nNewsletter for WordPress\nCopyright (C) 2017, Void Labs snc, info@voidlabs.it\nforked from\nMailchimp for WordPress\nCopyright (C) 2012-2017, Danny van Kooten, hi@dannyvankooten.com\n\nintegrates\nPlugin Update Checker Library 4.3\nhttp:\/\/w-shadow\.com\/\nCopyright 2017 Janis Elsts\nReleased under the MIT license. See license.txt for details.\n\nThis program is free software:/g' $DIRECTORY/newsletter-for-wp.php
perl -0777 -i -pe 's/\[nl4wp_version\]/'"$VERSION"'/g' $DIRECTORY/newsletter-for-wp.php
ProgressBar 89 100 "Modify Readme.txt"
cp ./rs/readme.txt $DIRECTORY
perl -0777 -i -pe 's/\[nl4wp_version\]/'"$VERSION"'/g' $DIRECTORY/readme.txt
cat $DIRECTORY/CHANGELOG.md >> $DIRECTORY/readme.txt

# Sistema un paio di "bug" nel dominio delle traduzioni e qualche localizzazione mancante
perl -0777 -i -pe 's/nl4wp-ecommerce/newsletter-for-wp/g' $DIRECTORY/includes/views/other-settings.php
perl -0777 -i -pe 's/echo \$integration->description;/_e\(\$integration->description, \x27newsletter-for-wp\x27\);/g' $DIRECTORY/includes/integrations/views/integrations.php
perl -0777 -i -pe 's/echo \$integration->description;/_e\(\$integration->description, \x27newsletter-for-wp\x27\);/g' $DIRECTORY/includes/integrations/views/integration-settings.php
perl -0777 -i -pe 's/<h3>Merge Fields<\/h3>/<h3><\?php _e\(\x27Merge Fields\x27, \x27newsletter-for-wp\x27\);\?><\/h3>/g' $DIRECTORY/includes/views/parts/lists-overview.php
perl -0777 -i -pe 's/<th>Name<\/th>/<th><\?php _e\(\x27Name\x27, \x27newsletter-for-wp\x27\);\?><\/th>/g' $DIRECTORY/includes/views/parts/lists-overview.php
perl -0777 -i -pe 's/<th>Tag<\/th>/<th><\?php _e\(\x27Tag\x27, \x27newsletter-for-wp\x27\);\?><\/th>/g' $DIRECTORY/includes/views/parts/lists-overview.php
perl -0777 -i -pe 's/<th>Type<\/th>/<th><\?php _e\(\x27Type\x27, \x27newsletter-for-wp\x27\);\?><\/th>/g' $DIRECTORY/includes/views/parts/lists-overview.php
perl -0777 -i -pe 's/<th>Interests<\/th>/<th><\?php _e\(\x27Interests\x27, \x27newsletter-for-wp\x27\);\?><\/th>/g' $DIRECTORY/includes/views/parts/lists-overview.php
perl -0777 -i -pe 's/<h3>Interest Categories<\/h3>/<h3><\?php _e\(\x27Interest Categories\x27, \x27newsletter-for-wp\x27\);\?><\/h3>/g' $DIRECTORY/includes/views/parts/lists-overview.php
perl -0777 -i -pe 's/<strong style=\"display: block; border-bottom: 1px solid #eee;\">Name<\/strong>/<strong style=\"display: block; border-bottom: 1px solid #eee;\"><\?php _e\(\x27Name\x27, \x27newsletter-for-wp\x27\);\?><\/strong>/g' $DIRECTORY/includes/views/parts/lists-overview.php

# cambia gli hash del composer
HASH_a=$(grep ".*ComposerAutoloaderInit\(.*\)::getLoader.*" $DIRECTORY/vendor/autoload_52.php | sed -e "s/.*ComposerAutoloaderInit\(.*\)::getLoader.*/\1/" )
HASH_b=$(grep ".*class ComposerAutoloaderInit\(.*\)" $DIRECTORY/vendor/composer/autoload_real.php | sed -e "s/.*class ComposerAutoloaderInit\(.*\)/\1/" )
grep --binary-file=without-match -rl $HASH_a $DIRECTORY | xargs sed -i '' 's/'"$HASH_a"'/'"$HASH_a"'_nl/g'
grep --binary-file=without-match -rl $HASH_b $DIRECTORY | xargs sed -i '' 's/'"$HASH_b"'/'"$HASH_b"'_nl/g'

# Copia dei file di lingua in italiano 
ProgressBar 90 100 "Copy Language and Api integration"
cp ./rs/newsletter-for-wp-it_IT.mo $DIRECTORY/languages
cp ./rs/newsletter-for-wp-it_IT.po $DIRECTORY/languages

# Copia delle modifiche alla gestione API (il cuore del tutto)
cp ./rs/*.php $DIRECTORY/includes/api
cp ./rs/*.inc $DIRECTORY/includes/api
cp ./rs/*.png $DIRECTORY/assets/img

# Copia e installazione del Plugin Update Checker
ProgressBar 95 100 "Copy Plugin Update Checker"
cp -R ./rs/plugin-update-checker $DIRECTORY/plugin-update-checker
REPOSITORY="https:\/\/github.com\/mailrouter\/Newsletter-for-Wordpress\/"
perl  -0777 -i -pe 's/(\/\/ Prevent direct file access\ndefined\( \x27ABSPATH\x27 \) or exit;)/\/* PLUGIN AUTOUPDATE *\/\nrequire \x27plugin-update-checker\/plugin-update-checker.php\x27;\n\$myUpdateChecker = Puc_v4_Factory::buildUpdateChecker\(\n\t\x27'"$REPOSITORY"'\x27,\n\t__FILE__,\n\t\x27newsletter-for-wp\x27\n);\n\/* end *\/\n$1/g' $DIRECTORY/newsletter-for-wp.php

# Tutto a posto!
ProgressBar 100 100 "DONE!!" 
printf "\n\n";