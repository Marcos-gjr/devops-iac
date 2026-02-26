# DevOps-IaC
Infraestrutura como Código (IaC) na AWS utilizando Terraform e Ansible para ambientes escaláveis focados nos sistemas free tier da AWS.

# Stack de Tecnologias

* WSL2 (Ubuntu 22.04) - Caso esteja utilizando Windows
* Terraform (v1.5+)
* AWS CLI
* Git


# Como Rodar

Para rodar o projeto será necessário possuir uma conta na AWS e realizar as seguintes configurações:

### 1. Configuração da Conta AWS
1.1 Criação do usuário IAM
 1. No console AWS, vá em IAM > Users > Create User.
 2. Adicione o nome.
 3. Na aba Permissions, escolha Attach policies directly e pesquise AmazonEC2FullAccess.
 4. Clique em Create access key.
 5. Salve a Access Key e o Secret Access Key.

1.2 Criação da Key Pair (Ou chave SSH)
 1. Vá até o EC2 > Key Pairs > Create key pair
 2. Adicione o nome.
 3. Coloque no formato .pem.
 4. E cerfique qe a região é a mesma utilizada no projeto todo.

### 2. Configuração do ambiente local
2.1 Configuração do AWS CLI
  Rodar o seguinte no terminal WSL2:
  ```Bash
  aws configure
  ```
  Coloque então as chaves criadas na IAM, no passo 1.1, região como us-east-1 (ou a que está utilizando no projeto) e formato como json.

2.2 Configurar a chave SSH
  Mover a chave baixada para a pasta linux:
  ```Bash
  mkdir -p ~/.ssh #Caso não tiver a pasta criada, se tiver ignorar essa linha
  cp /caminho/do/windows/nome-da-chave.pem ~/.ssh/
  chmod 400 ~/.ssh/nome-da-chave.pem
  ```
  O comando chmod 400 vai garantir que somente seu usuário possa ler a chave.

2.3 Variáveis de Ambiente  
  Na raiz do projeto você verá um arquivo de exemplo '.env.example', esse arquivo possui todas as variáveis de ambiente utilizadas para o funcionamento do projeto em questão, após renomear o arquivo para '.env' e adicionar o valor das variáveis em questão, sempre que for rodar ```terraform apply```, abrir um novo terminal ou atualizar algum valor no arquivo de variáveis de ambiente, rodar o comando:
  ```Bash
  touch .env
  ```
  Dessa forma as variáveis de ambiente atualizarão no terminal, onde serão coletadas pelo terraform e ansible.

### 3. Terraform
  O Terraform irá provisionar o ambiente em nuvem com a máquina virtual com o SO (neste projeto) do Ubuntu 22.04.
3.1 Clonar repositório:
  ```Bash
  git clone https://github.com/seu-usuario/devops-iac.git
  cd devops-iac/terraform
  ```
3.2 Inicializar e configurar Terraform:
  Acessar a pasta do Terraform:
  ```Bash
  cd terraform
  ```
  Baixa os plugins da AWS
  ```Bash
  terraform init
  ```

  Verifica o que será criado ao executar
  ```Bash
  terraform plan
  ```

  Aplicar a infraestrutura:
  ```Bash
  terraform apply
  ```
  E digite Yes para confirmar.

### Verificação do Acesso
  Ao finalizar o apply, o terminal vai mostrar o IP Público da instância para acessar via SSH com o seguinte comando:
  ```Bash
  ssh -i ~/.ssh/nome-da-chave.pem ubuntu@SEU_IP_PUBLICO
  ```
  Após isso realizar atualização do valor no arquivo '.env'

### Finalização da Utilização
  Ao finalizar de utilizar e para reduzir custos na conta AWS, executar a seguinte linha para encerrar o provisionamento da aplicação:
  ```Bash
  terraform destroy
  ```

### 4. Ansible 
  Depois do provisionamento da instância com o Terraform, o Ansible será utilizado para instalar o Docker e preparar o ambiente.
4.1 Acessar pasta do Ansible:
  ```Bash
  cd ../ansible
  ```
4.2 Após certificar que o valor do 'PUBLIC_ID' foi alterado no arquivo '.env' com o IP gerado pelo Terraform, testar a conexão com o servidor:
  ```Bash
  ansible aws_servers -m ping -i hosts.ini
  ```
  Caso retorne "pong", a conexão está funcional.

4.3 Execute o Playbook para instalar o Docker:
  ```Bash
  ansible-playbook -i hosts.ini setup.yml
  ```

