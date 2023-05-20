sudo su
sudo apt update
sudo apt install docker.io -y
gcloud auth configure-docker --quiet
gcloud auth configure-docker us-east1-docker.pkg.dev --quiet
docker pull gcr.io/tricustom/tricustom-demo:latest
apt install net-tools
apt install nginx -y
cat > /etc/nginx/sites-available/tricustom.conf <<EOF
 server {
        listen 80;
        server_name tricustom-demo.com;

        location / {
            proxy_pass http://localhost:9000/api/signUp;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
        }
    }
EOF
ln -s /etc/nginx/sites-available/tricustom.conf /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
nginx -t
systemctl restart nginx

wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
chmod +x cloud_sql_proxy
cat > secret.txt <<EOF
ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAidHJpY3VzdG9t
IiwKICAicHJpdmF0ZV9rZXlfaWQiOiAiMzM2NzAyZTNiOGY5MGRlMmMzNjQ3ODAzMGU3MTUzMmUy
OWQ3Y2U3MCIsCiAgInByaXZhdGVfa2V5IjogIi0tLS0tQkVHSU4gUFJJVkFURSBLRVktLS0tLVxu
TUlJRXZnSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS2d3Z2dTa0FnRUFBb0lCQVFDWk5zMEhQ
T200MW9DRFxuSzNoY25tS2pPbVc1NnNxc0ZUTFlNOFl2VURybS9EM2V3dDA5QWJxOVdJR2NCaXMw
eWUyMWpKQm44b2s2MHkrQVxuWTBzZ1l3b2szeUNrZFBlL0JpVUI1eWpFYmtBbThqZnJTenBNK3RN
N0xrYjdnRlVBbWwyeVRkZW8vOE5YSVlIOVxuTkpRN1ZXUlFJYlpnSTJ2YzVGRXZvSDdyUExJUkF4
enRtWmphMHBnTFJUS2pBOUU4bzV6MXhNaWQvb05MaFVUeFxuTndnNmFuMDl4eG5JU1VCY2hjKytw
em9KWlk4SEZ5cFQ4MUc0Mkxud0FuU0Rld1ZETEtJdGZ4VDcrclhkY1o0clxuRkNKODBJNXprV3VN
UndoN2ZZNVZzakdlUE55ZHJnd05FNEVFVW0rOFZ6RVhUUktWamxjTG95SjBGeUk5THVvL1xuSHJS
aVI3eGJBZ01CQUFFQ2dnRUFEd1FvZHhwT0VUckdFS3BpTUdMK1B0K1AySGRvYUJJOGVxVWtaT200
N3RUdlxudEJWUmZWT3pPNFhnK2hZK3NOSDVBQm45T0pBMFNVclR5b0piZXNWS0xycWNVVHluaXNE
WVFBWC9Dd3JWTXh2NlxubXJuZVJtemFQQXJPazlnTVBMUVBGU3A4OEYxL2hkck5DZHN0TmdncC9l
ZmlueXlKa0tEalMzR0ZwRVRvSE40K1xuNEMyQzFVSUcxTTV6WUh3clA3Y0QwdGlPR2FmV1dGc2kw
RXV2dXZrc3g2bUhNSjFtT1VDSTBSS1YxNXJGL2ZSNlxuMnlERHlTOWFBbjlIMVZqMVhwang4WTgw
aWViZVRlUWNlbExBSTlwV2hGbjdVVE1qQTJ1RExrc0NCNWwzQnRWMVxuNmRITnY1T1NuQ0Nlc1ZM
eXJmY1c3eTNOSnd6OS9HUGFVaWplYjk3RHVRS0JnUURQY2E4MFNzejhDUkpUSXcySVxuUFVkSWlu
K0JzbVd4bUcvenBKT1FKZ1dBOFRqS29mYzJoekVMMGZPNVNaY2hBbVQwM3NxWk9tSTZ6MnJjYWRu
RlxuN3NZUDZWbGNxbW41bFhLZTRkYmMzMFZrQnRTQW9rd2hPdFZGRTNNeE9oTnkxL1hqcHY3S1Bi
cHFhNWJQSFNqS1xuNjlrdUlpbEw2ZFRkc0U2MVRlSUk5eTQyTXdLQmdRQzlFNVdlaDFiRnBRRTV0
WTg5KzJYVmRSNnNHVlY1Nk5zbFxuNUg3YW1MN3Z2Tm0xZGRYeWlCZjlQd1U4dFR1OHBRUlZHdjV6
VWRvcFQ0ZllOMXQxUHVFYkxWWll3cDZ1ODlMN1xuVmhxSVVRV0FYYmdUT0lmcTdpbGY5dURHdjdz
RHNKM0Rja0U4bkFQZW5UdHNyanpONmV5b0FnU0YxTnM3akM5TVxuZWdWYitmS3BPUUtCZ0UwQlhw
Q0MwK1ViV1BvVG9RcFo5UVF3cFhSM3pOaElSZ2FqcVVOeFdjbXJ3ZkUyZnBaM1xuU1BXaVVsOE51
bFErbDB0dkNMWW92aDRtc1B4eExxNFRIT0w3TkhqNXFhMUVsTy8xMWRUWDdPSmN4cldaaWJrc1xu
SmM4bWtUUk00cnRXLzZncWJacVZuNFd4dXFIWHFUVHFxQXhBRWlSa0FPanFjYzFMeEFTZi9UK1JB
b0dCQUkvalxuWVk5OUMwbnA0bDdhanFIcXVYcVNZTDh6b0ZyZ0hEWmdCekd2NEU1dGQzaWlyaWlk
N1RPcVRBQUJJKzdSM2RRdVxuY01tdDFzcHRYY0hyanN4UkI5bzR6R2RMNUpyYnJ3bmFZdUt1VmZO
MFh1c3hzQzNYQk9HazdUWVRIdTBWOFZtVlxuajVQaVh3ZUF2SUplcnFNOWkvM25XeTNGNlBrT0c4
aWxhNEt0V2oveEFvR0JBS0JWLzhDQ2JXVXRIalI0RVgyYlxueXdaaHo0cUg1clB0bG9HWXVPTkpt
MDkrcDZEazJyUlBNbS9LUDJyOFUyV3RnR3o2cFFZTkNwK0dvZlBIWDFnNlxuK0FWeU1hYThCTU1p
Mm85MW1nVzYyeGxVTlpOWVRhT1ArSFROUVRRUm02MDFyc3p5REU3aTE1Zk9MNjVaVFNKZlxuZDJQ
S010WVNaWnZKL1RCQmZJYzVmUGU2XG4tLS0tLUVORCBQUklWQVRFIEtFWS0tLS0tXG4iLAogICJj
bGllbnRfZW1haWwiOiAidHJpY3VzdG9tLWRiLXNlcnZpY2UtYWNjb3VudEB0cmljdXN0b20uaWFt
LmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJjbGllbnRfaWQiOiAiMTA3MDg1NzUzODI0NDM2OTY1
NzAwIiwKICAiYXV0aF91cmkiOiAiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tL28vb2F1dGgy
L2F1dGgiLAogICJ0b2tlbl91cmkiOiAiaHR0cHM6Ly9vYXV0aDIuZ29vZ2xlYXBpcy5jb20vdG9r
ZW4iLAogICJhdXRoX3Byb3ZpZGVyX3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xl
YXBpcy5jb20vb2F1dGgyL3YxL2NlcnRzIiwKICAiY2xpZW50X3g1MDlfY2VydF91cmwiOiAiaHR0
cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vcm9ib3QvdjEvbWV0YWRhdGEveDUwOS90cmljdXN0b20t
ZGItc2VydmljZS1hY2NvdW50JTQwdHJpY3VzdG9tLmlhbS5nc2VydmljZWFjY291bnQuY29tIiwK
ICAidW5pdmVyc2VfZG9tYWluIjogImdvb2dsZWFwaXMuY29tIgp9Cg==
EOF
base64 --decode secret.txt >> credentials.json
./cloud_sql_proxy -instances=############# -credential_file=credentials.json &
docker run -itd --network=host gcr.io/tricustom/tricustom-demo