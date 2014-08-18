# --
# Kernel/System/Ticket/Znuny4OTRSFulltextSearchArticleHighlight.pm - custom Znuny4OTRSFulltextSearchArticleHighlight function to get relevant fulltext articles
# Copyright (C) 2014 Znuny GmbH, http://znuny.com/
# --

package Kernel::System::Ticket::Znuny4OTRSFulltextSearchArticleHighlight;

use strict;
use warnings;

# disable redefine warnings in this scope
{
no warnings 'redefine';

sub Kernel::System::Ticket::FulltextArticleIDs {
    my ($Self , %Param ) = @_;

    # check needed stuff
    NEEDED:
    for my $Needed ( qw(TicketID Fulltext) ) {

        next NEEDED if defined $Param{ $Needed };

        $Self->{LogObject}->Log(
            Priority => 'error',
            Message  => "Parameter '$Needed' is needed!",
        );
        return;
    }

    # build fulltext article query
    my $ArticleLookupQuery = $Self->_ArticleIndexQuerySQLExt(
        Data => {
            ContentSearch       => 'OR',
            ContentSearchPrefix => '*',
            ContentSearchSuffix => '*',
            From                => $Param{Fulltext},
            To                  => $Param{Fulltext},
            Cc                  => $Param{Fulltext},
            Subject             => $Param{Fulltext},
            Body                => $Param{Fulltext},
        }
    );

    # build SQL query
    $ArticleLookupQuery = "SELECT art.id FROM article art WHERE art.ticket_id = ? ". $ArticleLookupQuery;

    # ask database
    $Self->{DBObject}->Prepare(
        SQL  => $ArticleLookupQuery,
        Bind => [ \$Param{TicketID} ],
    );

    my @ArticleIDs;
    # fetch the result
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        push @ArticleIDs, $Row[0];
    }

    return @ArticleIDs;
}

# reset all warnings
}

1;
