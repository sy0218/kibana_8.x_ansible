#!/usr/bin/bash

system_file="/data/work/system_download.txt"
kibana_array=($(cat ${system_file} | grep kibana_ip | awk -F '|' '{for(i=2; i<=NF; i++) print $i}'))
len_array=${#kibana_array[@]}

kibana_yml_path=$(find /etc -name kibana.yml)
# kibana.yml-start system_download.txt 참조하여 동적 setup
kibana_yml=$(awk '/\[kibana.yml-start\]/{flag=1; next} /\[kibana.yml-end\]/{flag=0} flag' ${system_file})
while IFS= read -r kibana_yml_low;
do
        kibana_env_name=$(echo $kibana_yml_low | awk -F '|' '{print $1}' | sed 's/[][]//g')
        kibana_env_value=$(echo $kibana_yml_low | awk -F '|' '{print $2}')
	# 포함되어 있거나 es_env_name으로 시작하는 라인 수정
	sed -i "/^\(#\)\?${kibana_env_name}/s|^#\?\(${kibana_env_name}\).*|${kibana_env_name}: ${kibana_env_value}|" "${kibana_yml_path}"
done <<< $kibana_yml

for ((i=0; i<len_array; i++));
do
	current_ip=${kibana_array[$i]}
	scp ${kibana_yml_path} root@${current_ip}:${kibana_yml_path}
done
