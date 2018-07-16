git clone git@github.com:bago/nl4wp_updater.git updater

wget https://github.com/ibericode/mailchimp-for-wordpress/
unzip di mailchimp-for-wordpress

mv mailchimp-for-wordpress-4.2.4/ origin

cd updater/
./upgrade_to_nl.sh ../origin 4.2.4 4.9.7

Progress : [##--------------------------------------] 5% Renaming MailChimp -> Newsletter
Progress : [####------------------------------------] 10% Renaming MailChimp -> Newsletter
Progress : [########--------------------------------] 20% Renaming MailChimp -> Newsletter
Progress : [############----------------------------] 30% Renaming MailChimp -> Newsletter
Progress : [################------------------------] 40% Renaming MailChimp -> Newsletter
Progress : [##################----------------------] 45% Change encoding of email
--> Matched 01: Richiesta recensione in /includes/admin/class-review-notice.php
Progress : [####################--------------------] 50% Hiding unwanted texts
--> Matched 01: Richiesta recensione in /includes/admin/class-review-notice.php
Progress : [######################------------------] 55% Hiding unwanted texts
--> Matched 02: Costante Versione in /newsletter-for-wp.php
Progress : [########################----------------] 60% Hiding unwanted texts
--> Matched 03: Footer in /includes/admin/class-admin-texts.php
Progress : [##########################--------------] 65% Hiding unwanted texts
--> Matched 04: Usage Tracking in /includes/views/other-settings.php
Progress : [############################------------] 70% Hiding unwanted texts
--> Matched 05: Usage Tracking in /includes/views/other-settings.php
Progress : [##############################----------] 75% Hiding unwanted texts
--> Matched 06: Translation notice, github e disclaimer in /includes/views/parts/admin-footer.php
Progress : [################################--------] 80% Hiding unwanted texts
--> Matched 07: Sidebar in /includes/views/parts/admin-sidebar.php
Progress : [##################################------] 85% Hiding unwanted texts
--> Matched 08: Sidebar in /includes/views/parts/lists-overview.php
Progress : [##################################------] 87% Hiding unwanted links
--> Matched 09: Knoledgebase in /includes/integrations/views/integration-settings.php
--> Matched 10: Knoledgebase in /includes/forms/views/tabs/form-settings.php
--> Matched 11: Knoledgebase in /includes/admin/class-admin-texts.php
Progress : [###################################-----] 88% Adding Copyrights
--> Matched 12: Copyrights in /newsletter-for-wp.php
--> Matched 13: Version in /newsletter-for-wp.php
Progress : [###################################-----] 89% Modify Readme.txt
--> Matched 14: Version in /readme.txt
--> Matched 15: WP Version in /readme.txt
Progress : [####################################----] 90% Copy Language and Api integration
Progress : [######################################--] 95% Copy Plugin Update Checker
Progress : [########################################] 100% DONE!! (Controlla che le sostituzioni siano 15 come previsto!)

git clone git@github.com:mailrouter/Newsletter-for-Wordpress.git nl4wp
cd origin
mv ../nl4wp/.git .
git commit -a -m "update to upstream 4.2.4"
git push


