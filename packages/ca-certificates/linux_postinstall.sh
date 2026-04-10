#!/bin/sh

echo "Creating certificate bundle using system certificates"

seen=""
cert=""
inside=0

openssl_path=$(command -v openssl)

# Only read system certificates if openssl is installed
(
  [ -n "$openssl_path" ] && cat "/etc/ssl/certs/ca-certificates.crt" 2> /dev/null
  [ -n "$openssl_path" ] && cat "/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem" 2> /dev/null
  [ -n "$openssl_path" ] && cat "/etc/ssl/ca-bundle.pem" 2> /dev/null
  [ -n "$openssl_path" ] && cat "/etc/ssl/cert.pem" 2> /dev/null

  cat cacert.pem
) | while IFS= read -r line; do
    case "$line" in
        "-----BEGIN CERTIFICATE-----")
            inside=1
            ;;
        "-----END CERTIFICATE-----")
            cert="$cert$line"

            # Only do checks with openssl if openssl is installed
            if [ -n "$openssl_path" ]; then
                # Check if certificate is not expired
                if ! echo "$cert" | "$openssl_path" x509 -inform pem -checkend 0 -noout > /dev/null; then
                    cert=""
                    inside=0
                    continue
                fi

                # Check SSL purpose
                purpose=$(echo "$cert" | "$openssl_path" x509 -text -noout)
                if ! echo "$purpose" | grep -q "CA:TRUE"; then
                    cert=""
                    inside=0
                    continue
                fi

                # Calculate fingerprint to prevent duplicate certificates
                fingerprint=$(echo "$cert" | "$openssl_path" x509 -inform pem -fingerprint -sha256 -noout)
                case "\n$seen\n" in
                    *"\n$fingerprint\n"*)
                        # Skip fingerprints that we've already seen
                        cert=""
                        inside=0
                        continue
                        ;;
                    *)
                        # Add fingerprint to seen list
                        seen="$seen\n$fingerprint"
                        ;;
                esac
            fi

            echo "$cert" >> cert.pem

            cert=""
            inside=0
            ;;
    esac

    if [ "$inside" = "1" ]; then
        cert="$cert$line
"
    fi
done
