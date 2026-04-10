#!/bin/sh

echo "Creating certificate bundle using system certificates in keychain"

seen=""
cert=""
inside=0
policy="skip"

(
  echo "-----POLICY ssl-----"
  /usr/bin/security find-certificate -a -p "/Library/Keychains/System.keychain"

  echo "-----POLICY basic-----"
  /usr/bin/security find-certificate -a -p "/System/Library/Keychains/SystemRootCertificates.keychain"

  echo "-----POLICY skip-----"
  cat cacert.pem
) | while IFS= read -r line; do
    case "$line" in
        "-----POLICY "*"-----")
            policy=${line#"-----POLICY "}
            policy=${policy%"-----"}
            ;;
        "-----BEGIN CERTIFICATE-----")
            inside=1
            ;;
        "-----END CERTIFICATE-----")
            cert="$cert$line"

            # Check if certificate is not expired
            if ! echo "$cert" | /usr/bin/openssl x509 -inform pem -checkend 0 -noout; then
                cert=""
                inside=0
                continue
            fi

            # Check SSL purpose
            purpose=$(echo "$cert" | /usr/bin/openssl x509 -text -noout)
            if ! echo "$purpose" | grep -q "CA:TRUE"; then
                cert=""
                inside=0
                continue
            fi

            # Check if the certificate is trusted
            if [ "$policy" != "skip" ]; then
                if ! echo "$cert" | /usr/bin/security verify-cert -c /dev/stdin -l -L -R offline -p "$policy" > /dev/null; then
                    cert=""
                    inside=0
                    continue
                fi
            fi

            # Calculate fingerprint to prevent duplicate certificates
            fingerprint=$(echo "$cert" | /usr/bin/openssl x509 -inform pem -fingerprint -sha256 -noout)
            case "\n$seen\n" in
                *"\n$fingerprint\n"*)
                    # Skip fingerprints that we've already seen
                    ;;
                *)
                    # Add certificate to cert.pem file
                    echo "$cert" >> cert.pem
                    seen="$seen\n$fingerprint"
                    ;;
            esac

            cert=""
            inside=0
            ;;
    esac

    if [ "$inside" = "1" ]; then
        cert="$cert$line
"
    fi
done
