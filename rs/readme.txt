=== Newsletter for WordPress ===
Contributors: Morloi, Bago
Tags: newsletter, nl4wp, email, marketing, newsletter, subscribe, widget, nl4wp, contact form 7, woocommerce, buddypress, ibericode, newsletter forms, newsletter integrations
Requires at least: 4.1
Tested up to: 4.9.4
Stable tag: [nl4wp_version]
License: GPLv2 or later
License URI: http://www.gnu.org/licenses/gpl-2.0.html
Requires PHP: 5.2.4

Newsletter for WordPress, usa il tuo sito Wordpress per raccogliere iscritti per la tua Newsletter!

== Description ==

#### Newsletter for WordPress

*Aggiungere metodi di iscrizione alla tua lista iscritti dovrebbe essere semplice e immediato. Ora lo è.*

Newsletter for WordPress ti aiuta a aumentare il numero degli iscritti alla tua newsletter, integrandosi alla perfezione con l'account del tuo ESP. Potrai creare moduli di ogni tipo, oppure integrare l'iscrizione direttamente nei commenti di Wordpress, nel form di registrazione, oppure integrare l'iscrizione con Woocommerce, Ninja Forms e tanti altri plugin.

#### Alcune delle caratteristiche di Newsletter for Wordpress

- Connetti il tuo account ESP in un secondo.

- I moduli di iscrizione sono belli e pensati per essere responsive. Puoi decidere cosa inserire nel modulo e quali dati mandare al tuo ESP.

- Integrazione completa con i seguenti plugin:
	- Default WordPress Comment Form
	- Default WordPress Registration Form
	- Contact Form 7
	- WooCommerce
	- Gravity Forms
	- Ninja Forms 3
	- WPForms
	- BuddyPress
    - MemberPress
	- Events Manager
	- Easy Digital Downloads

#### Che cos'è un ESP e quali ESP sono compatibili con Newsletter for WordPress?

L'ESP, acronimo di Email Service Provider. E' una società che gestisce campagne di email marketing. 
Gli ESP sono nati come risposta alla difficoltà di invio email a grandi numeri di destinatari. Tale gestione include infatti la semplificazione di importazione/esportazione degli iscritti, la fornitura di procedure semplici di iscrizione e disiscrizione, la gestione del contatto con gli inbox providers (Feedback Loop, Whitelist), il monitoring delle blacklist, l'analisi del Bounce, l'integrazione di tecniche di autenticazione della posta elettronica. 
Newsletter for Worpress facilita l'implementazione della procedura di iscrizione degli utenti, collegandosi direttamente al tuo account presso l'ESP, consentendo una integrazione completa fra ESP e sito Wordpress.


== Installation ==

#### Come installare il plugin
1. Scarica il plugin dal tuo account presso l'ESP di fiducia. Otterrai un semplice file Zip.
2. Accedi al pannello di amministrazione di Wordpress, vai su "Plugin", clicca su "Aggiungi nuovo" e successivamente su "Carica Plugin". Seleziona il file dal tuo disco e caricalo nel sito.
2. Attiva il plugin
1. Immetti la tua chiave API nella configurazione del plugin.

#### Come configurare il Modulo di iscrizione
1. Vai su *Newsletter for WP > Modulo*
2. Seleziona una lista in cui andranno a finire gli iscritti.
3. *(Opzionale)* Aggiungi più campi al modulo scegliendoli da quelli proposti.
4. Usa il modulo nelle pagine o negli articoli usando il pulsante "Preleva Shortcode".
5. Mostra un modulo di iscrizione nella tua area widget usando il widget "Iscrizione alla newsletter".
6. Inserisci il modulo di iscrizione tramite i tuoi file di tema, usando la seguente funzione PHP.

`
<?php

if( function_exists( 'nl4wp_show_form' ) ) {
	nl4wp_show_form();
}
`

== Frequently Asked Questions ==

#### Come inserisco il modulo nelle pagine o negli articoli?
Usa il pulsante "Preleva Shortcode" nella pagina *Newsletter for WP > Modulo* e incollalo nella tua pagina o nel tuo articolo. 

#### Dove trovo la mia chiave API?
Normalmente la troverai nell'account del tuo ESP, andando in *Account > Specifiche API*

#### Come aggiungo un checkbox di iscrizione nel mio modulo Contact Form 7?
Usa il seguente shortcode.

`
[nl4wp_checkbox "Iscriviti alla nostra newsletter?"]
`

#### Il modulo mostra la pagina di iscrizione avvenuta, ma non trovo l'iscritto dentro al mio database, come mai?
Se il modulo mostra la pagina di successo, l'iscrizione è avvenuta. Se, come consigliato, usi il metodo di Confirmed OptIn, dovrai aspettare che l'utente riceva l'email e che clicchi sul link di conferma.

#### Come posso cambiare lo stile del modulo?
Se non gradisci i temi offerti dal plugin, puoi usare i CSS per modificare a piacere l'aspetto del modulo; qui sotto trovi i selettori coinvolti.

`
.nl4wp-form { ... } /* il modulo */
.nl4wp-form p { ... } /* i paragrafi del modulo */
.nl4wp-form label { ... } /* etichette */
.nl4wp-form input { ... } /* campi di input */
.nl4wp-form input[type="checkbox"] { ... } /* checkboxe */
.nl4wp-form input[type="submit"] { ... } /* pulsante di invio */
.nl4wp-alert { ... } /* messaggi di successo e errore */
.nl4wp-success { ... } /* messaggi di successo */
.nl4wp-error { ... } /* messaggi di errore */
`

#### Come posso visualizzare il mio form in un popup?

Esistono molti plugin che gestiscono moduli in popup, con comportamenti "smart". All'interno di questi puoi normalmente utilizzare lo Shortcode per il tuo modulo Newsletter for Wordpress.

== Other Notes ==

#### Assistenza

Per ogni questione relativa al plugin e al suo funzionamento, fate riferimento al vostro ESP.

