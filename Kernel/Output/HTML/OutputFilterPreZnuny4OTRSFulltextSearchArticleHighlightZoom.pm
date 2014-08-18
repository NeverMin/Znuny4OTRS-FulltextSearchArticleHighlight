# --
# Kernel/Output/HTML/OutputFilterPreZnuny4OTRSFulltextSearchArticleHighlightZoom.pm - adds the ArticleID to the marker cell of the article row
# Copyright (C) 2014 Znuny GmbH, http://znuny.com/
# --

package Kernel::Output::HTML::OutputFilterPreZnuny4OTRSFulltextSearchArticleHighlightZoom;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    NEEDED:
    for my $Needed (qw( ParamObject )) {
        $Self->{$Needed} = $Param{$Needed} || die "Got no $Needed!";
    }

    $Self->{Action} = $Param{Action} || '';

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # check Action param
    return 1 if $Self->{Action} ne 'AgentTicketZoom';

    # check TemplateFile
    return 1 if !$Param{TemplateFile};
    return 1 if $Param{TemplateFile} ne 'AgentTicketZoom';

    # check for Fulltext parameter
    my $Fulltext = $Self->{ParamObject}->GetParam( Param => 'Fulltext' );
    return 1 if !$Fulltext;

    # manipulate HTML content
    ${ $Param{Data} } =~ s{(NonTextContent)(">)}{$1 FulltextArticleID\$QData{"ArticleID"}$2}xms;

    return 1;
}

1;
