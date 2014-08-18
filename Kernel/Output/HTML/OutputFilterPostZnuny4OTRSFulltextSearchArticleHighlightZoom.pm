# --
# Kernel/Output/HTML/OutputFilterPostZnuny4OTRSFulltextSearchArticleHighlightZoom.pm - sets the style attribute for relevant article rows
# Copyright (C) 2014 Znuny GmbH, http://znuny.com/
# --

package Kernel::Output::HTML::OutputFilterPostZnuny4OTRSFulltextSearchArticleHighlightZoom;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    NEEDED:
    for my $Needed (qw( ParamObject ConfigObject EncodeObject LogObject MainObject TimeObject )) {
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

    # check regular parameter
    my $Fulltext = $Self->{ParamObject}->GetParam( Param => 'Fulltext' );
    return 1 if !$Fulltext;

    my $TicketID = $Self->{ParamObject}->GetParam( Param => 'TicketID' );
    return 1 if !$TicketID;

    my $DBObject     = Kernel::System::DB->new( %{ $Self } );
    my $TicketObject = Kernel::System::Ticket->new(
        %{ $Self },
        DBObject => $DBObject,
    );

    my @ArticleIDs = $TicketObject->FulltextArticleIDs(
        Fulltext => $Fulltext,
        TicketID => $TicketID,
    );

    return 1 if !scalar @ArticleIDs;

    for my $ArticleID ( @ArticleIDs ) {
        ${ $Param{Data} } =~ s{(FulltextArticleID$ArticleID")}{$1 style="background-color: lightgreen;"}xms;
    }

    # previously added css class isn't needed anymore
    ${ $Param{Data} } =~ s{ \s FulltextArticleID\d+}{}xms;

    return 1;
}

1;
