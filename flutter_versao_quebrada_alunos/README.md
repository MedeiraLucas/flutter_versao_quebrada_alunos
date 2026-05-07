# Otimização de Performance com Listas no Flutter

**Autor:** Lucas Medeira  
**Projeto:** Refatoração de Renderização e Gestão de Memória (Aula 11)

---

## 📌 Sobre o Projeto
Este repositório documenta a refatoração de uma tela em Flutter que apresentava sérios problemas de lentidão e alto consumo de memória. O objetivo foi aplicar boas práticas para otimizar o processamento da CPU e o uso da memória RAM em listas longas com imagens.

---

## 🔄 O Que Foi Alterado (Antes vs. Depois)

| Componente | Código Original (Ruim) | Código Refatorado (Bom) |
| :--- | :--- | :--- |
| **Estrutura da Lista** | `SingleChildScrollView` + `Column` | `ListView.builder` |
| **Renderização de Imagem** | `Image.network` | `CachedNetworkImage` (com `memCacheWidth`) |
| **Gestão de Rebuilds** | Instanciação dinâmica | Uso estratégico do modificador `const` |

---

## 🧠 Explicação das Melhorias

Abaixo estão detalhados os conceitos técnicos aplicados para resolver os problemas de performance do aplicativo:

### 1. Transição de Eager Loading para Lazy Loading
* **O Problema:** A combinação de `SingleChildScrollView` com `Column` forçava a *Engine* do Flutter a carregar e desenhar todos os 200 itens da lista na memória instantaneamente (Eager Loading), travando o aplicativo logo na abertura.
* **A Melhoria:** A substituição pelo `ListView.builder` implementou o conceito de *Lazy Loading* (carregamento preguiçoso). Agora, o aplicativo só processa e aloca na memória os itens que estão fisicamente visíveis na tela do usuário. Conforme a rolagem acontece, os itens que somem da tela são destruídos e os novos são gerados, mantendo o consumo de CPU e RAM estabilizado.

### 2. Controle de RAM e Cache de Imagens
* **O Problema:** O `Image.network` baixava as 200 imagens e as jogava na memória RAM na resolução máxima original (ex: 800x600). Isso gerava picos de consumo que facilmente causariam o fechamento inesperado do aplicativo por falta de memória (*Out of Memory - OOM*).
* **A Melhoria:** A implementação do pacote `cached_network_image` resolveu dois problemas. Primeiro, ele salva as imagens no armazenamento local para evitar o download repetido das mesmas fotos. Segundo, utilizando a propriedade `memCacheWidth`, a imagem é redimensionada antes de ir para a memória RAM. Isso alivia a carga do sistema operacional de forma drástica.

### 3. Prevenção de Rebuilds Desnecessários
* **O Problema:** Espaçamentos e margens estáticas (como `Padding` e `SizedBox`) eram recriados na memória repetidas vezes caso houvesse qualquer atualização na tela.
* **A Melhoria:** A aplicação do modificador `const` sinaliza ao Flutter que aqueles elementos são imutáveis. Dessa forma, o sistema reaproveita a mesma instância já existente na memória, economizando ciclos de processamento da CPU e ajudando a manter a fluidez da animação em 60 FPS (quadros por segundo).