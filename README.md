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

### 3. Terraform

3.1 Clonar repositório:
  ```Bash
  git clone https://github.com/seu-usuario/devops-iac.git
  cd devops-iac/terraform
  ```
3.2 Inicializar e configurar Terraform:
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
  Ao finalizar o apply, o terminal vai mostrar o IP Público da instância para acessar via SSH:
  ```Bash
  ssh -i ~/.ssh/nome-da-chave.pem ubuntu@SEU_IP_PUBLICO
  ```

### Finalização da Utilização
  Ao finalizar de utilizar e para reduzir custos na conta AWS, executar a seguinte linha para encerrar o provisionamento da aplicação:
  ```Bash
  terraform destroy
  ```
