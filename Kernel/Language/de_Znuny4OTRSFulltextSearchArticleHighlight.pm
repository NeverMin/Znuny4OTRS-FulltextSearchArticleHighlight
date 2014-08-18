# --
# Kernel/Language/de_Znuny4OTRSFulltextSearchArticleHighlight.pm - the german translation of the texts of Znuny4OTRSFulltextSearchArticleHighlight
# Copyright (C) 2014 Znuny GmbH, http://znuny.com/
# --

package Kernel::Language::de_Znuny4OTRSFulltextSearchArticleHighlight;

use strict;
use warnings;

sub Data {
    my $Self = shift;

    $Self->{Translation}->{'This configuration registers an OutputFilter module that adds the fulltext parameter to the AgentTicketZoom link.'} = 'Diese Konfiguration registriert ein OutputFilter-Modul, das den Volltext-Parameter zum AgentTicketZoom-Link hinzufügt.';
    $Self->{Translation}->{'This configuration registers an OutputFilter module that adds the fulltext parameter to the redirect template link.'} = 'Diese Konfiguration registriert ein OutputFilter-Modul, das den Volltext-Parameter zum Redirect-Link hinzufügt.';
    $Self->{Translation}->{'This configuration registers an OutputFilter module that marks the article rows in the zoom with their ArticleIDs.'} = 'Diese Konfiguration registriert ein OutputFilter-Modul, das die Artikel-Reihen in der Detailansicht mit ihren ArticleIDs markiert.';
    $Self->{Translation}->{'This configuration registers an OutputFilter module that highlights the article rows and removes the added marker.'} = 'Diese Konfiguration registriert ein OutputFilter-Modul, das die Artikel-Reihen in der Detailansicht hervorhebt.';
    $Self->{Translation}->{'This configuration registers a custom ticket module that adds a function to Kernel::System::Ticket to get the ArticleIDs for a fulltext search for a ticket.'} = 'Diese Konfiguration registriert ein Ticket-Modul, das die ArticleIDs eines Tickets für den Volltext-Parameter ermittelt.';

    return 1;
}

1;