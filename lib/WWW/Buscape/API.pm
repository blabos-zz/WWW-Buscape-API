package WWW::Buscape::API;

use Moo;

use JSON;
use LWP::UserAgent;

has application_id => (
    is => 'ro',
);

has country_code => (
    is => 'ro',
    isa => sub {
        die 'country_code must be AR, BR, CL, CO, MX, PE, VE'
            unless $_[0] =~ /^(AR|BR|CL|CO|MX|PE|VE)$/;
    },
    default => sub {
        return 'BR';
    },
);

has environment => (
    is => 'ro',
    isa => sub {
        die 'format must be "bws" or "sandbox"'
            unless $_[0] =~ /^(bws|sandbox)$/;
    },
    default => sub {
        return 'sandbox';
    },
);

has format => (
    is  => 'ro',
    isa => sub {
        die 'format must be "xml" or "json"' unless $_[0] =~ /^(xml|json)$/;
    },
    default => sub {
        return 'json';
    },
);

has user_agent => (
    is => 'ro',
    default => sub { return LWP::UserAgent->new },
);

has _base_url => (
    is => 'ro',
    default => sub {
        return 'buscape.com/service';
    },
);


sub findProductList {
    my ( $self, %args ) = @_;
    
    $args{format} = $self->format;
    
    my $proto = 'http';
    
    my $host
        = join
            '.',
            $self->environment,
            $self->_base_url
        ;
    
    my $query
        = join
            '/',
            'findProductList',
            $self->application_id,
            $self->country_code
        ;
    
    my $params
        = join
            '&',
            map {
                $_ . '=' . $args{$_},
            } keys %args
        ;
    
    my $url = "$proto://$host/$query?$params";
    
    return decode_json( $self->user_agent->get( $url )->content );
}

1;