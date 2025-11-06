aws ec2 run-instances \
    --image-id ami-0c398cb65a93047f2 \
    --count 1 \
    --instance-type t3.micro \
    --key-name "Anna dev" \
    --security-group-ids sg-04370304b13203a1a \
    --subnet-id subnet-069edd1ee0ce5598a \
    --user-data file://userdata.sh \
    --output text
