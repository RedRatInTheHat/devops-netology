## Подготовка к выполнению

1. Создать два VM: для jenkins-master и jenkins-agent.
2. Установить Jenkins при помощи playbook.
3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.

### Решение

Для создания инстансов используется [Terraform](terraform/main.tf).

Для корректного запуска в таске [Install JDK](infrastructure/site.yml) использована ссылка; версия JDK [вынесена в переменную jdk_version](infrastructure/inventory/cicd/group_vars/jenkins.yml).

Агент подключен, у мастера отобраны executor'ы:

![alt text](images/1.png)

---

## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.
4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.
5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).
6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.
9. Сопроводите процесс настройки скриншотами для каждого пункта задания!!

### Решение

Для Freestyle Job использовался следующий скрип:
```shell
rm -r vector-role
git clone https://github.com/RedRatInTheHat/vector-role.git

cd vector-role
python3 -m molecule test
```

Предварительно были проделаны следующие вещи:
* на стороне агента через yum установлен Ansible (иначе не видна кофигурация);
* через pip3 установлен Ansible;
* руками пришлось влезть в docker-модуль Ansible (фу так делать, но сочтено примемлемым временным решением);
* в vector-role закомментирована часть, относящаяся к ubuntu, так как (предположительно) из-за недостаточной вресии Python падает модуль ansible.module_utils.six.moves, и нет у меня больше сил никаких дальше жонглировать версиями.

Job отработал успешно:

<details>
<summary>log</summary>
<code>
Started by user Jenkins Jenkinsovich
Running as SYSTEM
Building remotely on agent-007 in workspace /opt/jenkins_agent/workspace/test vector
[test vector] $ /bin/sh -xe /tmp/jenkins14467026683115622986.sh
+ rm -r vector-role
+ git clone https://github.com/RedRatInTheHat/vector-role.git
Cloning into 'vector-role'...
+ cd vector-role
+ python3 -m molecule test
/usr/local/lib/python3.6/site-packages/requests/__init__.py:104: RequestsDependencyWarning: urllib3 (1.26.19) or chardet (5.0.0)/charset_normalizer (2.0.12) doesn't match a supported version!
  RequestsDependencyWarning)
