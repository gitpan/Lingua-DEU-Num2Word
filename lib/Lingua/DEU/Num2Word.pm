# For Emacs: -*- mode:cperl; mode:folding; coding:utf-8 -*-

package Lingua::DEU::Num2Word;
# ABSTRACT: Number 2 word conversion in DEU.

# {{{ use block

use strict;
use warnings;
use utf8;

use Readonly;
use Perl6::Export::Attrs;

# }}}
# {{{ variable declarations

my Readonly::Scalar $COPY = 'Copyright (C) PetaMem, s.r.o. 2002-present';

our $VERSION = 0.0577;

# }}}

# {{{ num2deu_cardinal                 convert number to text

sub num2deu_cardinal :Export {
    my $positive = shift // return 'null';

    my @tokens1 = qw(null ein zwei drei vier fünf sechs sieben acht neun zehn elf zwölf);
    my @tokens2 = qw(zwanzig dreissig vierzig fünfzig sechzig siebzig achtzig neunzig hundert);

    return $tokens1[$positive]           if ($positive >= 0 && $positive < 13); # 0 .. 12
    return 'sechzehn'                    if ($positive == 16);                  # 16 exception
    return 'siebzehn'                    if ($positive == 17);                  # 17 exception
    return $tokens1[$positive-10] . 'zehn' if ($positive > 12 && $positive < 20); # 13 .. 19

    my $out;          # string for return value construction
    my $one_idx;      # index for tokens1 array
    my $remain;       # remainder

    if ($positive > 19 && $positive < 101) {              # 20 .. 100
        $one_idx = int ($positive / 10);
        $remain  = $positive % 10;

        $out  = "$tokens1[$remain]und" if ($remain);
        $out .= $tokens2[$one_idx - 2];
    }
    elsif ($positive > 100 && $positive < 1000) {       # 101 .. 999
        $one_idx = int ($positive / 100);
        $remain  = $positive % 100;

        $out  = "$tokens1[$one_idx]hundert";
        $out .= $remain ? num2deu_cardinal($remain) : '';
    }
    elsif ($positive > 999 && $positive < 1_000_000) {  # 1000 .. 999_999
        $one_idx = int ($positive / 1000);
        $remain  = $positive % 1000;

        $out  = num2deu_cardinal($one_idx).'tausend';
        $out .= $remain ? num2deu_cardinal($remain) : '';
    }
    elsif (   $positive > 999_999
           && $positive < 1_000_000_000) {                 # 1_000_000 .. 999_999_999
        $one_idx = int ($positive / 1000000);
        $remain  = $positive % 1000000;
        my $one  = $one_idx == 1 ? 'e' : '';

        $out  = num2deu_cardinal($one_idx) . "$one million";
        $out .= 'en' if ($one_idx > 1);
        $out .= $remain ? ' ' . num2deu_cardinal($remain) : '';
    }

    return $out;
}

# }}}

1;

__END__

# {{{ POD HEAD

=pod

=head1 NAME

Lingua::DEU::Num2Word

=head1 VERSION

version 0.0577

Positive number to text convertor for German.
Output text is in utf-8 encoding.

=head2 $Rev: 577 $

ISO 639-3 namespace

=head1 SYNOPSIS

 use Lingua::DEU::Num2Word;

 my $text = Lingua::DEU::Num2Word::num2deu_cardinal( 123 );

 print $text || "sorry, can't convert this number into german language.";

=head1 DESCRIPTION

Number 2 word conversion in DEU.

Lingua::DEU::Num2Word is module for converting numbers into their written
representationin German. Converts whole numbers from 0 up to 999 999 999.

=cut

# }}}
# {{{ Functions reference

=pod

=head2 Functions Reference

=over

=item num2deu_cardinal (positional)

  1   number  number to convert
  =>  string  converted string
      undef   if input number is not known

Convert number to text representation.

=back

=cut

# }}}
# {{{ POD FOOTER

=pod

=head1 EXPORT_OK

num2deu_cardinal

=head1 KNOWN BUGS

None.

=head1 AUTHOR

Richard Jelinek <info@petamem.com>
Roman Vasicek <info@petamem.com>

=head1 COPYRIGHT

Copyright (C) PetaMem, s.r.o. 2002-present

=head2 LICENSE

Artistic license or BSD license.

=cut

# }}}
