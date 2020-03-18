# ------------ Sample Dialog ---------------
#
# dialog::  ID=17532904058365
#         state:: 4
#         user_flags:: 0
#         timestart:: 1583140495
#         datestart:: 2020-03-02 09:14:55
#         timeout:: 1583162095
#         dateout:: 2020-03-02 15:14:55
#         callid:: 1f8ca626-d709-1238-53be-0243fe4e0898
#         from_uri:: sip:172.31.23.198:8062
#         to_uri:: sip:172.31.24.28:9060
#         caller_tag:: Z38H3D1HemeZj
#         caller_contact:: sip:172.31.23.198:8062;transport=tcp
#         callee_cseq:: 0
#         caller_route_set::
#         caller_bind_addr:: tcp:172.31.24.28:9060
#         caller_sdp::
#         CALLEES::
#                 callee::
#                         callee_tag:: 54mrcZry2ecZa
#                         callee_contact:: sip:172.31.23.174:8060;transport=udp
#                         caller_cseq:: 948032444
#                         callee_route_set::
#                         callee_bind_addr:: udp:172.31.24.28:9060
#                         callee_sdp::

mapfile -t lines < <(opensipsctl fifo dlg_list | grep "state::" -B 1)

dialog_id_regex="[0-9]+"

len=${#lines[@]}

for (( c=0; c<=len; c+=3 ))
do
    if [[ ${lines[c]} =~ $dialog_id_regex ]]; then
        dialog_id=${BASH_REMATCH[0]}
        opensipsctl fifo dlg_end_dlg $dialog_id
    else
        echo "unable to parse string ${lines[c]}"
fi
done