[34mINFO    [0m default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
[34mINFO    [0m Performing prerun[33m...[0m
[34mINFO    [0m Set [33mANSIBLE_LIBRARY[0m=[35m/root/.cache/ansible-compat/4865c4/[0m[95mmodules[0m:[35m/root/.ansible/plugins/[0m[95mmodules[0m:[35m/usr/share/ansible/plugins/[0m[95mmodules[0m
[34mINFO    [0m Set [33mANSIBLE_COLLECTIONS_PATHS[0m=[35m/root/.cache/ansible-compat/4865c4/[0m[95mcollections[0m:[35m/root/.ansible/[0m[95mcollections[0m:[35m/usr/share/ansible/[0m[95mcollections[0m
[34mINFO    [0m Set [33mANSIBLE_ROLES_PATH[0m=[35m/root/.cache/ansible-compat/4865c4/[0m[95mroles[0m:[35m/root/.ansible/[0m[95mroles[0m:[35m/usr/share/ansible/[0m[95mroles[0m:[35m/etc/ansible/[0m[95mroles[0m
[34mINFO    [0m Using [35m/root/.ansible/roles/[0m[95mnetology.vector_role[0m symlink to current repository in order to enable Ansible to find the role using its expected full name.
[34mINFO    [0m [2;36mRunning [0m[2;32mdefault[0m[2;36m > [0m[2;32mdependency[0m
[31mWARNING [0m Skipping, missing the requirements file.
[31mWARNING [0m Skipping, missing the requirements file.
[34mINFO    [0m [2;36mRunning [0m[2;32mdefault[0m[2;36m > [0m[2;32mlint[0m
[34mINFO    [0m Lint is disabled.
[34mINFO    [0m [2;36mRunning [0m[2;32mdefault[0m[2;36m > [0m[2;32mcleanup[0m
[31mWARNING [0m Skipping, cleanup playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdefault[0m[2;36m > [0m[2;32mdestroy[0m
[34mINFO    [0m Sanity checks: [32m'docker'[0m

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
[33mchanged: [localhost] => (item=centos)[0m

TASK [Wait for instance(s) deletion to complete] *******************************
[32mok: [localhost] => (item=centos)[0m

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
[33mlocalhost[0m                  : [32mok=2   [0m [33mchanged=1   [0m unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m [2;36mRunning [0m[2;32mdefault[0m[2;36m > [0m[2;32msyntax[0m

playbook: /opt/jenkins_agent/workspace/test vector/vector-role/molecule/default/converge.yml
[34mINFO    [0m [2;36mRunning [0m[2;32mdefault[0m[2;36m > [0m[2;32mcreate[0m

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
[36mskipping: [localhost] => (item=None) [0m
[36mskipping: [localhost][0m

TASK [Check presence of custom Dockerfiles] ************************************
[32mok: [localhost] => (item={u'pre_build_image': True, u'name': u'centos', u'cgroupns_mode': u'host', u'image': u'geerlingguy/docker-centos8-ansible:latest', u'command': u'/usr/sbin/init', u'volumes': [u'/sys/fs/cgroup:/sys/fs/cgroup:rw'], u'privileged': True, u'override_command': False})[0m

TASK [Create Dockerfiles from image names] *************************************
[36mskipping: [localhost] => (item={u'pre_build_image': True, u'name': u'centos', u'cgroupns_mode': u'host', u'image': u'geerlingguy/docker-centos8-ansible:latest', u'command': u'/usr/sbin/init', u'volumes': [u'/sys/fs/cgroup:/sys/fs/cgroup:rw'], u'privileged': True, u'override_command': False})[0m

TASK [Discover local Docker images] ********************************************
[32mok: [localhost] => (item={u'item': {u'pre_build_image': True, u'name': u'centos', u'cgroupns_mode': u'host', u'image': u'geerlingguy/docker-centos8-ansible:latest', u'command': u'/usr/sbin/init', u'volumes': [u'/sys/fs/cgroup:/sys/fs/cgroup:rw'], u'privileged': True, u'override_command': False}, u'skipped': True, u'ansible_loop_var': u'item', u'skip_reason': u'Conditional result was False', u'i': 0, u'ansible_index_var': u'i', u'changed': False})[0m

TASK [Build an Ansible compatible image (new)] *********************************
[36mskipping: [localhost] => (item=molecule_local/geerlingguy/docker-centos8-ansible:latest)[0m

TASK [Create docker network(s)] ************************************************

TASK [Determine the CMD directives] ********************************************
[36mskipping: [localhost] => (item={u'pre_build_image': True, u'name': u'centos', u'cgroupns_mode': u'host', u'image': u'geerlingguy/docker-centos8-ansible:latest', u'command': u'/usr/sbin/init', u'volumes': [u'/sys/fs/cgroup:/sys/fs/cgroup:rw'], u'privileged': True, u'override_command': False})[0m

TASK [Create molecule instance(s)] *********************************************
[33mchanged: [localhost] => (item=centos)[0m

TASK [Wait for instance(s) creation to complete] *******************************
[1;30mFAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).[0m
[33mchanged: [localhost] => (item={u'ansible_loop_var': u'item', u'ansible_job_id': u'631416223294.50913', u'failed': False, u'started': 1, u'changed': True, u'item': {u'pre_build_image': True, u'name': u'centos', u'cgroupns_mode': u'host', u'image': u'geerlingguy/docker-centos8-ansible:latest', u'command': u'/usr/sbin/init', u'volumes': [u'/sys/fs/cgroup:/sys/fs/cgroup:rw'], u'privileged': True, u'override_command': False}, u'finished': 0, u'results_file': u'/root/.ansible_async/631416223294.50913'})[0m

PLAY RECAP *********************************************************************
[33mlocalhost[0m                  : [32mok=4   [0m [33mchanged=2   [0m unreachable=0    failed=0    [36mskipped=5   [0m rescued=0    ignored=0

[34mINFO    [0m [2;36mRunning [0m[2;32mdefault[0m[2;36m > [0m[2;32mprepare[0m
[31mWARNING [0m Skipping, prepare playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdefault[0m[2;36m > [0m[2;32mconverge[0m

PLAY [Converge] ****************************************************************

TASK [Include vector-role] *****************************************************

TASK [vector-role : Create group vector] ***************************************
[33mchanged: [centos][0m

TASK [vector-role : Add user vector] *******************************************
[33mchanged: [centos][0m

TASK [vector-role : Make sure Vector directory exists] *************************
[33mchanged: [centos][0m

TASK [vector-role : Make sure var Vector directory exists] *********************
[33mchanged: [centos][0m

TASK [vector-role : Unarchive Vector] ******************************************
[33mchanged: [centos][0m

TASK [vector-role : Copy vector to etc] ****************************************
[33mchanged: [centos][0m

TASK [vector-role : Copy vector.service file] **********************************
[33mchanged: [centos][0m

TASK [vector-role : Add vector.yaml file] **************************************
[33mchanged: [centos][0m

RUNNING HANDLER [vector-role : Restart and enable Vector service] **************
[33mchanged: [centos][0m

PLAY RECAP *********************************************************************
[33mcentos[0m                     : [32mok=9   [0m [33mchanged=9   [0m unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[34mINFO    [0m [2;36mRunning [0m[2;32mdefault[0m[2;36m > [0m[2;32midempotence[0m

PLAY [Converge] ****************************************************************

TASK [Include vector-role] *****************************************************

TASK [vector-role : Create group vector] ***************************************
[32mok: [centos][0m

TASK [vector-role : Add user vector] *******************************************
[32mok: [centos][0m

TASK [vector-role : Make sure Vector directory exists] *************************
[32mok: [centos][0m

TASK [vector-role : Make sure var Vector directory exists] *********************
[32mok: [centos][0m

TASK [vector-role : Unarchive Vector] ******************************************
[32mok: [centos][0m

TASK [vector-role : Copy vector to etc] ****************************************
[32mok: [centos][0m

TASK [vector-role : Copy vector.service file] **********************************
[32mok: [centos][0m

TASK [vector-role : Add vector.yaml file] **************************************
[32mok: [centos][0m

PLAY RECAP *********************************************************************
[32mcentos[0m                     : [32mok=8   [0m changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[34mINFO    [0m Idempotence completed successfully.
[34mINFO    [0m [2;36mRunning [0m[2;32mdefault[0m[2;36m > [0m[2;32mside_effect[0m
[31mWARNING [0m Skipping, side effect playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdefault[0m[2;36m > [0m[2;32mverify[0m
[34mINFO    [0m Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Get vector user info] ****************************************************
[32mok: [centos][0m

TASK [Get vector group info] ***************************************************
[32mok: [centos][0m

TASK [Get Vector service info] *************************************************
[32mok: [centos][0m

TASK [Get Vector configuration validation result] ******************************
[33mchanged: [centos][0m

TASK [Check if user exists] ****************************************************
[32mok: [centos] => {[0m
[32m    "changed": false, [0m
[32m    "msg": "All assertions passed"[0m
[32m}[0m

TASK [Check if vector user is in vector group] *********************************
[32mok: [centos] => {[0m
[32m    "changed": false, [0m
[32m    "msg": "All assertions passed"[0m
[32m}[0m

TASK [Check if Vector service started] *****************************************
[32mok: [centos] => {[0m
[32m    "changed": false, [0m
[32m    "msg": "All assertions passed"[0m
[32m}[0m

TASK [Check if Vector configuration is valid] **********************************
[32mok: [centos] => {[0m
[32m    "changed": false, [0m
[32m    "msg": "All assertions passed"[0m
[32m}[0m

PLAY RECAP *********************************************************************
[33mcentos[0m                     : [32mok=8   [0m [33mchanged=1   [0m unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[34mINFO    [0m Verifier completed successfully.
[34mINFO    [0m [2;36mRunning [0m[2;32mdefault[0m[2;36m > [0m[2;32mcleanup[0m
[31mWARNING [0m Skipping, cleanup playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdefault[0m[2;36m > [0m[2;32mdestroy[0m

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
[33mchanged: [localhost] => (item=centos)[0m

TASK [Wait for instance(s) deletion to complete] *******************************
[1;30mFAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).[0m
[33mchanged: [localhost] => (item=centos)[0m

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
[33mlocalhost[0m                  : [32mok=2   [0m [33mchanged=2   [0m unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m Pruning extra files from scenario ephemeral directory
Finished: SUCCESS
</code>
</details>

Создан следующий declarative pipeline:

```
pipeline {
    agent any
    stages {
        stage("Prepare files") {
            steps {
                dir ('vector-role') {
                    git branch: 'main', url: 'https://github.com/RedRatInTheHat/vector-role.git'
                }
            }
        }
        stage("Build") {
            steps {
                dir ('vector-role') {
                    sh 'python3 -m molecule test'
                }
            }
        }
    }
}
```

Также успешно отрабатывает:

![alt text](images/2.png)

![alt text](images/4.png)

Скрипт перенесён в [репозиторий vector-role](https://github.com/RedRatInTheHat/vector-role/blob/main/Jenkinsfile), для declarative pipline подключено обращение в репозиторий:

![alt text](images/5.png)

Создан multibranch pipeline. Какой-то особой конфигруации не создавалось, просто репозиторий vector-role. Pipeline отрабатывает успешно:

![alt text](images/6.png)

![alt text](images/7.png)

Scripted pipeline изменён для скачивания не через ssh, ноде-агенту добавлена метка linux, в скрипт добавлено изменение поведения в зависимости от переменной prod_run:

```
node("linux"){
    stage("Git checkout"){
        git 'https://github.com/aragastmatb/example-playbook.git'
    }
    stage("Sample define secret_check"){
        secret_check=true
        prod_run = true
    }
    stage("Run playbook"){
        if (secret_check){
            additional_parameters = prod_run ? "" : "--check --diff"
            sh "ansible-playbook site.yml ${ additional_parameters } -i inventory/prod.yml"
        }
        else{
            echo 'need more action'
        }
        
    }
}
```

prod_run == false:

![alt text](images/8.png)

prod_run == true:

![alt text](images/9.png)

Скрипт добавлен в файл [ScriptedJenkinsfile](https://github.com/RedRatInTheHat/vector-role/blob/main/ScriptedJenkinsfile).

---

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, завершившиеся хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением и названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline так, чтобы он мог сначала запустить через Yandex Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Мы должны при нажатии кнопки получить готовую к использованию систему.

#TODO когда-нибудь
