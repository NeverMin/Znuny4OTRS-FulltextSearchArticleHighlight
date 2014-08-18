# --
# Kernel/Output/HTML/OutputFilterPreZnuny4OTRSFulltextSearchArticleHighlight.pm - adds the fulltext search parameter to the AgentTicketZoom link
# Copyright (C) 2014 Znuny GmbH, http://znuny.com/
# --

package Kernel::Output::HTML::OutputFilterPreZnuny4OTRSFulltextSearchArticleHighlight;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    NEEDED:
    for my $Needed (qw( Action ParamObject LayoutObject )) {
        $Self->{$Needed} = $Param{$Needed} || die "Got no $Needed!";
    }

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # check Action param
    return 1 if $Self->{Action} ne 'AgentTicketSearch';

    # check TemplateFile
    return 1 if !$Param{TemplateFile};
    return 1 if !scalar grep { $Param{TemplateFile} eq $_ } qw( AgentTicketOverviewSmall AgentTicketOverviewMedium AgentTicketOverviewPreview );

    # check regular parameter
    my $Fulltext = $Self->{ParamObject}->GetParam( Param => 'Fulltext' );
    return 1 if !$Fulltext;

    my $FulltextLinkEncoded = $Self->{LayoutObject}->LinkEncode( $Fulltext );

    # manipulate HTML content
    ${ $Param{Data} } =~ s{(Action=AgentTicketZoom;TicketID=\$LQData{"TicketID"})}{$1;Fulltext=$FulltextLinkEncoded}xms;

    return 1;
}

1;
