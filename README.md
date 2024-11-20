# 키바나 8.x.x 자동 설치 및 설정 setup 앤서블

## 필수 준비

- **필수 셋팅**: `system_download.txt 파일 /data/work 하위에 위치 필수!!!!`

## 참조 파일

- **셋업 참조 파일**: `system_download.txt(/data/work 하위에 위치 필수!!!!)`
- **키바나 초기 설정 파일 샘플**: `/etc/kibana/kibana.yml`
- **전체 파이프라인 플레이북**: `kibana_deploy.yml`

## 각 파일 설명

1. **`hosts.ini`** : 인벤토리(관리 대상 시스템 리스트)
2. **`main.yml`** : play_book 변수를 담은 파일
3. **`entrypoint.sh`** : 키바나 초기 설정 파일 동적 setup
6. **`kibana_deploy.yml`** : 앤서블 플레이북

## 실행 방법

1. `kibana_deploy.yml` 플레이북을 실행하여 전체 파이프라인을 시작합니다.
   ```sh
   ansible-playbook -i /data/work/kibana_8.x_ansible/hosts.ini /data/work/kibana_8.x_ansible/kibana_deploy.yml
   ```

## ansible 플레이북 구조

- `download and install Kibana`: 키바나 설치
- `entrypoint_sh start`: entrypoint.sh 스크립트를 실행하여 각 서버 엘라스틱서치 설정 동적 setup

---

이 플레이북은 키바나를 자동으로 설정하고 Start 하는 과정을 자동화 합니다.
