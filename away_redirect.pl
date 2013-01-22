# REMEMBER TO EDIT LINE 22!
use strict;
use warnings;

use Irssi;
use Irssi::Irc;
use vars qw($VERSION %IRSSI);

$VERSION = "1.1";

%IRSSI = (
    authors     => "ems",
    contact     => "ems at freenode",
    name        => "away_redirect",
    description => "Redirects msg/hilights when you are set away.",
    license     => "GPL v2",
    url         => "http://github.com/emsdev",
);

sub redirect_message {
    my ($title, $sender, $content) = @_;
    Irssi::command("msg -bitlbee phone " . $title . " " . $sender . ": " . $content); # FIXME
}

sub public_message {
    my ($server, $content, $nick) = @_;

    if($server->{usermode_away} == 1 && $content =~ /$server->{nick}/i){
        redirect_message("[HL]", $nick, $content);
    }
}

sub private_message {
    my ($server, $content, $nick) = @_;

    if($server->{usermode_away} == 1){
        redirect_message("[MSG]", $nick, $content);
    }
}

Irssi::signal_add_last('message public', 'public_message');
Irssi::signal_add_last('message private', 'private_message');
